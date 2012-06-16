From: stigge@antcom.de (Roland Stigge)
Date: Sat, 16 Jun 2012 16:57:48 +0200
Subject: [PATCH] mmc: mmci.c: Defer probe() in case of missing GPIOs
In-Reply-To: <20120616142652.GC7628@n2100.arm.linux.org.uk>
References: <1339856099-9313-1-git-send-email-stigge@antcom.de>
 <20120616142652.GC7628@n2100.arm.linux.org.uk>
Message-ID: <4FDC9EEC.1070509@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/12 16:26, Russell King - ARM Linux wrote:
> On Sat, Jun 16, 2012 at 04:14:59PM +0200, Roland Stigge wrote:
>> If the GPIOs used by the MMCI driver are not registered yet when the
>> driver is probe()d, they can't be used. This happens if the mmci driver
>> is probed before the respective GPIO controller (e.g. on the LPC32xx
>> EA3250 board, the PCA9532 GPIO controller would be initialized via DT
>> after mmci). Therefore, we defer mmci in this case.
> 
> This code is wrong.  There are platforms where plat->gpio_cd is negative
> (because there isn't an associated GPIO) and we still expect the driver
> to successfully bind.  In that case, the driver gets the CD and WP
> information via the status callback.
> 
> So this is an incompatible change with existing (and required) driver
> behaviour.

As someone just told me, in the case of no GPIO, we would have gpio_cd
== -ENODEV. Would it be sufficient to check for -ENODEV (in which case
we would do without GPIO), and otherwise return -EPROBE_DEFER?

Or is it necessary to flag DT-bound GPIOs somehow additionally to handle
this new case?

Thanks in advance,

Roland
