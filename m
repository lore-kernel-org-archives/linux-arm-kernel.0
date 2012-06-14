From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 10:16:32 +0200
Subject: [PATCH] ARM: netx: Reuse dummy clk routines for non
 CONFIG_HAVE_CLK case
In-Reply-To: <5c52038c3c8ec3cc6a5468139e886d5e8a1a1f5c.1339661188.git.viresh.kumar2@arm.com>
References: <5c52038c3c8ec3cc6a5468139e886d5e8a1a1f5c.1339661188.git.viresh.kumar2@arm.com>
Message-ID: <20120614081632.GO30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 09:11:13AM +0100, Viresh Kumar wrote:
> mach-netx had its own implementation of clk routines like, clk_get{put},
> clk_enable{disable}, etc. And with introduction of following patchset:
> 
> https://lkml.org/lkml/2012/4/24/154
> 
> we get compilation error for multiple definition of these routines.
> 
> Sascha had following suggestion to deal with it:
> 
> http://www.spinics.net/lists/arm-kernel/msg179369.html
> 
> So, removing this code completely.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar2@arm.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  arch/arm/mach-netx/fb.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
> index 2cdf6ef..d122ee6 100644
> --- a/arch/arm/mach-netx/fb.c
> +++ b/arch/arm/mach-netx/fb.c
> @@ -69,29 +69,6 @@ void netx_clcd_remove(struct clcd_fb *fb)
>                               fb->fb.screen_base, fb->fb.fix.smem_start);
>  }
> 
> -void clk_disable(struct clk *clk)
> -{
> -}
> -
> -int clk_set_rate(struct clk *clk, unsigned long rate)
> -{
> -       return 0;
> -}
> -
> -int clk_enable(struct clk *clk)
> -{
> -       return 0;
> -}
> -
> -struct clk *clk_get(struct device *dev, const char *id)
> -{
> -       return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
> -}
> -
> -void clk_put(struct clk *clk)
> -{
> -}
> -
>  static AMBA_AHB_DEVICE(fb, "fb", 0, 0x00104000, { NETX_IRQ_LCD }, NULL);
> 
>  int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
> --
> 1.7.11.rc1.9.gf623ca1
> 
> 
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
