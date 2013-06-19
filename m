From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 19 Jun 2013 02:37:37 +0200
Subject: [PATCH 1/8] ARM: shmobile: sh73a0 pinmux platform device cleanup
In-Reply-To: <20130611044847.GH15593@verge.net.au>
References: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
 <1722811.MCTrRecTtK@avalon> <20130611044847.GH15593@verge.net.au>
Message-ID: <2964836.jixPqCY20h@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tuesday 11 June 2013 13:48:47 Simon Horman wrote:
> On Mon, Jun 10, 2013 at 02:31:31PM +0200, Laurent Pinchart wrote:
> > On Tuesday 04 June 2013 22:20:59 Simon Horman wrote:
> > > On Tue, Jun 04, 2013 at 02:20:43PM +0900, Simon Horman wrote:
> > > > On Mon, May 27, 2013 at 09:02:43PM -0700, Olof Johansson wrote:
> > > > > On Mon, May 27, 2013 at 06:13:22PM +0400, Sergei Shtylyov wrote:
> > > > > > On 27-05-2013 13:00, Simon Horman wrote:
> > > > > > >From: Magnus Damm <damm@opensource.se>
> > > > > > >
> > > > > > >Use DEFINE_RES_MEM() and platform_device_register_simple()
> > > > > > >to save a couple of lines of code.
> > > > > > >
> > > > > > >Signed-off-by: Magnus Damm <damm@opensource.se>
> > > > > > >Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > > >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > > > >---
> > > > > > >
> > > > > > >  arch/arm/mach-shmobile/setup-sh73a0.c |   25
> > > > > > >  ++++++-------------------
> > > > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > > > >
> > > > > > >diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
> > > > > > >b/arch/arm/mach-shmobile/setup-sh73a0.c index fdf3894..f8f4261
> > > > > > >100644
> > > > > > >--- a/arch/arm/mach-shmobile/setup-sh73a0.c
> > > > > > >+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> > > > > > >@@ -61,29 +61,16 @@ void __init sh73a0_map_io(void)
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > >+/* PFC */
> > > > > > >+static const struct resource pfc_resources[] = {
> > > > > > >
> > > > > >    Should have been annotated as __initdata... too late, need
> > > > > > 
> > > > > > another patch.
> > > > > 
> > > > > See comments on other patches/pull requests, I think there's time to
> > > > > revisit this. I.e. I'll hold off on pulling this based on the other
> > > > > feedback.
> > > > 
> > > > As I am respining I will fix this.
> > > > 
> > > > However, it had been reviewed and I think that ordinarily
> > > > it would be reasonable to perform further clean-up
> > > > work in a subsequent patch.
> > > 
> > > I decided to simply drop the patch and revisit it later.
> > 
> > This patch (as well as the sh7372 equivalent) is pretty simple. What about
> > just adding __initdata and resubmitting them ? Otherwise they will get
> > lost.
>
> Sure. I took a look at doing this but with the patch below applied I see:
> 
> # make kzm9g_defconfig
> # make
> In file included from arch/arm/mach-shmobile/setup-sh73a0.c:27:
> include/linux/platform_device.h: In function ?sh73a0_pinmux_init?:
> arch/arm/mach-shmobile/setup-sh73a0.c:65: error: pfc_resources causes a
> section type conflict

That's strange, I don't get that warning with

$ arm-linux-gnueabihf-gcc --version
arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.7-2013.02-01-20130221 - 
Linaro GCC 2013.02) 4.7.3 20130205 (prerelease)

> From 23ea305bcb4513e33ad636b1c735439993fcff74 Mon Sep 17 00:00:00 2001
> From: Magnus Damm <damm@opensource.se>
> Date: Mon, 27 May 2013 09:00:45 +0000
> Subject: [PATCH] ARM: shmobile: sh73a0 pinmux platform device cleanup
> 
> Use DEFINE_RES_MEM() and platform_device_register_simple()
> to save a couple of lines of code.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> [ Annotate pfc_resources with __initdata: causes section missmatch! ]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/setup-sh73a0.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
> b/arch/arm/mach-shmobile/setup-sh73a0.c index c5028f1f..7d90eed 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -61,29 +61,16 @@ void __init sh73a0_map_io(void)
>  	iotable_init(sh73a0_io_desc, ARRAY_SIZE(sh73a0_io_desc));
>  }
> 
> -static struct resource sh73a0_pfc_resources[] = {
> -	[0] = {
> -		.start	= 0xe6050000,
> -		.end	= 0xe6057fff,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= 0xe605801c,
> -		.end	= 0xe6058027,
> -		.flags	= IORESOURCE_MEM,
> -	}
> -};
> -
> -static struct platform_device sh73a0_pfc_device = {
> -	.name		= "pfc-sh73a0",
> -	.id		= -1,
> -	.resource	= sh73a0_pfc_resources,
> -	.num_resources	= ARRAY_SIZE(sh73a0_pfc_resources),
> +/* PFC */
> +static const struct resource pfc_resources[] __initdata = {
> +	DEFINE_RES_MEM(0xe6050000, 0x8000),
> +	DEFINE_RES_MEM(0xe605801c, 0x000c),
>  };
> 
>  void __init sh73a0_pinmux_init(void)
>  {
> -	platform_device_register(&sh73a0_pfc_device);
> +	platform_device_register_simple("pfc-sh73a0", -1, pfc_resources,
> +					ARRAY_SIZE(pfc_resources));
>  }
> 
>  static struct plat_sci_port scif0_platform_data = {
-- 
Regards,

Laurent Pinchart
