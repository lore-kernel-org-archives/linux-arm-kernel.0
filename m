From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 May 2012 10:21:10 +0200
Subject: common clock framework
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
Message-ID: <20120504082110.GB16535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 07:02:07PM -0700, Chao Xie wrote:
> Hi,
> The common clock driver in drivers/clk/ has been integrated into mainline. In fact, I still have some questions to the driver.
> 1. Why need big lock: enable_lock and prepare_lock?
>    Using these locks means that the clock enable and prepare operation cannot re-entered.

This has been discussed at length on the list. Short answer is that it's
not trivial to properly lock the clock tree (or parts thereof) if we have
individual clock locks. The possibility of having a lock per tree has
been discussed if the single lock approach turns out to be unsufficient.
This may be added later.

> 2. How to handle the depended clocks?
>    For example clock1 and clock2 both have multiple inputs, and they
>    both depend on clock3. It means that before enable clock1 or
>    clock2, clock3 should be enabled, and if clock1 and clock2 are both
>    off, clock2 need to be off too to save power. Clock3 is not the
>    parent of clock1 and clock2, because the clock3 is not one of
>    inputs of clock1 and clock2.  If we do not handle it in clock
>    framework, we have to let device driver to know it. It means that
>    the device driver need to handle clock dependency. It will make the
>    device driver to be complicated especially it is shared by
>    different SOCs.

If clock3 is not parent of clock2 and clock1 then the dependency does
not come from your clock tree and thus can't be handled in the clock
framework.
If you have to enable clock3 to make your device work, then yes, your
device must turn it on. It could also be that clock3 is not used by
your device directly but by a bus which your device depends on. In this
case you would have to describe the dependency on bus level.
The clock framework can only describe a clock tree and that's all it
*should* do.

> 3. how to handle voltage changes in clock framework?  When some
> clock's rate is changed, the voltage for the component that using the
> clock may need changed too. So where to add the voltage change
> sequence?

Clocks have notifiers attached to them. You can hook yourself into a pre
rate change (increasing the voltage here) and into a post rate change
(decreasing the voltage here).
That said, we are not there yet. Once the clock framework has settled
and is actually used in SoCs I'm sure somebody will come up with some
driver which can be passed a freq <-> voltage table for a given
regulator clock pair.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
