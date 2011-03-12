From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 12 Mar 2011 17:11:17 +0100
Subject: [PATCH] net/fec: check id_entry pointer before using it
In-Reply-To: <AANLkTimMEup3ThmMpfGAWVTgsCSEyK=5Ke=+ZjJd169R@mail.gmail.com>
References: <1299639004-21546-1-git-send-email-jason.hui@linaro.org>
	<20110309082601.GA3145@pengutronix.de>
	<AANLkTimMEup3ThmMpfGAWVTgsCSEyK=5Ke=+ZjJd169R@mail.gmail.com>
Message-ID: <20110312161117.GA26263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 10:41:37AM +0800, Jason Liu wrote:
> Hi, Wolfram Sang,
> 
> 2011/3/9 Wolfram Sang <w.sang@pengutronix.de>:
> > On Wed, Mar 09, 2011 at 10:50:04AM +0800, Jason Liu wrote:
> >> The id_entry will possibly be NULL, So, need check
> >> id_entry and make sure it not NULL before using it.
> >
> > When does it become NULL?
> 
> look at the code:drivers/base/platform.c
> 
> static int platform_match(struct device *dev, struct device_driver *drv)
> {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct platform_driver *pdrv = to_platform_driver(drv);
> 
>         /* Attempt an OF style match first */
>         if (of_driver_match_device(dev, drv))
>                 return 1;
> 
>         /* Then try to match against the id table */
>         if (pdrv->id_table)
>                 return platform_match_id(pdrv->id_table, pdev) != NULL;
> 
>         /* fall-back to driver name match */
>         return (strcmp(pdev->name, drv->name) == 0);
> }
> 
> If OF style match first succeed, the function will return and the
> pdev->id_entry will not get set and it's NULL.

This is correct. Yet, OF might be interested in using the flags from the
fec-driver, too. If there will be a user (there is none yet), part of the
update patch probably should add something like this to probe:

if (id_entry)
	fec_flags = id_entry->driver_data;
else if (of_id)
	fec_flags = of_id->data;
else
	/* Deal with it... */

Makes sense?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110312/4b2d6f44/attachment.sig>
