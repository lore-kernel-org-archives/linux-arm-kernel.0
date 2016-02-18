From: stefan@agner.ch (Stefan Agner)
Date: Thu, 18 Feb 2016 08:13:59 -0800
Subject: no irq domain found for ... a GPIO interrupt controller
In-Reply-To: <20160218091432.6968b836@arm.com>
References: <2dc0519827dc9d210e38c498d830cd97@agner.ch>
 <20160218091432.6968b836@arm.com>
Message-ID: <11a0b1f5808af5bdabaab657366918d4@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2016-02-18 01:14, Marc Zyngier wrote:
<snip>
> What your stack trace shows is that the failure occurs at boot time,
> when of_platform_populate() parses the DT and creates the platform
> devices. As part of this process, it tries to resolves the interrupt
> specifiers, but fails to do so for this particular device, since the
> corresponding irqchip and domain have not been created yet (the GPIO
> controller is itself a device, while other irqchips are not).
> 
> But as long as your device driver uses platform_get_irq(), you will
> force the interrupt specifier to be evaluated again, this time giving
> you a valid interrupt (and provided that your GPIO driver has
> initialized in the meantime - check for -EPROBE_DEFER). At some point,
> we'll be able to kill the interrupt resolution from
> of_platform_populate().

The device driver is using platform_get_irq. However, I think it
currently would not handle EPROBE_DEFER right, but seems also not to
happen in practice...

> 
> To summarize, your driver not working may not be related to this issue.

So this means that despite the warning, nothing I really need to worry
right? Does this warning will go away in the future?

--
Stefan
