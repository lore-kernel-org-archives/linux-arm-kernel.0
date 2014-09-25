From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 25 Sep 2014 14:21:52 +0200
Subject: [PATCH v5] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <13449286.k3JCbR2ABy@phil>
References: <1411360807-7750-1-git-send-email-pankaj.dubey@samsung.com>
 <CAGhQ9VzZ8LadDT5RWUSX89q0WP3fGiQ8f=bWbRVfEz5Vy_zZKw@mail.gmail.com>
 <13449286.k3JCbR2ABy@phil>
Message-ID: <4389453.TP96FZcCbx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 24. September 2014, 20:35:10 schrieb Heiko St?bner:
> Hi Pankaj, Joachim,
> 
> Am Dienstag, 23. September 2014, 20:12:50 schrieb Joachim Eastwood:
> > On 22 September 2014 06:40, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> > > Currently a syscon entity can be only registered directly through a
> > > platform device that binds to a dedicated syscon driver. However in
> > > certain use cases it is desirable to make a device used with another
> > > driver a syscon interface provider.
> > > 
> > > For example, certain SoCs (e.g. Exynos) contain system controller
> > > blocks which perform various functions such as power domain control,
> > > CPU power management, low power mode control, but in addition contain
> > > certain IP integration glue, such as various signal masks,
> > > coprocessor power control, etc. In such case, there is a need to have
> > > a dedicated driver for such system controller but also share registers
> > > with other drivers. The latter is where the syscon interface is helpful.
> > > 
> > > In case of DT based platforms, this patch decouples syscon object from
> > > syscon platform driver, and allows to create syscon objects first time
> > > when it is required by calling of syscon_regmap_lookup_by APIs and keep
> > > a list of such syscon objects along with syscon provider device_nodes
> > > and regmap handles.
> > > 
> > > For non-DT based platforms, this patch keeps syscon platform driver
> > > structure where is can be probed and such non-DT based drivers can use
> > > syscon_regmap_lookup_by_pdev API and get access to regmap handles.
> > > Once all users of "syscon_regmap_lookup_by_pdev" migrated to DT based,
> > > we can completly remove platform driver of syscon, and keep only helper
> > > functions to get regmap handles.
> > > 
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> > > Tested-by: Vivek Gautam <gautam.vivek@samsung.com>
> > > Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > 
> > I wrote a clk driver using syscon and your patch. clk driver uses
> > CLK_OF_DECLARE, btw.
> > 
> > It works but I get a '(null): Failed to create debugfs directory'
> > message in the boot log.
> > 
> > Tested-by: Joachim Eastwood <manabian@gmail.com>
> 
> on Rockchip platforms this syscon support also helps quite a bit, as the
> pll lock-status is sitting in an external syscon register, so setting target
> pll-rates through assigned-clocks is not easily doable without it.
> Therefore I'm very much looking forward to this.
> 
> 
> Similar to Joachim I get an error about debugfs from regmap, which seems
> to be caused by
> 	name = dev_name(map->dev);
> returning NULL in regmap_debugfs_init in regmap-debugfs.c for such an
> "early" syscon.

It looks like of_device_make_bus_id would be able to do the necessary steps
to populate the dev_name seemingly correctly.

With the diff below I now get a syscon that can init clocks and also a
sane regmap debugfs init:

/debug/regmap # ls -la
total 0
drwxr-xr-x    5 0        0                0 Jan  1  1970 .
drwx------   19 0        0                0 Jan  1  1970 ..
drwxr-xr-x    2 0        0                0 Jan  1  1970 0-001b
drwxr-xr-x    2 0        0                0 Jan  1  1970 ff730000.power-management
drwxr-xr-x    2 0        0                0 Jan  1  1970 ff770000.syscon


But of course I don't know enough about device-internals to determine if
this is an insane solution or not :-)


Heiko


diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 8ebc1c6..3734434 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -73,6 +73,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
                        goto err_pdev;
                }
                pdev->dev.of_node = of_node_get(np);
+               of_device_make_bus_id(&pdev->dev);
        }
 
        regmap = devm_regmap_init_mmio(&pdev->dev, base, &syscon_regmap_config);
