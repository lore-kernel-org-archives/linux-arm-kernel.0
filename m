From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Oct 2012 20:01:49 +0300
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Message-ID: <20121019170149.GG1493@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 19, 2012 at 04:55:38PM +0000, Paul Walmsley wrote:
> On Thu, 18 Oct 2012, Paul Walmsley wrote:
> 
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
> 
> And here's two more.
> 
> > Failing tests: needing investigation
> > ------------------------------------
> > 
> >
> > Boot tests:
> >
> > * 2420n800: boot hangs during UART initialization
> >  - http://lkml.org/lkml/2012/9/11/454
> >  - Various attempts at fixes posted; etiology known; issue still unresolved
> >
> > * CM-T3517: L3 in-band error with IPSS during boot
> >  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
> >  - Longstanding issue; does not occur on the 3517EVM
> >
> > * 3517EVM & CM-T3517: boot hangs with NFS root
> >  - Likely some Kconfig, board file, and PM issues with EMAC
> >
> > * CM-T3517: boot hangs with MMC boot
> >  - Due to missing MMC setup in board file
> 
> * 3530ES3 Beagle: I2C timeouts during userspace init
>   - May be related to the threaded IRQ conversion of the I2C driver
>   - Unknown cause

Doesn't seem like it's related to threaded IRQ. It says:

[   23.673858] omap_i2c omap_i2c.1: timeout waiting for bus ready

at that time we didn't even program the transfer yet, meaning we're not
even on wait_for_completion_timeout() inside omap_i2c_xfer_msg(). This
happens before:

> static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
> {
> 	unsigned long timeout;
> 
> 	timeout = jiffies + OMAP_I2C_TIMEOUT;
> 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
> 		if (time_after(jiffies, timeout)) {
> 			dev_warn(dev->dev, "timeout waiting for bus ready\n");

it' stopping here. And that's called...

> 			return -ETIMEDOUT;
> 		}
> 		msleep(1);
> 	}
> 
> 	return 0;
> }

[...]

> static int
> omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> {
> 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
> 	int i;
> 	int r;
> 
> 	r = pm_runtime_get_sync(dev->dev);
> 	if (IS_ERR_VALUE(r))
> 		goto out;
> 
> 	r = omap_i2c_wait_for_bb(dev);

right here. For whatever reason, the bus is kept busy (or at least the
driver thinks so).

Looking closely at the logs I see that definitely I2C was working during
early boot (we managed to mount file system on SD card and twl got
initialized properly). But then we have a long time where I2C isn't
used, so it probably suspended in between.

Then RTC wanted to read a register, I2C woke up, restored context, but
bus was kept busy, for whatever reason.

Does it happen all the time on multiple boots or is it ramdom ?

> 	if (r < 0)
> 		goto out;
> 
> 	/*
> 	 * When waiting for completion of a i2c transfer, we need to
> 	 * set a wake up latency constraint for the MPU. This is to
> 	 * ensure quick enough wakeup from idle, when transfer
> 	 * completes.
> 	 */
> 	if (dev->latency)
> 		pm_qos_add_request(&dev->pm_qos_request,
> 				   PM_QOS_CPU_DMA_LATENCY,
> 				   dev->latency);
> 
> 	for (i = 0; i < num; i++) {
> 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
> 		if (r != 0)
> 			break;
> 	}
> 
> 	if (dev->latency)
> 		pm_qos_remove_request(&dev->pm_qos_request);
> 
> 	if (r == 0)
> 		r = num;
> 
> 	omap_i2c_wait_for_bb(dev);
> out:
> 	pm_runtime_mark_last_busy(dev->dev);
> 	pm_runtime_put_autosuspend(dev->dev);
> 	return r;
> }

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121019/21c960e3/attachment.sig>
