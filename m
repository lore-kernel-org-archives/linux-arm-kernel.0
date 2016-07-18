From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Jul 2016 12:02:32 +0200
Subject: [v2,1/4] hwmon: iio_hwmon: defer probe when no channel is found
In-Reply-To: <20160716170013.GA27490@roeck-us.net>
References: <1468576754-3273-2-git-send-email-quentin.schulz@free-electrons.com>
 <20160716170013.GA27490@roeck-us.net>
Message-ID: <20160718100232.GE4199@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Sat, Jul 16, 2016 at 10:00:13AM -0700, Guenter Roeck wrote:
> On Fri, Jul 15, 2016 at 11:59:11AM +0200, Quentin Schulz wrote:
> > iio_channel_get_all returns -ENODEV when it cannot find either phandles and
> > properties in the Device Tree or channels whose consumer_dev_name matches
> > iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
> > which might be probed after iio_hwmon.
> > 
> > It is better to defer the probe of iio_hwmon if such error is returned by
> > iio_channel_get_all in order to let a chance to iio drivers to expose
> > channels in iio_map_list.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > ---
> > 
> > No modifications for this patch since we did not settled for a solution.
> > What should we do?
> > 
> AFAICS the only thing we can do is to replace module_platform_driver() with
> its explicitly coded variant, and to use use late_initcall() instead of
> module_init().

I thought this kind of changes to the driver init time were
discouraged these days?

> Anything else would result in endless probe deferrals if there are
> no channels.

Well, technically, not endless. AFAIK, the kernel only retries when a
new driver is probed, which should hopefully settle down rather
quickly.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160718/058276cc/attachment.sig>
