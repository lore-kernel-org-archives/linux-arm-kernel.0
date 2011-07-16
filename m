From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Sun, 17 Jul 2011 01:37:40 +0530
Subject: [PATCH 3/4] dt: omap3: add generic board file for dt support
In-Reply-To: <CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
Message-ID: <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ps: posting again since my mailer has triggered the mail in html format hence
it does not reach some mailing lists.

Hi Grant,

>
On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>> On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
>> >
>> > The generic board file is created and derived from beagle board file.
>> > The beagle board file is migrated to boot from flattened device tree and
>> > the cleanup of generic board file will happen in different stages.
>> >
>> > The changes here focus on i2c device registration through dt and upcoming
>> > patches in the series will adopt i2c driver to use dt registered i2c
>> > devices.
>>
>> Since this is a new board file instead of a modification of an
>> existing one, I recommend *not* trying to completely duplicate the
>> behaviour of the beagle board.  Start small with only the registration
>> of the UART and i2c drivers from the device tree and build up
>> functionality until it can be used for all the OMAP3 boards.
>> Otherwise the patch just adds a lot of code that needs to be removed
>> again.
>

agreed. Started with minimal board file with only serial and i2c.

>>
>> >
>> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/Kconfig             |   12 +
>> >  arch/arm/mach-omap2/Makefile            |    2 +
>> >  arch/arm/mach-omap2/board-omap3-dt.c    |  623 +++++++++++++++++++++++++++++++
>> >  arch/arm/mach-omap2/board-omap3beagle.c |   13 -
>> >  4 files changed, 637 insertions(+), 13 deletions(-)
>> >  create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
>> >
>> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> > index 19d5891..174f6d1 100644
>> > --- a/arch/arm/mach-omap2/Kconfig
>> > +++ b/arch/arm/mach-omap2/Kconfig
>> > @@ -302,6 +302,18 @@ config MACH_OMAP_3630SDP
>> >        default y
>> >        select OMAP_PACKAGE_CBP
>> >
>> > +config MACH_OMAP3_DT
>> > +       bool "Generic OMAP3 board(FDT support)"
>> > +       depends on ARCH_OMAP3
>> > +       select OMAP_PACKAGE_CBB
>> > +       select USE_OF
>> > +       select PROC_DEVICETREE
>>
>> Don't select PROC_DEVICETREE
>
ok
>>
>> > +
>> > +       help
>> > +         Support for generic TI OMAP3 boards using Flattened Device Tree.
>> > +         Say Y here to enable OMAP3 device tree support
>> > +         More information at Documentation/devicetree
>> > +
>> >  config MACH_TI8168EVM
>> >        bool "TI8168 Evaluation Module"
>> >        depends on SOC_OMAPTI816X
>> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>> > index b148077..86e66f7 100644
>> > --- a/arch/arm/mach-omap2/Makefile
>> > +++ b/arch/arm/mach-omap2/Makefile
>> > @@ -178,6 +178,8 @@ obj-$(CONFIG_MACH_OMAP_H4)          += board-h4.o
>> >  obj-$(CONFIG_MACH_OMAP_2430SDP)                += board-2430sdp.o \
>> >                                           hsmmc.o
>> >  obj-$(CONFIG_MACH_OMAP_APOLLON)                += board-apollon.o
>> > +obj-$(CONFIG_MACH_OMAP3_DT)            += board-omap3-dt.o \
>> > +                                          hsmmc.o
>> >  obj-$(CONFIG_MACH_OMAP3_BEAGLE)                += board-omap3beagle.o \
>> >                                           hsmmc.o
>>
>> This is an odd construct.  Tony, why does each board add hsmmc to the
>> oby-y variable instead of it having its own kconfig symbol?
>>
>> > +static void __init omap3_init(void)
>> > +{
>> > +       struct device_node *node;
>> > +
>> > +       node = of_find_matching_node_by_address(NULL, omap3_dt_intc_match,
>> > +                                               OMAP34XX_IC_BASE);
>> > +       if (node)
>> > +               irq_domain_add_simple(node, 0);
>> > +
>> > +       omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>> > +       omap3_beagle_init_rev();
>> > +       omap3_beagle_i2c_init();
>> > +       platform_add_devices(omap3_beagle_devices,
>> > +                       ARRAY_SIZE(omap3_beagle_devices));
>> > +       omap_display_init(&beagle_dss_data);
>> > +       omap_serial_init();
>> > +
>> > +       omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>> > +       /* REVISIT leave DVI powered down until it's needed ... */
>> > +       gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
>> > +
>> > +       usb_musb_init(NULL);
>> > +       usbhs_init(&usbhs_bdata);
>> > +       omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
>> > +                            ARRAY_SIZE(omap3beagle_nand_partitions));
>> > +
>> > +       /* Ensure msecure is mux'd to be able to set the RTC. */
>> > +       omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
>> > +
>> > +       /* Ensure SDRC pins are mux'd for self-refresh */
>> > +       omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>> > +       omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>> > +
>> > +       beagle_display_init();
>> > +       beagle_opp_init();
>> > +       of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>>
>> Hmmm, I don't think this will work for OMAP because it will not create
>> the i2c bus as an omap_device.  It will only be a plane
>> platform_deevice.  You'll need to have a hook in
>> of_platform_populate() to create devices the way omap3 infrastructure
>> expects.
>>
>
This dependency is mentioned in patch series. Since you pointed out this
issue, I would like to propose following approach for hooking up omap hwmod?
framework with dt. Though, the current approach focus only on i2c driver, it
can be extended and generalized as it evolves with other board and
driver cleanup
activities. The following changes are not tested and also not compiled,  it is
only proposal I am thinking to implement.

Let me know if you see any serious issues with the approach.

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c1773456..104ef31 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -457,6 +457,8 @@ void of_platform_prepare(struct device_node *root,
        }
 }

+
+
 #ifdef CONFIG_ARM_AMBA
 static struct amba_device *of_amba_device_create(struct device_node *node,
                                                 const char *bus_id,
@@ -537,13 +539,60 @@ static const struct of_dev_auxdata
*of_dev_lookup(const struct of_dev_auxdata *l
                                continue;
                        if (res.start != lookup->phys_addr)
                                continue;
-                       pr_debug("%s: devname=%s\n", np->full_name,
lookup->name);
+                       printk("%s: devname=%s\n", np->full_name, lookup->name);
                        return lookup;
                }
        }
        return NULL;
 }

+static struct omap_device *of_omap_i2c_device_create(struct device_node *node,
+                                                const char *bus_id,
+                                                void *platform_data,
+                                                struct device *parent)
+{
+       struct platform_device *pdev;
+       struct i2c_board_info *i2c_board_info;
+       u8 id;
+
+       printk("Creating omap i2c device %s\n", node->full_name);
+
+       if (!of_device_is_available(node))
+               return NULL;
+
+       id = simple_strtol(bus_id, NULL, 0);
+       pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
+       pdev->dev.of_node = of_node_get(node);
+       if (!pdev->dev.of_node) {
+               speed = 100;
+       } else {
+               u32 prop;
+               if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+                                                                       &prop))
+                       speed = prop/100;
+               else
+                       speed = 100;
+       }
+       printk("%s : speed->%d\n",__func__, speed);
+
+       for_each_child_of_node(bus, child) {
+               u32 prop;
+
+               printk("   create child: %s\n", child->full_name);
+               i2c_board_info = kzalloc(sizeof(*i2c_board_info), GFP_KERNEL);
+               if (!of_property_read_u32(pdev->dev.of_node, "reg",
+                                                               &prop))
+               i2c_board_info->addr = prop;
+               if (!of_property_read_u32(pdev->dev.of_node, "interrupts",
+                                                               &prop))
+               i2c_board_info->irq = prop;
+               i2c_board_info->platform_data = platform_data;
+               strncpy(i2c_board_info->type, child->name,
+                                       sizeof(i2c_board_info->type));
+       }
+       omap_register_i2c_bus(id, speed, i2c_board_info, 1);
+}
+
 /**
  * of_platform_bus_create() - Create a device for a node and its children.
  * @bus: device node of the bus to instantiate
@@ -593,6 +642,11 @@ static int of_platform_bus_create(struct device_node *bus,
                return 0;
        }

+       if (of_device_is_compatible(bus, "ti,omap3-i2c")) {
+               of_omap_i2c_device_create(bus, bus_id, platform_data, parent);
+               return 0;
+       }
+
        dev = of_platform_device_create_pdata(bus, bus_id,
platform_data, parent);
        if (!dev || !of_match_node(matches, bus))
                return 0;

-M
