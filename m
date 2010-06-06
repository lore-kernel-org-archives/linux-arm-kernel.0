From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 6 Jun 2010 13:28:01 +0300
Subject: [PATCH 3/5] USB: add clk structure for systems that support
	clkdev framework
In-Reply-To: <20100502160555.GE4233@n2100.arm.linux.org.uk>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
	<20100502143602.GA4233@n2100.arm.linux.org.uk>
	<r2oc70ff3ad1005020805zc80ad8b9n1e56d4a0a6ce5b9c@mail.gmail.com>
	<20100502151425.GC4233@n2100.arm.linux.org.uk>
	<u2wc70ff3ad1005020821z5eb3eec5y5a64b1d5dd3652a@mail.gmail.com>
	<20100502153157.GD4233@n2100.arm.linux.org.uk>
	<i2ic70ff3ad1005020854l2738ace8l3c7c291cf07c9402@mail.gmail.com>
	<20100502160555.GE4233@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik_HV9jx75Pk5IpSdkr0xL6W4S0vihpoKh2bJpJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 2, 2010 at 7:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, May 02, 2010 at 06:54:15PM +0300, saeed bishara wrote:
>> >> well, I think that those drivers that have more than one clk can be
>> >> redesigned by adding virtual clk for the the usb host, and the clk
>> >> implementation for that soc should manage all the underlying physical
>> >> clocks. I've looked at the omap,at91 and atmel, and it looks to me
>> >> that this is doable. you see can see that the clk stuff in those
>> >> driver has nothing to do with usb itself. what do you think?
>> >
>> > Not happy with this for two reasons:
>> > 1. You're assuming that they can be managed as one entity; that doesn't seem
>> > ? true for some of the drivers.
>> can you please give an example?
>
> drivers/usb/host/ohci-da8xx.c has two clocks, and needs to know the
> configuration of the USB block to know whether to manage the USB2.0
> clock:
>
> ? ? ? ?cfgchip2 = __raw_readl(CFGCHIP2);
> ? ? ? ?if (on) {
> ? ? ? ? ? ? ? ?clk_enable(usb11_clk);
>
> ? ? ? ? ? ? ? ?/*
> ? ? ? ? ? ? ? ? * If USB 1.1 reference clock is sourced from USB 2.0 PHY, we
> ? ? ? ? ? ? ? ? * need to enable the USB 2.0 module clocking, start its PHY,
> ? ? ? ? ? ? ? ? * and not allow it to stop the clock during USB 2.0 suspend.
> ? ? ? ? ? ? ? ? */
> ? ? ? ? ? ? ? ?if (!(cfgchip2 & CFGCHIP2_USB1PHYCLKMUX)) {
> ? ? ? ? ? ? ? ? ? ? ? ?clk_enable(usb20_clk);
>
guys, can I've your opinion about this patch? adding the clk struct
to the hcd struct will save the orion-ehci driver from having private
data structure.

saeed
