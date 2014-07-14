From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 14 Jul 2014 15:36:48 +0200
Subject: [PATCH v2 6/7] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <20140708132216.GA4979@htj.dyndns.org>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
 <1403101406-15439-7-git-send-email-mperttunen@nvidia.com>
 <20140708132216.GA4979@htj.dyndns.org>
Message-ID: <53C3DCF0.3030001@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/08/2014 03:22 PM, Tejun Heo wrote:
> (cc'ing Hans)
> 
> Hans, can you please review this patch?

Done.

Mikko, it looks like you are doing a lot of stuff
the DIY way. I can see there are good reasons for
that though.

Still it would be nice if you could use a little bit
more of the helper functions provided by libahci_platform.c

Specifically I think it would be better if you used
ahci_platform_get_resources, that would remove a lot of
duplicate code from the new driver.

To be specific I would like to suggest that you
raise AHCI_MAX_CLKS to 4, and then specify an order
in which the clks must be listed in the devicetree
binding. Then you can put that order in an enum
and use hpriv->clks[CLK_FOO] in your driver, where
CLK_FOO comes from the enum.

This way you should be able to use ahci_platform_get_resources
and drop doing the iomap of the base registers, all the
clk_gets and the phy_get yourself.

You could then also use ahci_platform_disable_clks() in
tegra_ahci_power_off

Regards,

Hans
