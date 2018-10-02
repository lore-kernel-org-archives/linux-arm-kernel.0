From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 2 Oct 2018 07:39:06 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
 <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
Message-ID: <CAKv+Gu94x+pPp_CrPYj=3aFb6fDcZKM9MficvKkkfXhDib2sYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2018 at 05:53, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Arnd,
>
> Apologies for the delay in getting back to you. I had some MTA issues
> and stupidly assumed ARM developers were taking the day off instead...
>
> On Tue, Oct 2, 2018 at 5:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
>> +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m
>
> Unfortunately this doesn't really cut it in my case, as it's not only
> those multiplications:
> chacha20-arm.S:402: Error: selected processor does not support `bxeq
> lr' in ARM mode
>

We have a macro for doing function returns: just replace 'bxeq lr'
with 'reteq lr' (and be sure to include <asm/assembler.h>)


> I think we're going to wind up playing whack-a-mole in silly ways. The
> fact of the matter is that the ARM assembly I'm adding to the tree is
> for ARMv4 and up, and not for ARMv3.
>
> I think there are three options to work around this issue:
>
> 1) Not build my assembly when CONFIG_CPU_32v3 via a Kconfig "depends".
> 2) Set asflags-$(CONFIG_CPU_32v3) inside my module locally to select
> -march=armv4.
> 3) This patch.
>
> My initial plan was (1). ArdB recommended I do (2) instead. I thought
> that was a bit too nuanced and submitted (3).
>
> It sounds like in light of the bus issues, (1) might be the best
> solution after all?
>
> Let me know, and I'll follow your direction.
>
> Regards,
> Jason
