From: mturquette@ti.com (Mike Turquette)
Date: Tue, 22 May 2012 11:57:17 -0700
Subject: common clock framework
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A74B2C270@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
 <CAG9bXv=T7v_MBUOmCsp4n0SNmYY_DOEkhQXAp0rTGpdi6KkXNA@mail.gmail.com>
 <20120506234958.GA14559@gmail.com>
 <AAD1C6EB06EE3649B35B7E026785068D1A74B2C256@SC-VEXCH2.marvell.com>
 <A63A0DC671D719488CD1A6CD8BDC16CF1A0F044EB4@SC-VEXCH4.marvell.com>
 <53612FE6B944314AAADB181E45A45B6413D3FF9F37@sc-vexch3.marvell.com>
 <AAD1C6EB06EE3649B35B7E026785068D1A74B2C270@SC-VEXCH2.marvell.com>
Message-ID: <20120522185717.GA4386@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120518-01:41, Chao Xie wrote:
> Issue 2: clock with dependency As we know that each vendor may have
> some version of SOCs, and these SOC may share some same components.
> For example, device a need function clock A while device B need
> function clock B, there share some bus, and there a clock for the bus
> clock gating. It means that if we want device B working, we need
> enable clock B and clock bus.  In fact, we can not consider that clock
> bus is the parent of clock A/B, because clock A/B has inputs from
> PLLs.  So how do we control these clocks? If leaving the dependency in
> clock tree, we need additional patch for it. If leaving it to device
> driver, it will make the device driver to know more details about
> clock framework, and for different SOCs share same device driver, the
> clock framework may not same. So it will make the device driver to be
> SOCs depended, and will need more detailed platform data.

This has been discussed in this thread already.  Functional dependencies
are outside the scope of the clock framework.

The brute force solution is to put a clk_prepare_enable() call for both
the functional clock and the bus clock in your driver.  A better
approach (and one employed in the OMAP platform code) is to abstract
away these details from the drivers.  OMAP uses the pm_runtime
framework which makes life easier for drivers by simply calling
pm_runtime_get/pm_runtime_put, which takes care of functional clocks as
well as bus clocks (and other stuff).

The details of the callbacks used by the pm_runtime framework can be
different for each SoC, which addresses your concerns above.

I agree that the details of bus clocks should be abstracted away
somewhere, but the clock framework is not the place for that.

Regards,
Mike
