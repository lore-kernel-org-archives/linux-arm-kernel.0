From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Sep 2012 08:33:28 +0300
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <874nn2vpv9.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <874nn2vpv9.fsf@deeprootsystems.com>
Message-ID: <20120913053325.GC6504@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 03:27:22PM -0700, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
> 
> [...]
> 
> >
> > This is the cleanup only series.
> >   
> > Tested on omap4sdp and 3430sdp.
> 
> It would be extremely helpful if you would describe how this was tested.
> And for me, it would be a source of extreme joy if you described any PM
> testing.
> 
> I gave this some additional PM testing on 3430/n900, 3530/Overo,
> 3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda.
> 
> I tested v3.6-rc5 which passed all PM tests and then added this series
> (by merging the i2c-embedded/i2c-next branch.)  PM tests then fail.
> 
> At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
> off) during idle.  
> 
> The easy way to notice this is to see that even when no i2c transactions
> are happening, the runtime PM status for omap_i2c.1 is remains 'active':
> 
> # cat omap_i2c.*/power/runtime_status 
> active
> suspended
> 
> Of course that means that clocks are never gated during idle, and CORE
> will never hit retention.
> 
> I noticed it because my PM tests detected that the CORE powerdomain was
> not transitioning to retention (or off) during idle.
> 
> To reproduce, simply enable UART timeouts so CORE will hit retention:
> 
> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
> 
> and check the core_pwrm state counters:
> 
> cat /debug/pm_debug/count
> 
> wait > 3 seconds for the UART autosuspend timers to kick in.  At this
> point, CORE should be transitioning to retenion in idle (determined by
> noticing that the RET counter for core_pwrdm is increasing.)

I just ran same tests on pandaboard and i2c is suspended actually,
though no power domain transitions to RET. Do we not have retention
while idle on pandaboard ?

See below for a few results... First I ran this script to set everything
up:

#!/bin/sh

echo "mounting proc"
mount -t proc none /proc

echo "mounting sysfs"
mount -t sysfs none /sys

echo "mounting debugfs"
mount -t debugfs none /debug

echo "UART autosuspend delay"
echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms

echo "check omap_i2c.* status"
cat /sys/devices/platform/omap_i2c.*/power/runtime_status

echo "check CORE pm counters"
grep "^core_pwrdm" /debug/pm_debug/count

Then I triggered a few i2c transfers by reading regulator status through
sysfs:

# cat /sys/class/regulator/regulator.*/status
[  507.469299] omap_i2c omap_i2c.1: omap_i2c_runtime_resume
normal
normal
off
off
normal
normal
normal
normal
normal
off
# [  509.010711] omap_i2c omap_i2c.1: omap_i2c_runtime_suspend
cat /sys/devices/platform/omap_i2c.*/power/runtime_status
suspended
suspended
suspended
suspended

notice the prints I've added... I don't know what could go wrong only on
Overo that i2c doesn't suspend. Can you add this debugging patch just
for me to see if, at least, omap_i2c_runtime_suspend is being called ?

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c78431a..ac61664 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1238,6 +1238,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
 	u16 iv;
 
+	dev_info(dev, "%s\n", __func__);
+
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
 
 	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
@@ -1277,6 +1279,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	if (_dev->iestate)
 		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
 
+	dev_info(dev, "%s\n", __func__);
+
 	return 0;
 }
 #endif /* CONFIG_PM_RUNTIME */

this is on top of Wolfram's for-next branch, btw. Maybe you should also
add:

CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y

to your .config just in case.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120913/c04d14f5/attachment-0001.sig>
