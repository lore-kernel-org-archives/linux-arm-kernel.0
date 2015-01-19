From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Jan 2015 23:14:46 +0100
Subject: [PATCH] bus: mvebu-mbus: fix support of MBus window 13
In-Reply-To: <1421596214-15924-1-git-send-email-andrew@lunn.ch>
References: <1419943428-18491-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1421596214-15924-1-git-send-email-andrew@lunn.ch>
Message-ID: <20150119221446.GD2938@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 04:50:14PM +0100, Andrew Lunn wrote:
> On Armada XP, 375 and 38x the MBus window 13 has the remap capability,
> like windows 0 to 7. However, the mvebu-mbus driver isn't currently
> taking into account this special case, which means that when window 13
> is actually used, the remap registers are left to 0, making the device
> using this MBus window unavailable.
> 
> As a minimal fix for stable, don't use window 13. A full fix will
> follow later.
> 
> Fixes: fddddb52a6c ("bus: introduce an Marvell EBU MBus driver")
> Cc: <stable@vger.kernel.org> # v3.10+
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Added to mvebu/fixes-3 with Thomas's Reviewed-by:

      Andrew 

> ---
>  drivers/bus/mvebu-mbus.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index eb7682dc123b..81bf297f1034 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -210,12 +210,25 @@ static void mvebu_mbus_disable_window(struct mvebu_mbus_state *mbus,
>  }
>  
>  /* Checks whether the given window number is available */
> +
> +/* On Armada XP, 375 and 38x the MBus window 13 has the remap
> + * capability, like windows 0 to 7. However, the mvebu-mbus driver
> + * isn't currently taking into account this special case, which means
> + * that when window 13 is actually used, the remap registers are left
> + * to 0, making the device using this MBus window unavailable. The
> + * quick fix for stable is to not use window 13. A follow up patch
> + * will correctly handle this window.
> +*/
>  static int mvebu_mbus_window_is_free(struct mvebu_mbus_state *mbus,
>  				     const int win)
>  {
>  	void __iomem *addr = mbus->mbuswins_base +
>  		mbus->soc->win_cfg_offset(win);
>  	u32 ctrl = readl(addr + WIN_CTRL_OFF);
> +
> +	if (win == 13)
> +		return false;
> +
>  	return !(ctrl & WIN_CTRL_ENABLE);
>  }
>  
> -- 
> 2.1.4
> 
