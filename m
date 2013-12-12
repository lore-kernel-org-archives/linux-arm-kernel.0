From: w@1wt.eu (Willy Tarreau)
Date: Thu, 12 Dec 2013 15:19:26 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386857410.22947.78.camel@sakura.staff.proxad.net>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
Message-ID: <20131212141926.GA31816@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, Dec 12, 2013 at 03:10:10PM +0100, Maxime Bizon wrote:
> 
> On Thu, 2013-12-12 at 13:48 +0000, M?ns Rullg?rd wrote:
> 
> > In the code above, the outer (uint16_t) cast should clear the top half,
> > as should passing the value to a function (inline doesn't alter the
> > semantics) as a 16-bit type, so there's something fishy here.
> 
> using __attribute__((noinline)), or putting the function in another file
> makes the bug disappear
> 
> But I'm not convinced inline doesn't change the semantic, since gcc is
> merging the function inside another one the rules of calling convention
> should not matter anymore.

I disagree here, since gcc may decide by itself to inline or not, it must
not impact the validity of the emitted code. Inline functions have input
and output types for a reason!

(...)
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

Hmmm aren't you passing a 16-bit register directly to the ASM for being used
as a 32-bit one ? This seems hasardous to me since nowhere you tell gcc how
you're going to use the register.

Could you check if that fixes it :

 static inline uint32_t asm_add(uint16_t len, uint32_t sum)
 {
         uint32_t len32 = len;

         __asm__(
         "add    %0, %1, %2 \n"
         : "=&r"(sum)
         : "r" (sum), "r" (len32)
         );
         return sum;
 }

Or maybe simply :

 static inline uint32_t asm_add(uint16_t len, uint32_t sum)
 {
         __asm__(
         "add    %0, %1, %2 \n"
         : "=&r"(sum)
         : "r" (sum), "r" (uint32_t)(len)
         );
         return sum;
 }

Willy
