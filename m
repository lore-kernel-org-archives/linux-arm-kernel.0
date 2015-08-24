From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Aug 2015 15:02:53 +0200
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <55D497FC.9060506@gmail.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <CACRpkdaRJJjCXR=vK1M2YhR26JZfGoBB+jcqz8r2MhERfxRzqA@mail.gmail.com>
 <CAPAsAGy-r8Z2N09wKV+e0kLfbwxd-eWK6N5Xajsnqq9jfyWqcQ@mail.gmail.com>
 <CACRpkdZmHLMxosLXjyOPdkavo=UNzmTcHOLF5vV4cS1ULfbq6A@mail.gmail.com>
 <CAPAsAGw-iawTpjJh66rQN5fqBFT6UBZCcv2eKx7JTqCXzhzpsw@mail.gmail.com>
 <CACRpkdY2i2M27gP_fXawkFrC_GFgWaKr5rEn6d47refNPiEk=g@mail.gmail.com>
 <55AE56DB.4040607@samsung.com>
 <CACRpkdYaqK8upK-3b01JbO_y+sHnk4-Hm1MfvjSy0tKUkFREtQ@mail.gmail.com>
 <55AFD8D0.9020308@samsung.com>
 <CACRpkdaJVRuLTCh585rLEjua2TpnLsALhLdu0ma56TBA=C+EiQ@mail.gmail.com>
 <55D497FC.9060506@gmail.com>
Message-ID: <CACRpkdYL7R+WKfGZwmM7NGqvY8Arc_B3ekbUhkr7VPbQzAdZVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 4:51 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> On 08/19/2015 03:14 PM, Linus Walleij wrote:

>> Integrator/AP (ARMv5):
>>
>> This one mounted with an ARMv5 ARM926 tile. It boots nicely
>> (but takes forever) with KASan and run all test cases (!) just like
>> for the other platforms but before reaching userspace this happens:
>
> THREAD_SIZE hardcoded in act_mm macro.
>
> This hack should help:
>
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index c671f34..b1765f2 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -32,6 +32,9 @@
>         .macro  act_mm, rd
>         bic     \rd, sp, #8128
>         bic     \rd, \rd, #63
> +#ifdef CONFIG_KASAN
> +       bic     \rd, \rd, #8192
> +#endif
>         ldr     \rd, [\rd, #TI_TASK]
>         ldr     \rd, [\rd, #TSK_ACTIVE_MM]
>         .endm

Yes this work, thanks! I now get to userspace.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

I have compiled Trinity and running some stress on different boards.
The ARMv7 seems to rather die from random nasty stuff from the
syscall or OOM rather than any KASan-detected bugs, but I'll
keep hammering at it a big.

I have some odd patch I'll pass along.

Yours,
Linus Walleij
