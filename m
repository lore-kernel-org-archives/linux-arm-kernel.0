From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Sun, 28 Oct 2012 21:28:44 +0100
Subject: [PATCH] spi/pl022: Activate resourses before deactivate them in
 suspend
In-Reply-To: <CACRpkdbCfxnSSLR6GoSbAxtfnwOivxCCrLtwnR=9tpwpfACqTQ@mail.gmail.com>
References: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
 <20121027214642.GH4564@opensource.wolfsonmicro.com>
 <CACRpkdbCfxnSSLR6GoSbAxtfnwOivxCCrLtwnR=9tpwpfACqTQ@mail.gmail.com>
Message-ID: <CAPDyKFoOJz6608b4z2PoW8ODvTJVZRq-yB0itfXnuoXdR1SpGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2012 20:52, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Oct 27, 2012 at 11:46 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:
>>
>>> To be able to deactivate resourses in suspend, the resourses must
>>> first be surely active. This is done with a pm_runtime_get_sync.
>>> Once the resourses are restored to active state again in resume,
>>> the runtime pm usage count can be decreased with a pm_runtime_put.
>>
>> The PM core will ensure devices are runtime resumed before we enter
>> suspend precisely due to this sort of issue.
>
> I asked the very same question to Ulf (in speech, sorry
> so you couldn't see it...)
>
> So I guess we are talking about drivers/base/main.c
>
> in device_prepare()
> pm_runtime_get_noresume() is called

This will increase the "usage_counter" for the device. It will not
"runtime_resume" the device, though it will prevent it from being
"runtime_suspended".

> and in device_complete()
> pm_runtime_put_sync() is called.
>

> Both put into current for in
> commit 88d26136a256576e444db312179e17af6dd0ea87
> on sep 19th.
>
> Yes it seems like it will do the job.
>
> Ulf can you comment on this...
>
> Yours,
> Linus Walleij

Kind regards
Ulf Hansson
