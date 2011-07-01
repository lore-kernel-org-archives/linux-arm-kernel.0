From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 30 Jun 2011 19:33:03 -0500
Subject: [PATCH 1/3] PWM: add pwm framework support
In-Reply-To: <4E0D0595.5070205@gmail.com>
References: <1309430517-23821-1-git-send-email-s.hauer@pengutronix.de>
	<1309430517-23821-2-git-send-email-s.hauer@pengutronix.de>
	<BANLkTikQGFA7XcuAtEEi7_4m-j6-00sZ6Q@mail.gmail.com>
	<201106301441.24493.arnd@arndb.de>
	<BANLkTin_htv2z3D9Bbf6N8Y7UKFRvPtvOg@mail.gmail.com>
	<20110630170229.GP6069@pengutronix.de> <4E0D0595.5070205@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383BB1705@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2011 4:24 PM, Ryan Mallon wrote:
> On 01/07/11 03:02, Sascha Hauer wrote:
>> I think that you made the fundamental mistake to completly ignore the
>> existing pwm API and its users. With a competing api we are basically
>> stuck. We can't convert the existing hardware drivers to the new API
>> because leds-pwm.c, pwm_bl.c and others still depend on the old API and
>> boards using it would break.
>
> I don't think this is really a blocker to Bill's patches. There are 
> three (that I can see) pwm users currently:
> drivers/video/backlight/pwm_bl.c
> drivers/leds/leds-pwm.c
> drivers/input/misc/pwm-beeper.c
>
> All of those drivers are trivial and good easily be updated to work with 
> Bill's patches. Bill already provided a leds-pwm driver.

I agree with Ryan.  The three drivers listed above appear to be the only
pwm "user" drivers.  They are all trivial and could be updated easily.

The "core" drivers using the existing API appear to be:
arch/arm/mach-vt8500/pwm.c
arch/arm/plat-mxc/pwm.c
arch/arm/plat-pxa/pwm.c
arch/arm/plat-samsung/pwm.c
arch/blackfin/kernel/pwm.c
arch/mips/jz4740/pwm.c
arch/unicore32/kernel/pwm.c
drivers/misc/ab8500-pwm.c
drivers/mfd/twl6030-pwm.c

> There is also the interesting case of the Atmel pwm driver, which does 
> not fit the current pwm api and has its own backlight and leds drivers. 
> Bill's patches addressed this, Sasha's patches do not. If we merge 
> Sasha's patches then we are going to be in the same position as Bill's 
> patches at some point in that we need to change the pwm api (and all its 
> users) to meet the needs of the Atmel (and any similar hardware) pwm device.
> 
> The ep93xx pwm driver (drivers/misc/ep93xx-pwm.c) also does not fit the 
> current api (though it could), but instead provides a sysfs interface to 
> user-space. Again, this was addressed by Bill's patches.

I modified the ep93xx pwm driver previously to work with Bill's patches.
The use for that driver required user-space control of the pwm.  Bill's
patches handle that.

>> We can't convert the function drivers
>> either because again this would break boards for which only an old style
>> pwm driver exists.  So the logical thing to do is to put a step in
>> between: Consolidate the existing drivers and *then* change the API
>> atomically so that nothing breaks. Your patches don't do this, so I
>> don't think at all that what I did is duplication of work.
>
> You have to modify the drivers anyway match the new pwm core. The Atmel 
> and ep93xx drivers are going to be difficult to merge into the new api, 
> and seeing as there are only about seven pwm drivers total in the kernel 
> I think its a significant portion. Any pwm api patchset could easily 
> convert all of the existing pwm drivers without becoming overly massive.
>
> If we merge Sasha's api, then we can move most of the existing drivers 
> and maybe add some new ones, but we will still have the unconsolidated 
> outliers. When (if?) we try to fix those we will probably need to change 
> the pwm api and therefore all of the drivers to. So its basically a case 
> of do the effort now (Bill's patches) or do it later. Doing it later 
> will probably require more effort.
>
>> Given the current rush to move drivers out of arch/ it probably won't
>> take long until all pwm drivers are moved to drivers/pwm/ and converted
>> to use the framework, and then you have a good base to put your work onto.
>> So please don't complain too much: We are currently only doing the work
>> you didn't want to do.
>>
> You can move all of the drivers out of arch now if you want. You just 
> need to make sure you are only compiling one of them in. The real job in 
> consolidating means making sure that the api meets the needs of all of 
> the drivers. The in kernel Atmel pwm driver at least is not going to 
> convert easily to this api.

I think the only open issue with Bill's patches was where the pwm subsystem
belongs.  Some people thought it should be part of gpiolib and others
thought it should be on it's own.  The core library Bill presented does
share some commonality with gpiolib but I feel it still represents it's
own subsystem.  On-chip pwms might also be gpio capable but this is not
always the case.

With Bill's patches we could run into resource conflicts between gpio and
pwm but that really exists now anyway.  The pinmux subsystem that Linus
Walleij (cc'ed) has been proposing should fix that.

Overall I think Bill's patches will get us to the desired end result quicker
and save a lot of needless churn.

Regards,
Hartley
