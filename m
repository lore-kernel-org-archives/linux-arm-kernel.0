From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Aug 2012 22:07:09 +0100
Subject: imx6q restart is broken
In-Reply-To: <CAKGA1b=--C_MEHgc4m2f4cQwkx-=njss7bpT+EzXgKZJ2v=+Hw@mail.gmail.com>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk>
 <CAKGA1b=--C_MEHgc4m2f4cQwkx-=njss7bpT+EzXgKZJ2v=+Hw@mail.gmail.com>
Message-ID: <20120809210709.GV18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 02:03:13PM -0500, Matt Sealey wrote:
> I have an irrelevant but possibly related question here; in
> mm/proc-v7.S there's this snip of code;
> 
> #ifdef CONFIG_SMP
>         ALT_SMP(mrc     p15, 0, r0, c1, c0, 1)
>         ALT_UP(mov      r0, #(1 << 6))          @ fake it for UP
>         tst     r0, #(1 << 6)                   @ SMP/nAMP mode enabled?
>         orreq   r0, r0, #(1 << 6)               @ Enable SMP/nAMP mode
>         orreq   r0, r0, r10                     @ Enable CPU-specific SMP bits
>         mcreq   p15, 0, r0, c1, c0, 1
> #endif
> 
> Which I am reading as, read the SMP bit from cp15 and see if it's
> enabled, or on UP set the SMP bit and then write it back
> regardless.
> 
> On a system where !CONFIG_SMP but it's SMP-capable like i.MX6Q, ALT_UP
> method will get used and the SMP bit will get
> set regardless.

I got here and stopped reading any further.  No, it doesn't work like
that; you don't understand the assembly.

Yes, you're right that the ALT_UP version will be used.  This sets r0
to 1 << 6.  The very next instruction tests whether bit 6 is set in r0.
The following three instructions will only be executed _if_ that bit
was zero.

I'm assuming that the rest of your email is therefore irrelevant; I
have no desire to continue reading such a long message when the premise
it's (presumably) based upon is false.  If you have any further questions
please restate them succinctly after taking on board the above.  Thanks.
