From: b-liu@ti.com (Bin Liu)
Date: Mon, 9 Oct 2017 22:22:52 -0500
Subject: [PATCH v2] usb: musb: sunxi: Explicitly release USB PHY on exit
In-Reply-To: <20171010024525.21971-1-net147@gmail.com>
References: <20171010024525.21971-1-net147@gmail.com>
Message-ID: <20171010032252.GA25830@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 01:45:25PM +1100, Jonathan Liu wrote:
> This fixes a kernel oops when unloading the driver due to usb_put_phy
> being called after usb_phy_generic_unregister when the device is
> detached. Calling usb_phy_generic_unregister causes x->dev->driver to
> be NULL in usb_put_phy and results in a NULL pointer dereference.
> 
> Cc: stable at vger.kernel.org # v4.3+
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
> Changes for v2:
>  - Use devm_usb_put_phy instead of usb_put_phy
> 
>  drivers/usb/musb/sunxi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index c9a09b5bb6e5..dc353e24d53c 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -297,6 +297,8 @@ static int sunxi_musb_exit(struct musb *musb)
>  	if (test_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags))
>  		sunxi_sram_release(musb->controller->parent);
>  
> +	devm_usb_put_phy(glue->dev, glue->xceiv);
> +
>  	return 0;
>  }


Applied. Thanks.
-Bin.
