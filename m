From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Fri, 22 Apr 2016 09:05:11 +0200
Subject: Nokia N900 retention mode in v4.6, camera buttons fun
In-Reply-To: <20160421212808.GA31979@amd>
References: <20160407234134.GQ16484@atomide.com> <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd> <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd> <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com> <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali> <20160421212808.GA31979@amd>
Message-ID: <20160422070511.GW29406@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 23:28:08 Pavel Machek wrote:
> Hi!
> 
> > > CONFIG_HSI breaks power management completely, so power management
> > > with modem will be another topic.  
> > 
> > Sebastian, any idea why power management does not work for HSI?
> > 
> > > > > > In the meantime, I found what is causing the rention mode to break for
> > > > > > me: CONFIG_HSI (aka wireless modem support). With HSI off, it seems to work.
> > > > > > 
> > > > > > I still get problems with the camera button, in config similar to
> > > > > > defconfig.  For some reason, I'm even getting (autorepeating) ^@ on
> > > > > > console. As long as I hold camera button down, I even get it into off
> > > > > > mode for brief period.
> > > > > 
> > > > > Ok, if I turn off CONFIG_KEYBOARD_GPIO, I get it into off
> > > > > mode... once per screen blank, for about a second. (Does CONFIG_KEYBOARD_GPIO also cause
> > > > > problems for you?)
> > > > > 
> > > > > Any idea why it enters off mode only once after each screenblank?
> > > > 
> > > > After disabling CONFIG_PROVE_LOCKING, loading the LCD modules, and
> > > > blanking the screen, my n900 hits off mode just fine about once
> > > > a second. Sounds like you still have some extra devices enabled
> > > > causing it.
> > > 
> > > I checked again... also with vanilla 4.6-rc2 to double check... same effect.
> > > 
> > > Aha, got it... cat-ing /sys/kernel/debug/pm_debug/count breaks the
> > > off mode. If I don't do that (tm), it seems to work way better.
> > 
> > So what is result? Is power management working for CONFIG_KEYBOARD_GPIO?
> 
> camera and unlock button GPIOs seem to break the powermanagement,
> too. I disabled it for now.

So this sounds like a problem in gpio keyboard driver. Maybe you can
ping maintainers of that driver?

> Next hint I got from Sebastian was that I may need to enable power
> management in /sys.
> 
> pavel at n900:/my/tui/ofone$ cat
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/runtime_status
> active
> pavel at n900:/my/tui/ofone$ cat
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/autosuspend_delay_ms
> cat:
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/autosuspend_delay_ms:
> Input/output error
> root at n900:/my/tui/ofone# cat
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/control
> auto
> 
> I could not get it to sleep :-(.
> 
> Best regards,
> 								Pavel
> 

Maybe down phonet0 interface and other hsi/ssi interfaces?

-- 
Pali Roh?r
pali.rohar at gmail.com
