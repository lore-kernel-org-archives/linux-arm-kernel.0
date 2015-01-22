From: yegor.yefremov@visionsystems.de (Yegor Yefremov)
Date: Thu, 22 Jan 2015 08:37:45 +0100
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <CADYTM3b40_u4Twt27PBVH4dC9ErDnFEi0AUzs_aJRM3mMHaBCQ@mail.gmail.com>
References: <20150121160631.GH4367@lukather>
 <CADYTM3b40_u4Twt27PBVH4dC9ErDnFEi0AUzs_aJRM3mMHaBCQ@mail.gmail.com>
Message-ID: <54C0A8C9.3040201@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.01.2015 19:53, Bin Liu wrote:
> Hi,
> 
> On Wed, Jan 21, 2015 at 10:06 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi Felipe,
>>
>> I'm currently working on a custom AM335x-based board, that has a OTG
>> connector wired to one of the musb controlers, and Linux 3.17
>>
>> This OTG connector seems to behave in a weird way when it comes to
>> switching from one role to another:
>>
>>   - The host mode works with CONFIG_USB_MUSB_DUAL_ROLE set, only if
>>     the dr_mode is set to host in the DT, and only if we plug the USB
>>     device after the kernel has booted. Otherwise, even though the
>>     controller seems to be set up as host in the kernel logs, it
>>     doesn't work. When DR-mode is set to otg, DRVVBUS is not high
>>     which surely doesn't help, but there might be some other issues.
>>
>>   - The gadget mode works with CONFIG_USB_MUSB_DUAL_ROLE, if dr_mode
>>     is set to otg and not host (obviously), and only if we plug the
>>     USB cable after the kernel has booted.
>>
>>   - The gadget mode works with CONFIG_USB_MUSB_GADGET, and with
>>     dr_mode set to otg, even if we cold plug the device.
>>
>>   - As you might expect from the two first items, the runtime
>>     switching from gadget to host when CONFIG_USB_MUSB_DUAL_ROLE is
>>     set and dr_mode is set in otg doesn't work either.
>>
>> It looks like it's only waiting for an interrupt to occur to read the
>> ID pin state, without reading its initial value, which would explain
>> why both the host and gadget enumerate only when a device/cable is
>> hotplugged, and that there's some configuration bits that differ
>> whenever dr_mode changes, but I couldn't really see anything standing
>> out in the driver nor the datasheet.
>>
>> Have you already experienced something alike with that driver?
> 
> I don't use vanilla mainline kernel very often, but I don't have such
> hotplug issues with TI 3.12/14 kernels [1]. I only use
> CONFIG_USB_MUSB_DUAL_ROLE though.
> 
> [1] git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git, branch
> remote/origin/linux-3.14.y

I have the same experience with 3.15. The switching is working when CONFIG_USB_MUSB_DUAL_ROLE is set and dr_mode = "otg". But since 3.16 it seems to be broken. Still had no time to bisect this.

Yegor
