From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 15 Jun 2018 10:31:10 +0200
Subject: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
In-Reply-To: <20180612200036.21483-12-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-12-jernej.skrabec@siol.net>
Message-ID: <20180615083110.laruycabvyjmesmo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
> TV TCONs connected to TCON TOP have to enable additional gate in order
> to work.
> 
> Add support for such TCONs.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 08747fc3ee71..0afb5a94a414 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>  		dev_err(dev, "Couldn't get the TCON bus clock\n");
>  		return PTR_ERR(tcon->clk);
>  	}
> +
> +	if (tcon->quirks->has_tcon_top_gate) {
> +		tcon->top_clk = devm_clk_get(dev, "tcon-top");
> +		if (IS_ERR(tcon->top_clk)) {
> +			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
> +			return PTR_ERR(tcon->top_clk);
> +		}
> +		clk_prepare_enable(tcon->top_clk);
> +	}
> +

Is it required for the TCON itself to operate, or does the TCON
requires the TCON TOP, which in turn requires that clock to be
functional?

I find it quite odd to have a clock that isn't meant for a particular
device to actually be wired to another device. I'm not saying this
isn't the case, but it would be a first.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/d5a22b93/attachment.sig>
