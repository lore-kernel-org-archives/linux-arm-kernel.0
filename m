From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Oct 2016 18:55:22 +0200 (CEST)
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580E3308.4050507@free.fr>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos> <580A7A2B.5000702@free.fr>
 <20161022123713.6dc788b3@arm.com> <580BF1D4.2030509@free.fr>
 <580E3308.4050507@free.fr>
Message-ID: <alpine.DEB.2.20.1610241847580.5002@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Oct 2016, Mason wrote:
> 
> For the record, setting the IRQ_DISABLE_UNLAZY flag for this device
> makes the system lock-up disappear.

The way how lazy irq disabling works is:

1) Interrupt is marked disabled in software, but the hardware is not masked

2) If the interrupt fires befor the interrupt is reenabled, then it's
   masked at the hardware level in the low level interrupt flow handler.

I have no idea why that does not work on your hardware. You might
instrument handle_level_irq() to see what effect that has.

Thanks,

	tglx
