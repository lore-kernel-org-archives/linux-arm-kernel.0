From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 12 Jun 2015 21:36:07 +0200
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set
 on suspend
In-Reply-To: <557AD728.7090908@collabora.co.uk>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
 <557AB00C.5040606@arm.com> <557AC23D.8040602@collabora.co.uk>
 <557AC85E.5070705@arm.com> <557AD728.7090908@collabora.co.uk>
Message-ID: <557B34A7.4090507@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sudeep,

On 06/12/2015 02:57 PM, Javier Martinez Canillas wrote:
> On 06/12/2015 01:54 PM, Sudeep Holla wrote:

[snip]

> 
>> registers are lost assuming the combiner was powered down, even the
>> status register will be lost and you will not know exactly the wakeup
>> reason right ?
>>
> 
> Good question, I didn't find in the documentation I've access to that
> this happen but just found through experimentation that the IRQ enable
> set register values are lost after a resume and that saving/restoring
> the values makes the interrupts to be triggered again.
>

I'll share here too the findings I mentioned over IRC. As you suggested I
add some printouts and noticed that the ISTRn (Interrupt Status) registers
values are indeed preserved on resume so I can know for example if the
wakeup source was the power gpio-key or cros_ec keyboard. I've checked the
values of the registers against the Exynos manual and they corresponds to
the interrupt sources in each case so the values are correct.

So as you said, it seems that is not that the IP block loses its state on
S2R but that something is blindly writing the IESRn (Interrupt Enable Set)
registers.

To reduce the possible s/w components that could be doing this, I booted a
signed FIT image directly using the RO U-Boot instead of chain loading a
mainline nv-uboot. In this configuration I've the same issue so it seems
that if something is zeroing those registers on S2R, this can't be changed
without void the warranty of these machines.

I also looked at the downstream ChromiumOS v3.8 tree [0] and I see that
they have a very similar solution than my patch, the IESRn are also saved
but using a notifier for the CPU_PM_ENTER and CPU_PM_EXIT events instead
or registering a syscore ops but the idea is basically the same.

I have to take a look to the U-boot that is shipped on the device, I think
the correct branch is [1] but I'm not sure if that is the correct one.

Best regards,
Javier

[0]: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/arch/arm/mach-exynos/common.c#657
[1]: https://chromium.googlesource.com/chromiumos/third_party/u-boot firmware-pit-4482.B
