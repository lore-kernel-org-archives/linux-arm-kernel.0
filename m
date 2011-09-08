From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 16:47:55 +0200
Subject: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
In-Reply-To: <CAK=WgbbN-RYj2quMQOyYbEBBfV3gty4dOE7DgjvsRcoYO=F3kw@mail.gmail.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<4E6877A9.3090104@ti.com>
	<CAK=WgbbN-RYj2quMQOyYbEBBfV3gty4dOE7DgjvsRcoYO=F3kw@mail.gmail.com>
Message-ID: <201109081647.55377.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011, Ohad Ben-Cohen wrote:
> On Thu, Sep 8, 2011 at 11:07 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > The (small) issue for my point of view is that the #hwspinlock is already
> > encoded in the IP itself. So adding a baseid directly in DT will look like
> > duplicating indirectly something that is already there in the HW.
> > That being said, since we cannot rely on the order, we will not be able to
> > get the proper baseid until the driver probe every hwspinlock devices :-(
> > So baseid might be a easier choice.
> 
> Sounds good. Thanks a lot !

I think a number would work here but is not optimal for the device tree
representation. I think a better binding would be to encode it like
interrupt numbers, where every device that uses a hwspinlock will describe
that as a combination of phandle to the hwspinlock controller and
identifier to be used by that controller, e.g.

	spinlock1 {
		compatible = "ti,omap-spinlock";
		regs = ...
		interrupts = <42>;
		interrupt-parent = &irq-controller;
	};

	dsp {
		compatible = ...
		regs = ...
		spinlocks = <23>; // local number withing &spinlock1;
		spinlock-controller = &spinlock1;
	};

or possibly shorter

		spinlocks = <&spinlock1 23>;

	Arnd
