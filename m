From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Oct 2014 15:04:52 +0200
Subject: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast
 as slave request
In-Reply-To: <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20141015130452.GD27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 07:25:49PM +0800, Addy Ke wrote:

> +	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
> +		rs->speed = MAX_SCLK_OUT;
> +
> +	/* the minimum divsor is 2 */
> +	if (rs->max_freq < 2 * rs->speed) {
> +		clk_set_rate(rs->spiclk, 2 * rs->speed);
> +		rs->max_freq = clk_get_rate(rs->spiclk);
> +	}

I'll apply this but you should be checking the return code from
clk_set_rate() here, please send a followup patch doing that.  It might
also be worth consdering just setting the rate unconditionally here, it
seems like it should make things simpler.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/7c822801/attachment.sig>
