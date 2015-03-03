From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Mar 2015 16:13:42 -0800
Subject: [PATCH 10/10] ARM: omap2: use clkdev_add_alias()
In-Reply-To: <E1YSTnw-0001K5-IQ@rmk-PC.arm.linux.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnw-0001K5-IQ@rmk-PC.arm.linux.org.uk>
Message-ID: <20150303001341.GD3756@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [150302 09:10]:
> When creating aliases of existing clkdev clocks, use clkdev_add_alias()
> isntead of open coding the lookup and clk_lookup creation.

Gave this series a quick try but I get these build errors:

arch/arm/mach-omap2/omap_device.c: In function ?_add_clkdev?:
arch/arm/mach-omap2/omap_device.c:65:58: warning: passing argument 3 of ?clk_add_alias? discards ?const? qualifier from pointer target type
  rc = clk_add_alias(clk_alias, dev_name(&od->pdev->dev), clk_name, NULL);
                                                          ^
In file included from arch/arm/mach-omap2/omap_device.c:34:0:
include/linux/clkdev.h:44:5: note: expected ?char *? but argument is of type ?const char *?
 int clk_add_alias(const char *, const char *, char *, struct device *);
     ^
drivers/clk/clkdev.c:298:16: error: expected declaration specifiers or ?...? before ?(? token
 vclkdev_create((struct clk *clk, const char *con_id, const char *dev_fmt,
                ^
drivers/clk/clkdev.c:322:92: error: storage class specified for parameter ?__crc_clkdev_alloc?
 EXPORT_SYMBOL(clkdev_alloc);
                                                                                            ^
drivers/clk/clkdev.c:322:1: warning: ?weak? attribute ignored [-Wattributes]
 EXPORT_SYMBOL(clkdev_alloc);
 ^
drivers/clk/clkdev.c:322:1: warning: ?externally_visible? attribute ignored [-Wattributes]
drivers/clk/clkdev.c:322:161: error: storage class specified for parameter ?__kcrctab_clkdev_alloc?
 EXPORT_SYMBOL(clkdev_alloc);
                                                                                                                                                                 ^
drivers/clk/clkdev.c:322:1: warning: ?__used__? attribute ignored [-Wattributes]
 EXPORT_SYMBOL(clkdev_alloc);
 ^
drivers/clk/clkdev.c:322:161: error: section attribute not allowed for ?__kcrctab_clkdev_alloc?
 EXPORT_SYMBOL(clkdev_alloc);
                                                                                                                                                                 ^
drivers/clk/clkdev.c:322:279: error: expected ?;?, ?,? or ?)? before ?=? token
 EXPORT_SYMBOL(clkdev_alloc);

drivers/clk/clkdev.c:274:1: warning: ?vclkdev_alloc? defined but not used [-Wunused-function]
 vclkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt,

Regards,

Tony
