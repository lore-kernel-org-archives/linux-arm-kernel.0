From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Sep 2012 09:36:59 +0300
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <50517780.2080002@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <874nn2vpv9.fsf@deeprootsystems.com> <50517780.2080002@ti.com>
Message-ID: <20120913063657.GH6504@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 13, 2012 at 11:34:48AM +0530, Shubhrajyoti wrote:
> On Thursday 13 September 2012 03:57 AM, Kevin Hilman wrote:
> > Shubhrajyoti D <shubhrajyoti@ti.com> writes:
> >
> > [...]
> >
> >> This is the cleanup only series.
> >>   
> >> Tested on omap4sdp and 3430sdp.
> > It would be extremely helpful if you would describe how this was tested.
> > And for me, it would be a source of extreme joy if you described any PM
> > testing.
> >
> > I gave this some additional PM testing on 3430/n900, 3530/Overo,
> > 3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda.
> >
> > I tested v3.6-rc5 which passed all PM tests and then added this series
> > (by merging the i2c-embedded/i2c-next branch.)  PM tests then fail.
> >
> > At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
> > off) during idle.  
> >
> > The easy way to notice this is to see that even when no i2c transactions
> > are happening, the runtime PM status for omap_i2c.1 is remains 'active':
> >
> > # cat omap_i2c.*/power/runtime_status 
> > active
> > suspended
> >
> > Of course that means that clocks are never gated during idle, and CORE
> > will never hit retention.
> >
> > I noticed it because my PM tests detected that the CORE powerdomain was
> > not transitioning to retention (or off) during idle.
> >
> > To reproduce, simply enable UART timeouts so CORE will hit retention:
> >
> > echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
> >
> > and check the core_pwrm state counters:
> >
> > cat /debug/pm_debug/count
> >
> > wait > 3 seconds for the UART autosuspend timers to kick in.  At this
> > point, CORE should be transitioning to retenion in idle (determined by
> > noticing that the RET counter for core_pwrdm is increasing.)
> >
> > With $SUBJECT series applied, you'll notice that CORE is not
> > transitioning.
> However I do not see the issue,let me know if I missed something see below.
> 
> On my 3430sdp
> 
> /sys/bus/platform/devices # cat omap_i2c.*/power/runtime_status
> suspended
> suspended
> suspended
> /sys/bus/platform/devices #
> /sys/bus/platform/devices # cat omap_i2c.*/power/autosuspend_delay_ms
> 1000
> 1000
> 1000

I just revived my very, very old 3503 overo and while i2c isn't active,
I don't see transitions on core power domain:

# mount -t proc none /proc
# mount -t sysfs none /sys
# mount -t debugfs none /debug
# echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
# echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
# echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
# cat /sys/devices/platform/omap_i2c.*/power/runtime_status
suspended
suspended
# grep ^core_pwrdm /debug/pm_debug/count && sleep 5 && grep ^core_pwrdm /debug/pm_debug/count
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

Weird, but I don't think i2c is to blame here (unless I'm missing
something). I can see that after i2c transfers, my suspend function is
called and right after that i2c is suspended:

# cat /sys/class/regulator/regulator.*/status && sleep 1 && cat /sys/devices/platform/omap_i2c.*/power/runtime_status
[  411.072998] omap_i2c omap_i2c.1: omap_i2c_runtime_resume
normal
normal
normal
[  412.075347] omap_i2c omap_i2c.1: omap_i2c_runtime_suspend
suspended
suspended

What am I missing to get any pm transitions to happen with my overo ?

# cat  /debug/pm_debug/count && sleep 5 && cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:2379,INA:0,ON:2380,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:2377,INA:0,ON:2378,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (21)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:2442,INA:0,ON:2443,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:2440,INA:0,ON:2441,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (21)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120913/b90d41b7/attachment-0001.sig>
