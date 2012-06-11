From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jun 2012 10:51:02 +0100
Subject: [PATCH 1/3] mx3fb: do not support panning with fb blanked
In-Reply-To: <1339376810-8247-1-git-send-email-Ying.Liu@freescale.com>
References: <1339376810-8247-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20120611095102.GD11168@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 09:06:48AM +0800, Liu Ying wrote:
> This patch checks if framebuffer is unblanked before
> we actually trigger panning in custom pan display
> function.
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
>  drivers/video/mx3fb.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index e3406ab..d53db60 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -1063,6 +1063,11 @@ static int mx3fb_pan_display(struct fb_var_screeninfo *var,
>  	dev_dbg(fbi->device, "%s [%c]\n", __func__,
>  		list_empty(&mx3_fbi->idmac_channel->queue) ? '-' : '+');
>  
> +	if (mx3_fbi->blank != FB_BLANK_UNBLANK) {
> +		dev_dbg(fbi->device, "panning with fb blanked not supported\n");
> +		return -EFAULT;
> +	}

Why is this an error, and why return -EFAULT?  What userspace access
failed?
