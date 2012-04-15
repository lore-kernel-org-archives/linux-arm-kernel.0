From: alexg@meprolight.com (Alex Gershgorin)
Date: Sun, 15 Apr 2012 17:15:38 +0300
Subject: [PATCH] ARM: i.mx35 increase dma consistent region size
In-Reply-To: <20120413144029.GP3852@pengutronix.de>
References: <1334167274-29524-1-git-send-email-alexg@meprolight.com>,
 <20120413144029.GP3852@pengutronix.de>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD2F@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Sorry was not possible to respond to you earlier. 

On Wed, Apr 11, 2012 at 09:01:14PM +0300, Alex Gershgorin wrote:
> The default size of the consistent DMA region is 2MB
> without this patch, attempt to allocate more than 2MB
> is causing allocation failure
>
> Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
> ---
>  arch/arm/mach-imx/mm-imx3.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index 7412738..a2c0c7d 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -201,6 +201,7 @@ static struct map_desc mx35_io_desc[] __initdata = {
>  void __init mx35_map_io(void)
>  {
>       iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
> +     init_consistent_dma_size(SZ_8M);

> > I don't know what to think about this. You probably have a board with
> > camera support and thus need bigger buffers, right? Nevertheless this
> > patch affects all i.MX35 users, even the ones without camera support.

Camera support is not an issue, this patch belongs only to those I.MX35 drivers who are using 
the dma coherent/writecombine allocations.

For example,  mx3fb currently uses only once DMA allocation for the framebuffer,
In the case of adding overlay support, we need an additional allocation for the overlay 
buffer as a resulting in the total request more than 2 MB

I have already started work on the mx3fb overlay support, about this we spoke with Guennadi,
My current kernel mx3fb successfully registered with support overlay buffer allocation.

Please see my cat /proc/dma-mappings: 

btw as you can see below there is no allocation for the camera

0xffa00000-0xffb77000 1536000 __set_par+0xc8/0x7f8
0xffc00000-0xffd77000 1536000 __set_par+0xc8/0x7f8
0xffdfa000-0xffdfb000    4096 ehci_mxc_setup+0x194/0x574
0xffdfb000-0xffdfc000    4096 dma_pool_alloc+0x9c/0x1f0
0xffdfc000-0xffdfd000    4096 dma_pool_alloc+0x9c/0x1f0
0xffdfd000-0xffdfe000    4096 fec_probe+0x248/0x71c
0xffdfe000-0xffdff000    4096 sdma_request_channel+0x2c/0xd8
0xffdff000-0xffe00000    4096 sdma_probe+0x2cc/0x61c

> > Another possibility would be to make this board specific.

I think this needed adapted for all i.mx3x, maybe need to use. 
  
#ifdef CONFIG_FB_MX3
        init_consistent_dma_size(SZ_8M);
#endif

Regards,
Alex Gershgorin
