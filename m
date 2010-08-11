From: john.ogness@linutronix.de (John Ogness)
Date: Wed, 11 Aug 2010 15:16:34 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <20100811125625.GS27749@pengutronix.de> (Sascha Hauer's message
	of "Wed, 11 Aug 2010 14:56:25 +0200")
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
	<20100811125625.GS27749@pengutronix.de>
Message-ID: <80r5i5z3v1.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-08-11, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> Your version allows a small window between request_irq() and
>> irq_control() where on the i.MX21 there is a possibility of the
>> interrupts being disabled twice. Namely, if an interrupt occurs
>> before irq_control() has had a chance to disable it. IMHO it would be
>> better to call:
>> 
>>     set_irq_flags(host->irq, IRQF_VALID | IRQF_NOAUTOEN);
>> 
>> for the i.MX21 before requesting the irq. This closes the window.
>
> IIRC it is not allowed to call set_irq_flags before request_irq. We
> are changing a resource we do not own yet.

Normally, yes. But the only way the IRQF_NOAUTOEN flag can ever be
useful is if set_irq_flags() is called before request_irq().

> I think the worst thing that could happen without this change is that
> we get an interrupt after request_irq.

Yes. And this causes a problem on the i.MX21 because the interrupt
handler will disable the interrupts. The irq_control() after
request_irq() will _also_ disable the interrupts. This means the
interrupts are disabled twice, which causes some issues on an RT kernel.

> Alternatively we could set the interrupt mask bit before requesting
> the irq.

Yes. This would be best. But for the i.MX21 it is important that the
interrupts are unmasked after irq_control() has disabled the interrupts.

John Ogness
