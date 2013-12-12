From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 16:47:48 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212160426.GD31816@1wt.eu>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
 <20131212160426.GD31816@1wt.eu>
Message-ID: <20131212164748.GS4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 05:04:26PM +0100, Willy Tarreau wrote:
> On Thu, Dec 12, 2013 at 03:41:10PM +0000, Russell King - ARM Linux wrote:
> > One of the issues here is that internally, GCC tracks the "machine mode"
> > of a register, where "mode" basically means the type of register it is.
> > In this case, the register will be in "half integer" mode when it is
> > passed into the assembler, and gcc does _not_ promote it.
> > 
> > We can see this in the RTL:
> > 
> > (insn 11 10 12 3 ../t.c:9 (set (reg:SI 143 [ sum ])
> >         (asm_operands:SI ("mov  %0, %1") ("=&r") 0 [
> >                 (subreg:HI (reg:SI 148) 0)
> >             ]
> >              [
> >                 (asm_input:HI ("r") (null):0)
> >             ]
> >              [] ../t.c:12)) -1 (nil))
> > 
> > Note that "HI" for the input register 148.  What this means is that the
> > compiler "knows" that it's supposed to be a 16-bit quantity, and has
> > recorded that fact, and _will_ truncate it down to 16-bit when it needs
> > to be promoted.
> > 
> > Since the asm() only asks for a "register", that's what we get - a
> > register which _happens_ to be in HI mode containing the value.  However,
> > there's no way to tell that from the assembly code itself (GCC doesn't
> > have the facility to do conditional assembly generation depending on
> > the argument type passed into it.)
> 
> OK so that means that it's just like having true 16-bit registers except
> that it's just a temporary representation and not a feature of the CPU.
> The compiler has the right to expect the asm instructions to only use
> the lower 16 bits and has no way to verify that.

Quite.

> Then changing the type of the function argument would probably be safer!

Actually, I think we can do a bit better with this code.  We really don't
need much of this messing around here, we can combine some of these steps.

We have:

16-bit protocol in host endian
16-bit length in host endian

and we need to combine them into a 32-bit checksum which is then
subsequently folded down to 16-bits by adding the top and bottom halves.

Now, what we can do is this:

1. Construct a combined 32-bit protocol and length:

	unsigned lenproto = len | proto << 16;

2. Pass this into the assembly thusly:

                __asm__(
                "adds   %0, %1, %2      @ csum_tcpudp_nofold    \n\t"
                "adcs   %0, %0, %3                              \n\t"
#ifdef __ARMEB__
                "adcs   %0, %0, %4                              \n\t"
#else
                "adcs   %0, %0, %4, ror #8                      \n\t"
#endif
                "adc    %0, %0, #0"
                : "=&r"(sum)
                : "r" (sum), "r" (daddr), "r" (saddr), "r" (lenprot)
                : "cc");

with no swabbing@this stage.  Well, where do we get the endian
conversion?  See that ror #8 - that a 32 bit rotate by 8 bits.  As
these are two 16-bit quantities, we end up with this:

original:
	31..24	23..16	15..8	7..0
	len_h	len_l	pro_h	pro_l

accumulated:
	31..24	23..16	15..8	7..0
	pro_l	len_h	len_l	pro_h

And now when we fold it down to 16-bit:

			15..8	7..0
			len_l	pro_h
			pro_l	len_h

There we go - the low and high bytes end up correctly placed.  Now, the
advantage to having "len" and "proto" combined by the compiler is that
the compiler itself can make the decision about how to combine these two
16-bit HI-mode quantities in the most efficient way.

Here's some examples from udp.c - I have another optimisation in here
too which makes this code sequence slightly shorter.  Some intermediary
instructions have been omitted.

        mov     r6, r6, asl #16 @ tmp204, len,
        mov     r6, r6, lsr #16 @ tmp203, tmp204,
        orr     r6, r6, #1114112        @ tmp205, tmp203,
@ 92 "/home/rmk/git/linux-rmk/arch/arm/include/asm/checksum.h" 1
        adds    r3, r8, r7      @ csum_tcpudp_nofold0           @ sum, dst, src
        adcs    r3, r3, r6, ror #8                              @ sum, tmp205
        adc     r3, r3, #0      @ sum


        mov     r6, r6, asl #16 @ tmp220, len,
        mov     r6, r6, lsr #16 @ tmp219, tmp220,
        orr     r6, r6, #1114112        @ tmp221, tmp219,
@ 104 "/home/rmk/git/linux-rmk/arch/arm/include/asm/checksum.h" 1
        adds    r3, r0, r8      @ csum_tcpudp_nofold            @ sum,, dst
        adcs    r3, r3, r7                                      @ sum, src
        adcs    r3, r3, r6, ror #8                              @ sum, tmp221
        adc     r3, r3, #0      @ sum

Note this one sourcing an 8-bit protocol value.

        ldrb    r3, [r7, #269]  @ zero_extendqisi2      @ tmp321, sk_5->sk_protocol
        orr     sl, sl, r3, asl #16     @, tmp324, D.48540, tmp321,
@ 104 "/home/rmk/git/linux-rmk/arch/arm/include/asm/checksum.h" 1
        adds    r3, r0, r2      @ csum_tcpudp_nofold            @ sum, csum, fl4_19(D)->daddr
        adcs    r3, r3, r1                                      @ sum, fl4_19(D)->saddr
        adcs    r3, r3, sl, ror #8                              @ sum, tmp324
        adc     r3, r3, #0      @ sum


        ldrh    lr, [r4, #76]   @ tmp503, skb_10(D)->len
        orr     lr, lr, r7, asl #16     @, tmp505, tmp503, proto,
@ 104 "/home/rmk/git/linux-rmk/arch/arm/include/asm/checksum.h" 1
        adds    r1, sl, r0      @ csum_tcpudp_nofold            @ sum, skb_10(D)->D.22802.csum, iph_354->daddr
        adcs    r1, r1, ip                                      @ sum, iph_354->saddr
        adcs    r1, r1, lr, ror #8                              @ sum, tmp505
        adc     r1, r1, #0      @ sum


        ldrh    r0, [r4, #76]   @ tmp529, skb_10(D)->len
        orr     r0, r0, r7, asl #16     @, tmp531, tmp529, proto,
@ 92 "/home/rmk/git/linux-rmk/arch/arm/include/asm/checksum.h" 1
        adds    r3, r2, r1      @ csum_tcpudp_nofold0           @ sum, iph_354->daddr, iph_354->saddr
        adcs    r3, r3, r0, ror #8                              @ sum, tmp531
        adc     r3, r3, #0      @ sum

This one is a little more complicated because it uses skb->len - we
can see the narrowing cast being performed:

        ldr     r0, [r4, #76]   @ skb_1->len, skb_1->len
        rsb     r0, r9, r0      @ tmp335, D.53494, skb_1->len
        mov     r0, r0, asl #16 @ tmp337, tmp335,
        mov     r0, r0, lsr #16 @ tmp336, tmp337,
        orr     r0, r0, #1114112        @ tmp338, tmp336,
@ 92 "/home/rmk/git/linux-rmk/arch/arm/include/asm/checksum.h" 1
        adds    r3, r2, r1      @ csum_tcpudp_nofold0           @ sum, iph_252->daddr, iph_252->saddr
        adcs    r3, r3, r0, ror #8                              @ sum, tmp338
        adc     r3, r3, #0      @ sum

Looking at whether it's better to shift len or proto to the upper 16 bits
reveals no real advantage to either: we end up with the same overall number
of instructions between the UDP and TCP code combined, individually there's
only one line between them.

So here's a patch for Maxime to try - I've not run it yet but it seems to
do the right thing by code inspection.

diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index 6dcc16430868..523315115478 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -87,19 +87,34 @@ static inline __wsum
 csum_tcpudp_nofold(__be32 saddr, __be32 daddr, unsigned short len,
 		   unsigned short proto, __wsum sum)
 {
-	__asm__(
-	"adds	%0, %1, %2		@ csum_tcpudp_nofold	\n\
-	adcs	%0, %0, %3					\n"
+	u32 lenprot = len | proto << 16;
+
+	if (__builtin_constant_p(sum) && sum == 0) {
+		__asm__(
+		"adds	%0, %1, %2	@ csum_tcpudp_nofold0	\n\t"
 #ifdef __ARMEB__
-	"adcs	%0, %0, %4					\n"
+		"adcs	%0, %0, %3				\n\t"
 #else
-	"adcs	%0, %0, %4, lsl #8				\n"
+		"adcs	%0, %0, %3, ror #8			\n\t"
 #endif
-	"adcs	%0, %0, %5					\n\
-	adc	%0, %0, #0"
-	: "=&r"(sum)
-	: "r" (sum), "r" (daddr), "r" (saddr), "r" (len), "Ir" (htons(proto))
-	: "cc");
+		"adc	%0, %0, #0"
+		: "=&r" (sum)
+		: "r" (daddr), "r" (saddr), "r" (lenprot)
+		: "cc");
+	} else {
+		__asm__(
+		"adds	%0, %1, %2	@ csum_tcpudp_nofold	\n\t"
+		"adcs	%0, %0, %3				\n\t"
+#ifdef __ARMEB__
+		"adcs	%0, %0, %4				\n\t"
+#else
+		"adcs	%0, %0, %4, ror #8			\n\t"
+#endif
+		"adc	%0, %0, #0"
+		: "=&r"(sum)
+		: "r" (sum), "r" (daddr), "r" (saddr), "r" (lenprot)
+		: "cc");
+	}
 	return sum;
 }	
 /*
