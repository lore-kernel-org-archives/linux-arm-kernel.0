From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 07 Aug 2017 17:21:26 +0200
Subject: [PATCH 3/4] thermal: exynos: constify
 thermal_zone_of_device_ops structures
In-Reply-To: <1501965437-30730-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
 <CGME20170805210250epcas2p2f6a808ee6e3e20cd1dc19457b96ddbf4@epcas2p2.samsung.com>
 <1501965437-30730-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <2246245.2R0fntX3Po@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, August 05, 2017 10:37:16 PM Julia Lawall wrote:
> The thermal_zone_of_device_ops structure is only passed as the fourth
> argument to thermal_zone_of_sensor_register, which is declared as const.
> Thus the thermal_zone_of_device_ops structure itself can be const.
> 
> Done with the help of Coccinelle.
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct thermal_zone_of_device_ops i at p = { ... };
> 
> @ok1@
> identifier r.i;
> expression e1,e2,e3;
> position p;
> @@
> thermal_zone_of_sensor_register(e1,e2,e3,&i at p)
> 
> @bad@
> position p != {r.p,ok1.p};
> identifier r.i;
> struct thermal_zone_of_device_ops e;
> @@
> e at i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct thermal_zone_of_device_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Eduardo/Zhang, Please queue this patch for upstream, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
