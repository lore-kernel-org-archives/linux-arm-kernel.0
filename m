From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 13:48:27 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386855390.22947.68.camel@sakura.staff.proxad.net> (Maxime
 Bizon's message of "Thu, 12 Dec 2013 14:36:30 +0100")
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
Message-ID: <yw1xppp2ji38.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Thu, 2013-12-12 at 12:40 +0000, Russell King - ARM Linux wrote:
>
>> Depends which swab16 you mean by "dumb swab16".  If it is a gcc bug then
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
>> you need to submit a bug report to gcc people.
>
> but is it for sure ?
>
> I couldn't find any working gcc version so it does not look like a
> regression, hence my doubt.
>
> basically if you use inline asm with a variable that is smaller than
> register width (32 bits here), can you assume the value in the register
> will be zero extended ? I could not find the answer in the gcc manual.

In the code above, the outer (uint16_t) cast should clear the top half,
as should passing the value to a function (inline doesn't alter the
semantics) as a 16-bit type, so there's something fishy here.

Which gcc versions did you try?

-- 
M?ns Rullg?rd
mans at mansr.com
