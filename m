From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 27 Oct 2015 12:33:03 +0000
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <CACRpkdbpD+Kr01hDc7QnL4x_4=A_rnAO+G0CaMce8+5ns+bx2Q@mail.gmail.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
 <20151020112026.GF10728@bivouac.eciton.net>
 <CAD0U-hKZM-A2N_Lpnzwkt0WmAi+kRR=UOEE4Vr2M-iTo9ikkOg@mail.gmail.com>
 <CACRpkdZ2Ydyzf9rHOgjZ_KhhxqFi_cK1-Jh47Fh+SP4YGjg_EA@mail.gmail.com>
 <562F6799.1060301@arm.com>
 <CACRpkdbpD+Kr01hDc7QnL4x_4=A_rnAO+G0CaMce8+5ns+bx2Q@mail.gmail.com>
Message-ID: <562F6EFF.2030404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/10/15 12:22, Linus Walleij wrote:
> On Tue, Oct 27, 2015 at 1:01 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 27/10/15 11:55, Linus Walleij wrote:

[...]

>>> Then it is safe to enable NOR flash and AFS in the kernel.
>>
>> *No*, not on Juno. If we need to enable them for other platforms, then
>> we should either disable NOR flash in DT(or even remove it completely
>> whichever is appropriate).
>>
>> Since idle is enable in defconfig and if DT has idle states, then it
>> can't boot for the reason I previously mentioned.
>
> Yeah right I remember that now. Let's say it is safe to enable
> for the tamper-security reason. There may be other reasons
> not to...
>
> If this is about different idle functionalities blocking flash
> access, what we should do is to in Kconfig make it impossible
> to compile in both deep idle states and flash support at the
> same time, as that is how the system really behaves.
>
> I.e do you mean something like this, or am I getting it wrong?
>

But with this you will never enable idle on all VEXPRESS platforms, what
if the issue on Juno is resolved in future silicon. So I prefer DT way
if we have to enable NOR flash in defconfig.

> index 21340e0be73e..07d91776bcfe 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -4,6 +4,7 @@
>   config ARM_CPUIDLE
>           bool "Generic ARM/ARM64 CPU idle Driver"
>           select DT_IDLE_STATES
> +       depends on !(ARCH_VEXPRESS && MTD)
>           help
>             Select this to enable generic cpuidle driver for ARM.
>             It provides a generic idle driver whose idle states are configured
>
> Hiding hardware from the devicetree seems over the top to me,

OK, I agree with you on not hiding. But disabling it seems OK for me as
it's a hardware errata(SROM can't be used and hence NOR is used in warm
reset path)

> it is better to keep the device trees describing the actual hardware

Agreed, but we need a way to specify that it used as alternative for
SROM to workaround the hardware issue and hence not available for Linux.
One way I believe is setting the status as disabled.

-- 
Regards,
Sudeep
