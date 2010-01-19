From: linux@bohmer.net (Remy Bohmer)
Date: Tue, 19 Jan 2010 11:46:23 +0100
Subject: [PATCH] Updated: Fix soft lockup in at91 udc driver
In-Reply-To: <20100119085304.GA17708@pengutronix.de>
References: <4B4F7576.9090008@bluewatersys.com>
	<20100119085304.GA17708@pengutronix.de>
Message-ID: <3efb10971001190246t3c47d2afg76ffde05d77ab33d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2010/1/19 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Fri, Jan 15, 2010 at 08:50:14AM +1300, Ryan Mallon wrote:
>> Fix a potential soft lockup in the AT91 UDC driver by ensuring that the
>> UDC clock is enabled inside the interrupt handler. If the UDC clock is
>> not enabled then the UDC registers cannot be written to and the
>> interrupt cannot be cleared or masked.
> Wouldn't it be cleaner to assert that the clock is already on when an
> irq comes in? ?That is enable the clock and let it enabled when
> configuring the device to generate irqs?
>
> Just my 2?

What we have seen here is that there is a condition during host-suspend.
When the host-suspends (3ms idle) the clocks are being disabled, after
a short time the host wakes up again and does a device reset.
This reset triggers a resume interrupt with the clocks disabled. BUT,
it only behaves like this with only a few host controllers. This
results in a hanging interrupt.
The locking code of this driver is not completely clean and that needs
some rework, especially for preempt-rt.
We want to rework this, but that takes more time. Until then this
patch at least solves the issue and can be used safely.

Kind regards,

Remy
