From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 9 Mar 2015 12:14:10 +0100
Subject: twl4030_charger: need changes to get probed?
In-Reply-To: <20150309110653.7532613c@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.11227.stgit@notabene.brown>
 <20150302210926.GP13270@amd>
 <20150305173350.50502b95@notabene.brown>
 <20150306212417.GA24169@amd> <20150307210102.GL5233@earth>
 <20150309110653.7532613c@notabene.brown>
Message-ID: <20150309111410.GB3914@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 09, 2015 at 11:06:53AM +1100, NeilBrown wrote:
> On Sat, 7 Mar 2015 22:01:02 +0100 Sebastian Reichel <sre@debian.org> wrote:
> > platform_driver_probe() does not support deferred probing.
> > 
> > Neil, can you take this patch into your series for the next round?
> 
> I could, but I do wonder if it is the right thing to do.
> 
> Shouldn't we fix platform_driver_probe() to support deferred probing.

well most drivers use platform_driver_register anyways. Other
subsystems, like e.g. i2c have converted all drivers already.
In drivers/power/ there are only three drivers using
platform_driver_probe:

drivers/power/avs/smartreflex.c - ok here
drivers/power/reset/brcmstb-reboot.c - looks ok, too
drivers/power/twl4030_charger.c - should probably be converted

> As I understand it, it refused to retry a probe if there is an error, and the
> comments suggest that such retrying is avoided because it would be a waste
> of time:
> 
> 	/*
> 	 * Prevent driver from requesting probe deferral to avoid further
> 	 * futile probe attempts.
> 	 */
> 
> In this case, it isn't futile.

All drivers would benefit of being probed again if they returned
EPROBEDEFER, but their probe function can't be called again if
they use driver_platform_probe, since the probe function will be
unloaded when it should be called again. Apart from that the
.probe function pointer is not set. Thus trying to probe the
driver again at a later point is "a waste of time" and "futile",
since it will definitely fail.

> Earlier there is a comment saying:
> 
>  * Use this instead of platform_driver_register() when you know the device
>  * is not hotpluggable and has already been registered, and you want to
>  * remove its run-once probe() infrastructure from memory after the driver
>  * has bound to the device.
> 
> I presume all this applies.  I assume that the only problem is a probe-order
> thing.  So maybe we should fix platform_driver_probe() to do the right thing
> with -EPROBEDEFER??
> 
> Trouble is, I really don't understand the  point or mechanism for
> platform_driver_probe(), so I cannot suggest anything.
> But I have been annoyed before that platform_driver_probe doesn't cope with
> EPROBEDEFER, so I would like it fixed.

platform_driver_probe is not about probe-order, but about not having
the probe function in memory once the driver is loaded. So the probe
function cannot be called again. If you don't want this use
platform_driver_register, as most drivers actually do.

I guess we should add some coccinelle scripts for detection of
potentially broken drivers (e.g. everything requesting gpios/pinctrl
together with platform_driver_register).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150309/992889d1/attachment.sig>
