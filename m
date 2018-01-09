From: stefan@agner.ch (Stefan Agner)
Date: Tue, 09 Jan 2018 22:08:31 +0100
Subject: soc: imx: gpcv2: removing and probing fails
In-Reply-To: <1515509738.12538.35.camel@pengutronix.de>
References: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
 <1515507886.12538.33.camel@pengutronix.de>
 <d71311e13720724b3b3bccd06fe9309b@agner.ch>
 <1515509738.12538.35.camel@pengutronix.de>
Message-ID: <0a0c556cedc3b6448919748081445780@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-09 15:55, Lucas Stach wrote:
> Am Dienstag, den 09.01.2018, 15:44 +0100 schrieb Stefan Agner:
>> On 2018-01-09 15:24, Lucas Stach wrote:
>> > Am Sonntag, den 07.01.2018, 11:48 +0100 schrieb Stefan Agner:
>> > > Hi Andrew,
>> > >
>> > > I noticed that the driver fails when removing and probing again.
>> > > As far
>> > > as I can see due to duplicate add of the platform devices.
>> > >
>> > > As far as I can tell the driver should register the remove
>> > > callback and
>> > > do a platform_device_unregister on the newly created platform
>> > > devices.
>> > > However, as far as I can tell we don't hold on to a reference to
>> > > them...
>> > > I guess we could keep references in imx_gpcv2_probe, but maybe
>> > > there is
>> > > an easier way?
>> >
>> > The GPC v1 driver adds the necessary device dependency between the
>> > power domain devices and the GPC parent device. See the
>> > device_link_add() in imx_pgc_power_domain_probe().
>>
>> Note that despite device_link_add, GPC v1 seems to cause issue with
>> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y:
>> https://marc.info/?l=linux-arm-kernel&m=151544599904423&w=4
>>
>> (sorry, I made it confusing, by adding a stack trace when using GPC
>> v1
>> in the gpcv2 thread...)
> 
> IMHO this is an issue with the?CONFIG_DEBUG_TEST_DRIVER_REMOVE option,
> as it just blindly calls the remove callback instead of doing a proper
> __device_release_driver(). All the regular driver/device unbind paths
> will properly unbind the consumer devices before removing the driver.

They do unbind the consumer device, but do not unregister the platform
device.

I tried to fix it by calling platform_device_unregister, e.g. with this
changes unbind seems to work:

--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -40,6 +40,7 @@
 
 struct imx_pm_domain {
        struct generic_pm_domain base;
+       struct platform_device *pdev;
        struct regmap *regmap;
        struct regulator *supply;
        struct clk *clk[GPC_CLK_MAX];
@@ -462,6 +465,8 @@ static int imx_gpc_probe(struct platform_device
*pdev)
                                of_node_put(np);
                                return ret;
                        }
+
+                       domain->pdev = pd_pdev;
                }
        }
 
@@ -470,7 +475,7 @@ static int imx_gpc_probe(struct platform_device
*pdev)
 
 static int imx_gpc_remove(struct platform_device *pdev)
 {
-       int ret;
+       int i, ret;
 
        /*
         * If the old DT binding is used the toplevel driver needs to
@@ -489,6 +494,21 @@ static int imx_gpc_remove(struct platform_device
*pdev)
                        return ret;
        }
 
+
+       for (i = 0; i < ARRAY_SIZE(imx_gpc_domains); i++) {
+               struct imx_pm_domain *domain = &imx_gpc_domains[i];
+
+               if (domain->pdev) {
+                       /*
+                        * Unlink platform_data to prevent
+                        * platform_device_unregister to kfree it.
+                        */
+                       domain->pdev->dev.platform_data = NULL;
+                       platform_device_unregister(domain->pdev);
+                       domain->pdev = NULL;
+               }
+       }
+
        return 0;
 }


However, it still leads to a stacktrace on next bind:

root at colibri-imx6:~# echo 20dc000.gpc >
/sys/bus/platform/drivers/imx-gpc/bind
[   24.741624] imx-pgc-pd imx-pgc-power-domain.0: Linked as a consumer
to 20dc000.gpc
[   24.749219] ------------[ cut here ]------------
[   24.753934] WARNING: CPU: 0 PID: 430 at drivers/base/core.c:417
device_links_driver_bound+0xd8/0xe0
...

--
Stefan
