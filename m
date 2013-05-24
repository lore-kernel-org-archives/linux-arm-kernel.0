From: b32955@freescale.com (Huang Shijie)
Date: Fri, 24 May 2013 15:16:53 +0800
Subject: [PATCH V2 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <201305231509.57651.arnd@arndb.de>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <201305231153.38111.arnd@arndb.de> <20130523115505.GG32299@pengutronix.de>
 <201305231509.57651.arnd@arndb.de>
Message-ID: <519F13E5.2040701@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?23? 21:09, Arnd Bergmann ??:
> OTOH, I agree that it would be nicer if the clk could remain turned
> off as long as no children are active. Can we do a clk_disable()
> after setting up the timings for the children and then expect those
> to actually start up the clk again when they need it?
>
> Or to take things further: would it make sense to represent WEIM
> itself as a clock driver and perform the settings for each child
> only when it sets up its own clk?
>
If the child's subsystem supports it, we can do it.

The mtd nand does support this feature, it has @select_chip() hook.
We can enable/disable the clock in the @select_chip().

But the mtd NOR does _not_ supports it.
Please read the /drivers/mtd/maps/physmap_of.c and 
/drivers/mtd/chips/cfi_cmd_set_xxx.c.
Of course, we can add the feature to NOR subsystem. But that's another 
issue.

So the weim should enable the clock all the time now.


> I guess it would also make sense to use of_platform_populate() instead
> of of_platform_device_create() when creating the children, so we actually
I tried the of_platform_populate(), but failed.

firstly, we should set the timing for the device _before_ we do the 
of_platform_populate().
and i rewrite the weim_parse_dt() to:
------------------------------------------------------------------------------------------
static void weim_parse_dt(struct platform_device *pdev)
{
     struct device_node *child;

     for_each_child_of_node(pdev->dev.of_node, child) {
         if (!child->name)
             continue;

         if (weim_timing_setup(pdev, child)) {
             dev_err(&pdev->dev, "%s set timing failed.\n",
                 child->full_name);
             continue;
         }

     }
     if (!of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev))
         dev_err(&pdev->dev, "%s device create failed.\n",
             child->full_name);
}
------------------------------------------------------------------------------------------

The system hang at :
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Booting kernel from Legacy Image at 10800000 ...
    Image Name:   Linux
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    4259851 Bytes =  4.1 MB
    Load Address: 10008000
    Entry Point:  10008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==



thanks
Huang Shijie
