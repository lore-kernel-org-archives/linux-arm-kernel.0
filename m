From: w@1wt.eu (Willy Tarreau)
Date: Thu, 12 Dec 2013 18:11:08 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212164748.GS4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
 <20131212160426.GD31816@1wt.eu>
 <20131212164748.GS4360@n2100.arm.linux.org.uk>
Message-ID: <20131212171108.GA2337@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 04:47:48PM +0000, Russell King - ARM Linux wrote:
> > Then changing the type of the function argument would probably be safer!
> 
> Actually, I think we can do a bit better with this code.  We really don't
> need much of this messing around here, we can combine some of these steps.
> 
> We have:
> 
> 16-bit protocol in host endian
> 16-bit length in host endian
> 
> and we need to combine them into a 32-bit checksum which is then
> subsequently folded down to 16-bits by adding the top and bottom halves.
> 
> Now, what we can do is this:
> 
> 1. Construct a combined 32-bit protocol and length:
> 
> 	unsigned lenproto = len | proto << 16;
> 
> 2. Pass this into the assembly thusly:
> 
>                 __asm__(
>                 "adds   %0, %1, %2      @ csum_tcpudp_nofold    \n\t"
>                 "adcs   %0, %0, %3                              \n\t"
> #ifdef __ARMEB__
>                 "adcs   %0, %0, %4                              \n\t"
> #else
>                 "adcs   %0, %0, %4, ror #8                      \n\t"
> #endif
>                 "adc    %0, %0, #0"
>                 : "=&r"(sum)
>                 : "r" (sum), "r" (daddr), "r" (saddr), "r" (lenprot)
>                 : "cc");
> 
> with no swabbing at this stage.  Well, where do we get the endian
> conversion?  See that ror #8 - that a 32 bit rotate by 8 bits.  As
> these are two 16-bit quantities, we end up with this:
> 
> original:
> 	31..24	23..16	15..8	7..0
> 	len_h	len_l	pro_h	pro_l
> 
> accumulated:
> 	31..24	23..16	15..8	7..0
> 	pro_l	len_h	len_l	pro_h
> 
> And now when we fold it down to 16-bit:
> 
> 			15..8	7..0
> 			len_l	pro_h
> 			pro_l	len_h

Amusing, I've used the same optimization yesterday when computing a
TCP pseudo-header checksum.

Another thing that can be done to improve the folding of the 16-bit
checksum is to swap the values to be added, sum them and only keep
the high half integer which already contains the carry. At least on
x86 I save some cycles doing this :

              31:24  23:16  15:8  7:0
     sum32 =    D      C      B    A

     To fold this into 16-bit at a time, I just do this :

                   31:24     23:16          15:8  7:0
     sum32           D         C              B    A
  +  sum32swapped    B         A              D    C
  =                 A+B  C+A+carry(B+D/C+A)  B+D  C+A

so just take the upper result and you get the final 16-bit word at
once.

In C it does :

       fold16 = (((sum32 >> 16) | (sum32 << 16)) + sum32) >> 16

When the CPU has a rotate instruction, it's fast :-)

Cheers,
Willy
