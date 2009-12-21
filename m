From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 21 Dec 2009 16:00:04 +0100
Subject: [PATCH 0/2] mx31moboard for 2.6.33-rc1
In-Reply-To: <20091221111726.GF15126@pengutronix.de>
References: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
	<20091221111726.GF15126@pengutronix.de>
Message-ID: <1261407604.2144.16.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il giorno lun, 21/12/2009 alle 12.17 +0100, Sascha Hauer ha scritto:
> On Fri, Dec 18, 2009 at 06:11:31PM +0100, Valentin Longchamp wrote:
> > I have tested mx31moboard with the first -rc. Here are two patches correcting the current problems. They should go to a next -rc.
> > 
> > 1) The patches for usbh support were based on the bad branch, where
> > the platform_devices had been renamed. Now this prevents the mx3
> > config to build. The first patch reverts to the correct names.
> > 
> > 2) The MC13783 voltage regulators with boot_on or always_on enabled
> > hang the kernel at boot. Remove these options from mx31moboard
> > configuration. Sascha, is this a correct behavior or is it a bug ?
> 
> AFAIK the boot_on indicate the regulator framework that this regulator
> is already enabled when the kernel starts. I don't see why this makes
> the kernel hang. Can you do a bit more debugging please?
> 
> Sascha
> 

The patch that I proposed:
[PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783 before subsystems initialisation.
solve the problem I think.

If you enable the debug output on drivers/mfd/mc13783-core and you see that the
kernel hang on the mc13783 waiting queue, than my patch is for you.

With boot_on = 1 the regulator core ensure also that the regulator is
enabled during probe, so it call the corresponding enable function.
That function utilise the mc13783-API that are still locked.

mc13783-regulator now is probed when mc13783-core register it's regulator
subsystem.

For now that patch (acked by Uwe Kleine-K?nig) is not applied to the mfd tree.

Alberto!
