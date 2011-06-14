From: balbi@ti.com (Felipe Balbi)
Date: Tue, 14 Jun 2011 15:00:00 +0300
Subject: [PATCH 3.0-rc2] OMAP: ams-delta: fix broken uevent sysfs entries
In-Reply-To: <20110614114848.GS3352@atomide.com>
References: <201106070316.41099.jkrzyszt@tis.icnet.pl>
	<20110614114848.GS3352@atomide.com>
Message-ID: <20110614115959.GI2353@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 04:48:48AM -0700, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [110606 18:15]:
> > 
> > Removing __initdata tags, introduced by commit 
> > bdc58fb950a3a1b0bc3cbd8e23d21ecdde2ac9a2, "arm: omap1: fix a bunch of 
> > section mismatches", from corresponding platform_device structures 
> > declared in arch/arm/mach-omap1/board-ams-delta.c, corrects the problem 
> > for me, which may indicate that their members (.name ?) are still 
> > referred to during runtime so they shouldn't be freed after boot.
> 
> Sounds like this needs a bit more research where this initdata
> gets used?

to me it sounds like missing __init/__exit annotations on the driver.
See ams-delta-leds for instance:

static int ams_delta_led_probe(struct platform_device *pdev)
static int ams_delta_led_remove(struct platform_device *pdev)

which means those drivers will have probe sitting outside or .init.text
and trying to reference name which sits in .init.text ??? Could that be
the case here ?

But it could also be that the platform_device shouldn't be marked
__initdata.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110614/62fb9633/attachment-0001.sig>
