From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 11 Nov 2011 15:25:01 +0000
Subject: [PATCH 1/2] ARM: mx28evk: remove flexcan_pdata __initconst
 attribute
In-Reply-To: <20111111150609.GD5011@pengutronix.de>
References: <1321024360-5249-1-git-send-email-b29396@freescale.com>
 <20111111150609.GD5011@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722CECED@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> Sent: Friday, November 11, 2011 11:06 PM
> To: Dong Aisheng-B29396
> Cc: linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de;
> s.hauer at pengutronix.de; w.sang at pengutronix.de; Guo Shawn-R65073
> Subject: Re: [PATCH 1/2] ARM: mx28evk: remove flexcan_pdata __initconst
> attribute
> 
> On Fri, Nov 11, 2011 at 11:12:39PM +0800, Dong Aisheng wrote:
> > The flexcan driver still uses it after init.
> As "it" is a copy of flexcan_pdata it's completely OK for the driver to
> use it.
> 
> What is the exact problem you want to address?
>
Sorry, I just checked the code and found platform_device_add_data will
Add a copy of platform specific data.
Originally I thought the driver may access the freed pdata after init.

So, does it mean that every pdata of pdevice added
by mxs_add_platform_device_dmamask can be prefixed by __init*?

And, below change seems correct?
diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
index 0fcff47..a096cca 100644
--- a/arch/arm/mach-mxs/module-tx28.c
+++ b/arch/arm/mach-mxs/module-tx28.c
@@ -66,11 +66,11 @@ static const iomux_cfg_t tx28_fec1_pads[] __initconst = {
        MX28_PAD_ENET0_CRS__ENET1_RX_EN,
 };

-static struct fec_platform_data tx28_fec0_data = {
+static struct fec_platform_data __initconst tx28_fec0_data = {
        .phy = PHY_INTERFACE_MODE_RMII,
 };

-static struct fec_platform_data tx28_fec1_data = {
+static struct fec_platform_data __initconst tx28_fec1_data = {
        .phy = PHY_INTERFACE_MODE_RMII,
 };

Regards
Dong Aisheng
