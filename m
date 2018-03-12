From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 12 Mar 2018 10:44:34 +0100
Subject: [PATCH] drm/sun4i: Fix exclusivity of the TCON clocks
In-Reply-To: <20180310110511.14697-1-megous@megous.com>
References: <20180310110511.14697-1-megous@megous.com>
Message-ID: <20180312094434.uucwvqy6pykxpbl7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2018 at 12:05:11PM +0100, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Currently the exclusivity is enabled when the rate is set by
> the mode setting functions. These functions are called by
> mode_set_nofb callback of drm_crc_helper. Then exclusivity
> is disabled when tcon is disabled by atomic_disable
> callback.
> 
> What happens is that mode_set_nofb can be called once when
> mode chnages, and afterwards the system can call atomic_enable
> and atomic_disable multiple times without further calls to
> mode_set_nofb.
> 
> This happens:
> 
> mode_set_nofb   - clk exclusivity is enabled
> atomic_enable
> atomic_disable  - clk exclusivity is disabled
> atomic_enable
> atomic_disable  - clk exclusivity is already disabled, leading to WARN
>                   in clk_rate_exclusive_put
> 
> Solution is to enable exclusivity in sun4i_tcon_channel_set_status.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180312/ea213dee/attachment.sig>
