From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 14:26:46 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386857410.22947.78.camel@sakura.staff.proxad.net> (Maxime
 Bizon's message of "Thu, 12 Dec 2013 15:10:10 +0100")
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
Message-ID: <yw1xlhzqjgbd.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Thu, 2013-12-12 at 13:48 +0000, M?ns Rullg?rd wrote:
>
>> In the code above, the outer (uint16_t) cast should clear the top half,
>> as should passing the value to a function (inline doesn't alter the
>> semantics) as a 16-bit type, so there's something fishy here.
>
> using __attribute__((noinline)), or putting the function in another file
> makes the bug disappear
>
> But I'm not convinced inline doesn't change the semantic, since gcc is
> merging the function inside another one the rules of calling convention
> should not matter anymore.

Function inlining is just an optimisation and like any optimisation it
must not alter the semantics of the program.  What happens inside the
function also should not matter.

> I attached a second test case without a separate function that has the
> same bug.
>
>> Which gcc versions did you try?
>
> 4.3.2, 4.6.0, 4.7.2, 4.8-2013 (linaro)

That's a decent spread.  Recently, I don't recall the exact version, gcc
started recognising typical byte-reverse patters, which could have been
related to this, but since it goes back to 4.3, that seems not to be the
case.

> Here is a simple userspace test case.
>
> #include <stdint.h>
> #include <stdio.h>
>
> static inline uint32_t asm_add(uint16_t len, uint32_t sum)
> {
>         __asm__(
>         "add    %0, %1, %2 \n"
>         : "=&r"(sum)
>         : "r" (sum), "r" (len)
>         );
>         return sum;
> }
>
> #define local_swab16(x) ((uint16_t)(                                    \
>         (((uint16_t)(x) & (uint16_t)0x00ffU) << 8) |                  \
>         (((uint16_t)(x) & (uint16_t)0xff00U) >> 8)))
>
> int main(int argc, char *argv[])
> {
>         uint16_t foo;
>
>         foo = strtoul(argv[1], NULL, 0);
>         printf("%08x\n", asm_add(local_swab16(foo), 0));
>         return 0;
> }
>
> without optimization, or with noinline:
>
> # ./a.out 0x3412
> 00001234
>
> with optimization:
>
> # ./a.out 0x3412
> 00341234

This looks like a gcc bug to me.  Report it in the gcc bugzilla and
see what they say.

-- 
M?ns Rullg?rd
mans at mansr.com
