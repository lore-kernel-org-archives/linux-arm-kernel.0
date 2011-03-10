From: liu.h.jason@gmail.com (Jason Liu)
Date: Thu, 10 Mar 2011 10:41:37 +0800
Subject: [PATCH] net/fec: check id_entry pointer before using it
In-Reply-To: <20110309082601.GA3145@pengutronix.de>
References: <1299639004-21546-1-git-send-email-jason.hui@linaro.org>
	<20110309082601.GA3145@pengutronix.de>
Message-ID: <AANLkTimMEup3ThmMpfGAWVTgsCSEyK=5Ke=+ZjJd169R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Wolfram Sang,

2011/3/9 Wolfram Sang <w.sang@pengutronix.de>:
> On Wed, Mar 09, 2011 at 10:50:04AM +0800, Jason Liu wrote:
>> The id_entry will possibly be NULL, So, need check
>> id_entry and make sure it not NULL before using it.
>
> When does it become NULL?

look at the code:drivers/base/platform.c

static int platform_match(struct device *dev, struct device_driver *drv)
{
        struct platform_device *pdev = to_platform_device(dev);
        struct platform_driver *pdrv = to_platform_driver(drv);

        /* Attempt an OF style match first */
        if (of_driver_match_device(dev, drv))
                return 1;

        /* Then try to match against the id table */
        if (pdrv->id_table)
                return platform_match_id(pdrv->id_table, pdev) != NULL;

        /* fall-back to driver name match */
        return (strcmp(pdev->name, drv->name) == 0);
}

If OF style match first succeed, the function will return and the
pdev->id_entry will not get set and it's NULL.

BR,
Jason

>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk13OZkACgkQD27XaX1/VRsZgwCeKCNK0ufdrV2186pKO3jD9qfI
> HcQAn1zZ+Rmv+rpHHQH9JNyMQitNQdXV
> =Ha2Y
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
