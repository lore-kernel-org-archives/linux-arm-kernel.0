From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 19 Jun 2015 15:55:23 -0700
Subject: [PATCH 0/7] soc: brcmstb: add system suspend support for STB SoCs
In-Reply-To: <20150619224123.GL4917@ld-irv-0074>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
 <CADtm3G7GQNuaZDoNe84YAh7pRV9s_2VhUuW8YpaCoNuozoyVZA@mail.gmail.com>
 <20150619224123.GL4917@ld-irv-0074>
Message-ID: <CAN8TOE8NwLw5mfs9N+H_VKkEYHDkTNWgpX_MQzsc1Rg0d-hmFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 3:41 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> + tglx, Kevin

^^ for real this time

> On Thu, Jun 18, 2015 at 08:20:52PM -0700, Gregory Fong wrote:
>> On Thu, Jun 18, 2015 at 5:11 PM, Brian Norris <computersforpeace@gmail.com> wrote:
>> > This patch set introduces system suspend/resume support for Broadcom STB SoCs.
>> > There are two suspend modes (S2 and S3) as well as a related low-power shutdown
>> > mode (S5).
>> >
>> > Along with the core PM support, include a driver for the wakeup-timer, which
>> > allows for simple testing of suspend/resume wakeup cycles.
>> >
>> > Brian
>> >
>> > Brian Norris (7):
>> >   Documentation: dt: brcmstb: add system PM bindings
>> >   Documentation: dt: brcmstb: add waketimer documentation
>> >   soc: add stubs for brcmstb SoC's
>> >   soc: brcmstb: add PM suspend/resume support (S2/S3/S5)
>> >   soc: brcmstb: add wake-timer driver
>> >   ARM: brcmstb: mask GIC IRQs on suspend
>> >   ARM: dts: brcmstb: add BCM7445 system PM DT nodes
>> >
>>
>> I tested this series two ways: with the device tree built into the
>> bootloader (BOLT) on BCM7445 and by using
>> arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
>>
>> With the device tree from BOLT, everything works fine.  Tested the
>> waketimer for S2, S3, and S5.
>
> Thanks for the testing!
>
>> With the device tree in arch/arm/boot/dts/bcm7445-bcm97445svmb.dts, S2
>> works, but S3 and S5 do not.  It comes back up but doesn't reach the
>> prompt:
>>
>> [    6.050808] PM: suspend of devices complete after 1.425 msecs
>> [    6.051760] PM: late suspend of devices complete after 0.947 msecs
>> [    6.052535] PM: noirq suspend of devices complete after 0.770 msecs
>> [    6.052537] Disabling non-boot CPUs ...
>> [    6.053005] CPU1: shutdown
>> [    6.065914] CPU2: shutdown
>> [    6.080756] CPU3: shutdown
>> [    6.095214] Enabling non-boot CPUs ...
>> [    6.111496] CPU1 is up
>> [    6.126934] CPU2 is up
>> [    6.142511] CPU3 is up
>> [    6.145308] PM: noirq resume of devices complete after 2.772 msecs
>> [    6.148022] PM: early resume of devices complete after 2.626 msecs
>> [    6.151017] PM: resume of devices complete after 2.976 msecs
>> [    6.212771] Restarting tasks ... done.
>> [[[ output stops here ]]]
>
> Right, I noticed this problem, but found that it was independent of the
> core PM code. UART interrupts are dead, but nothing else is.
>
>> I suspect there might be an issue somewhere in
>> [PATCH 7/7] ARM: dts: brcmstb: add BCM7445 system PM DT nodes.
>
> It's not a problem with patch 7, exactly, it's a problem with the
> irqchip driver which handles the UART interrupt mask (irq-bcm7120-l2.c).
> The problem is that with a trimmed down device tree (such as the one
> found at arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb), none of the child
> interrupts of the 'irq0_intc' node are described -- we don't have device
> tree nodes for them yet -- but we still require saving and restoring the
> forwarding mask (see 'brcm,int-fwd-mask') in order for the UART
> interrupts to continue operating.
>
> This is all a problem because when irq_chip_generic::installed == 0, the
> irq_{suspend,resume} functions never get called in irq-bcm7120-l2.c.
>
> Anyway, I think this suggests that irq-bcm7120-l2.c needs a slightly
> different semantics to its PM callbacks; they must be called regardless
> of whether there are any child interrupts. I've cooked up some patches
> for this and will send them shortly in reply to this thread.
>
> Thanks,
> Brian
