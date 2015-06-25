From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Jun 2015 09:51:33 +0100
Subject: [linux-sunxi] Re: [PATCH v2 3/4] mfd: axp20x: Add a cell for the
 usb power_supply part of the axp20x PMICs
In-Reply-To: <558AC6FC.1050603@redhat.com>
References: <1434211748-25572-1-git-send-email-hdegoede@redhat.com>
 <1434211748-25572-4-git-send-email-hdegoede@redhat.com>
 <20150624112333.GH15013@x1> <558AC6FC.1050603@redhat.com>
Message-ID: <20150625085133.GY15013@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jun 2015, Hans de Goede wrote:
> On 24-06-15 13:23, Lee Jones wrote:
> >>Add a cell for the usb power_supply part of the axp20x PMICs.
> >
> >Why are you duplicating the subject line?
> 
> Heh, because some maintainers insist that the main-body part of the
> commit message must stand by itself, without needing the subject to be
> understandable...

Some Maintainers are crazy. ;)

> >>Note that this cell is only for the usb power_supply part and not the
> >>ac-power / battery-charger / rtc-backup-bat-charger bits.
> >>
> >>Depending on the board each of those must be enabled / disabled separately
> >>in devicetree as most boards do not use all 4. So in dt each one needs its
> >>own child-node of the axp20x node. Another reason for using separate child
> >>nodes for each is so that other devicetree nodes can have a power-supply
> >>property with a phandle referencing a node representing a single
> >>power-supply.
> >>
> >>The decision to use a separate devicetree node for each is reflected on
> >>the kernel side by each getting its own mfd-cell / platform_device and
> >>platform-driver.
> >
> >You don't really need to say any of this, as this is the 'norm'.
> 
> I agree it should be the norm, but I'm not sure if it actually is, while
> working on this I've seen several drivers which instantiate multiple
> power-supply class devices from a single mfd-cell. And this is what
> Bruno's original patches did, so I would prefer to keep this

Up to you, but it's really not required.  No one else says this stuff.

> >What you didn't mention however, is that you're taking the opportunity
> >to fix some formatting issues and that there are no functional changes
> >in these lines.
> 
> That is the end result of your request to change the indentation to
> avoid line-wrapping :)

Fine, you can add my Suggested-by too then [don't actually do that],
but regardless of where the idea came from you should still tell us
what the patch does in the commit log.  I was looking for functional
differences within those formatting changes.  If I wanted to be really
religious about it I would [rightly] say "don't mix functional changes
with clean-ups", but instead I'll politely ask for a quick mention in
the commit log when you re-submit.  Aren't I nice?! ;)

> >>Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>Changes in v2:
> >>-Use DEFINE_RES_IRQ_NAMED
> >>-Change indentation of axp20x_cells initializers to avoid line wrapping
> >>---
> >>  drivers/mfd/axp20x.c | 20 ++++++++++++++++----
> >>  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> >Patch looks okay however:
> >
> >Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks.
> 
> Regards,
> 
> Hans
> 
> 
> >
> >>diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> >>index f9a3c2d..ca4a604 100644
> >>--- a/drivers/mfd/axp20x.c
> >>+++ b/drivers/mfd/axp20x.c
> >>@@ -113,6 +113,13 @@ static struct resource axp20x_pek_resources[] = {
> >>  	},
> >>  };
> >>
> >>+static struct resource axp20x_usb_power_supply_resources[] = {
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_VALID, "VBUS_VALID"),
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
> >>+};
> >>+
> >>  static struct resource axp22x_pek_resources[] = {
> >>  	{
> >>  		.name   = "PEK_DBR",
> >>@@ -363,11 +370,16 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
> >>
> >>  static struct mfd_cell axp20x_cells[] = {
> >>  	{
> >>-		.name			= "axp20x-pek",
> >>-		.num_resources		= ARRAY_SIZE(axp20x_pek_resources),
> >>-		.resources		= axp20x_pek_resources,
> >>+		.name		= "axp20x-pek",
> >>+		.num_resources	= ARRAY_SIZE(axp20x_pek_resources),
> >>+		.resources	= axp20x_pek_resources,
> >>  	}, {
> >>-		.name			= "axp20x-regulator",
> >>+		.name		= "axp20x-regulator",
> >>+	}, {
> >>+		.name		= "axp20x-usb-power-supply",
> >>+		.of_compatible	= "x-powers,axp202-usb-power-supply",
> >>+		.num_resources	= ARRAY_SIZE(axp20x_usb_power_supply_resources),
> >>+		.resources	= axp20x_usb_power_supply_resources,
> >>  	},
> >>  };
> >>
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
