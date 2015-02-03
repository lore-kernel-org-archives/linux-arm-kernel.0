From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 03 Feb 2015 11:37:30 +0000
Subject: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
In-Reply-To: <4324891.mqG6Yyfi6J@wuerfel>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
 <4145359.V8A0ARGtXz@wuerfel> <54D0A521.7030405@arm.com>
 <4324891.mqG6Yyfi6J@wuerfel>
Message-ID: <54D0B2FA.9080600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/15 11:31, Arnd Bergmann wrote:
> On Tuesday 03 February 2015 10:38:25 Marc Zyngier wrote:
>>
>> That's exactly what I thought until Lorenzo reported kvmtool falling
>> over because of this write. Obviously, some platforms must actually
>> require this (possibly for bridges that are not known by the firmware).
> 
> This sounds much like a bug in kvmtool.

Lorenzo and I just came to a similar conclusion, given that the HW
should never use that information.

>> Entirely removing that code solves my problem too, but that'd cannot be
>> the right solution...
> 
> The comment in pdev_fixup_irq() says 
> 
>         /* Always tell the device, so the driver knows what is
>            the real IRQ to use; the device does not use it. */
> 
> which I read to mean that there are drivers that incorrectly use
> 'pci_read_config_byte(dev, PCI_INTERRUPT_LINE)' as the number
> they pass into request_irq, rather than using dev->irq.
> However, this means that your patch is actually wrong, because
> what the driver cares about is the virtual irq number (which
> request_irq expects), not the number relative to some interrupt
> controller.

Yes, I now realise that. That makes a lot more sense actually, because I
was getting very confused about how the HW should interpret that number.

Side question: In the probe-only case, should we still allow this write
to happen?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
