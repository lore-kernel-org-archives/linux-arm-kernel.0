From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 14:48:53 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386855390.22947.68.camel@sakura.staff.proxad.net>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
Message-ID: <20131212144853.GO4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 02:36:30PM +0100, Maxime Bizon wrote:
> 
> On Thu, 2013-12-12 at 12:40 +0000, Russell King - ARM Linux wrote:
> 
> > Depends which swab16 you mean by "dumb swab16".  If it is a gcc bug then
> 
> that one:
> 
> #define __swab16(x) ((uint16_t)(                                      \
>         (((uint16_t)(x) & (uint16_t)0x00ffU) << 8) |                  \
>         (((uint16_t)(x) & (uint16_t)0xff00U) >> 8)))
> 
> usually expands to this:
> 
>   24:	e1a00800 	lsl	r0, r0, #16
>   28:	e1a03c20 	lsr	r3, r0, #24
>   2c:	e1833420 	orr	r3, r3, r0, lsr #8
>   30:	e1a03803 	lsl	r3, r3, #16
>   34:	e1a00823 	lsr	r0, r3, #16
> 
> but in my case, the two last shifts are missing.
> 
> > you need to submit a bug report to gcc people.
> 
> but is it for sure ?

Well, in the above code, we're being quite explicit about wanting only
bits 7-0 to be moved to bits 15-8, whereas what the compiler is actually
doing is moving bits 15-0 to 23-8.

In other words, the compiler has completely lost sight of that & 0x00ff
in there.

> I couldn't find any working gcc version so it does not look like a
> regression, hence my doubt.

Well, looking at the builds I have here, it seems that my gcc also
produces wrong code here in __udp4_lib_rcv(), which makes me wonder
how NFS works.  Ah, that's how - in the standard kernel, it's not
"len" which usually gets swabbed, it's the protocol ID - which for
UDP is 17.  __swab16(17) produces 0x1100 even with the bug.

Even so, the code _is_ buggy, because if the protocol value had bits
15-8 set, then this would go wrong for all the same reasons that
you've found.  GCC is definitely ignoring the outter (uint16_t) cast
in the above.

So yes, afaics it's a GCC bug which appears to affect many GCC versions.

The question is... what to do about this.  I don't think we want to wait
for a gcc version to be fixed...
