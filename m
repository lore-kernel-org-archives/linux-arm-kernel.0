From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Jul 2013 22:41:31 +0300
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <51DC5D90.1010603@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi> <51DBA0C2.6030003@ti.com>
 <20130709064212.GB5552@arwen.pp.htv.fi> <51DC5D90.1010603@ti.com>
Message-ID: <20130709194131.GA12523@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 09, 2013 at 09:59:28PM +0300, Grygorii Strashko wrote:
> >>>Imagine the device is marked as suspended even though it's fully enabled
> >>>(it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> >>>your context structure is all zeroes (context has never been saved
> >>>before) then when you call pm_runtime_get_sync() on probe() your
> >>>->runtime_resume() will get called, which will restore context,
> >>>essentially undoing anything which was configured by u-boot.
> >>
> >>This could be a problem for drivers which do a save context in ->runtime_suspend()
> >>but from what I see with omap serial, there is no save context done as part of
> >>->runtime_suspend.
> >
> >right, because context is "saved" in set_termios. probe() will get
> >called much before set_termios() has a chance to run, right ?
> >
> >Same problem will trigger in that case.
> >
> >I still think patch below is necessary
> >
> >>>(completely untested, didn't even try to compile, just to illustrate)
> >>>
> >>>diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> >>>index 7341eff..d8dca68 100644
> >>>--- a/arch/arm/mach-omap2/omap_hwmod.c
> >>>+++ b/arch/arm/mach-omap2/omap_hwmod.c
> >>>@@ -2559,6 +2559,12 @@ static void __init _setup_postsetup(struct omap_hwmod *oh)
> >>>  	    (postsetup_state == _HWMOD_STATE_IDLE)) {
> >>>  		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
> >>>  		postsetup_state = _HWMOD_STATE_ENABLED;
> >>>+
> >>>+		/* tell pm_runtime this device is already active */
> >>>+		pm_runtime_set_active(&oh->od->pdev->dev);
> >>>+	} else {
> >>>+		/* tell pm_runtime this device is trully suspended */
> >>>+		pm_runtime_set_suspended(&oh->od->pdev->dev);
> >>>  	}
> >>>
> >>>  	if (postsetup_state == _HWMOD_STATE_IDLE)
> >
> 
> This will not work - _setup_postsetup() is called from core_initcall
> level and OMAP devices have not been created at this moment yet
> (of_platform_populate() is called from
> customize_machine->init_machine->omap_generic_init() at arch_initcall time)

fair enough, but something *like* that needs to be done. If pm_runtime
doesn't know the state of the device by the time pm_runtime_enable() is
called, the wrong assumptions might be made and we will forever have
such problems as our ->runtime_resume() callback being called when it
shouldn't.

> More over, I don't recommend to depend on hwmod->od field - it's been
> created to support OPPs and it's obsolete now in case of DT use.

that's alright, but still we need something similar.

But in any case, if on DT boot that's not used, than *what* uses
HWMOD_INIT_NO_IDLE during DT boot ?

There's a single place in kernel source which checks if
HWMOD_INIT_NO_IDLE is set, and that's the place which I patched.

We, certainly, need a way to tell pm_runtime if the device is active or
suspended by the time we reach our probe() function. Either we assume
*all* devices are active and we blindly call pm_runtime_set_active() for
all devices, or we assume *all* devices are suspended as we call
pm_runtime_set_suspend() for all devices, or we figure out which ones
are active and which are not and call pm_runtime_set_{active,suspend}()
conditionally.

> Seems, This issue need to be handled in driver for DT boot use case,
> possibly cmdline need to be parsed in the same way as it's done in
> omap_serial_early_init().

so you want *every* single driver to parse their own cmdline ? How big
would the cmdline become ? This makes no sense.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/d9ed7f62/attachment.sig>
