From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 09:23:47 +0100
Subject: [PATCH v2 00/16] Implement H3/H5 HDMI driver
In-Reply-To: <2235934.0TF68fluGz@jernej-laptop>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <2235934.0TF68fluGz@jernej-laptop>
Message-ID: <20180301082347.go4l7332kjoq5dmm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 28, 2018 at 10:23:35PM +0100, Jernej ?krabec wrote:
> Dne torek, 27. februar 2018 ob 23:26:45 CET je Jernej Skrabec napisal(a):
> > This series implements H3/H5 HDMI driver. It was tested on OrangePi 2 (H3),
> > OrangePi Plus2e (H3) and OrangePi PC2 (H5) with many resolutions and it
> > works well. Bug, which prevented correct operation for some resolutions,
> > is also fixed.
> > 
> > Code is based on linux-next, next-20180226 tag.
> 
> Today I tried on this series on  next-20180228, but resolution switching 
> doesn't really work. The reason for this is use of clk_set_rate_exclusive() in 
> sun4i_tcon1_mode_set(). If I revert it to ordinary clk_set_rate() it works ok. 
> I investigated a bit and it seems that clocks stays at first set even if tcon 
> (the owner of exclusive lock) request the new one. Example:
> 
> [   69.325732] TCON clk wanted: 148500000
> [   69.325740] TCON real clk: 69272728
> [   69.325770] HDMI clk wanted: 148500000
> [   69.325773] HDMI real clk: 138545455
> [   69.325815] HDMI PHY clk wanted: 148500000
> [   69.325819] HDMI PHY real clk: 138545454
> 
> Is there anything I can do to help debug this?

I don't recall if disable hook is called during a mode set, but if it
is, you can add a call to clk_rate_exclusive_put.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/30cb71ba/attachment.sig>
