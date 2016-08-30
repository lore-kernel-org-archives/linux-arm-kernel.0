From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Aug 2016 18:26:13 +0200
Subject: [PATCH v3] mmc: sunxi: Handle the 'New Timing' mode
In-Reply-To: <20160813175611.79E0323C@mail.free-electrons.com>
References: <20160813175611.79E0323C@mail.free-electrons.com>
Message-ID: <20160830162613.GG18605@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 13, 2016 at 06:41:45PM +0200, Jean-Francois Moine wrote:
> Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> a 'New Timing' mode.
> When aware about this capability, and when this is possible (clock
> rate great enough), the clock driver switches the MMC clock to the
> 'new mode', meaning that the phase delays are defined in the MMC
> registers instead of in the clock registers.
> To alert the MMC driver about this switch, the clock driver returns
> the error code EPERM on calling clk_set_phase().
> 
> This patch makes the MMC driver to handle this returned code and to
> activate or not the 'New Timing' mode on the MMC side.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> Some explanations:
> In the old timing, the phase delays are set in the clock only
> (that's why there is a function clk_set_phase() which is called from
> the MMC side).
> In the new timing, the delays are in the MMC register SDXC_REG_NTSR
> only.
> The new timing works only when the clock rate is greater or equal
> to 50MHz.
> 
> There are 2 flags saying that the new timing is used:
> - the bit 'mode select' in the clock register, and
> - the bit 'new timing' in the MMC register.
> Both bits must be set/reset at the same time, otherwise the device
> does not work (tested with wifi and eMMC in H3 and A83T boards).
> So, some synchronization must exist.
> 
> The previous versions was using a DT property for the MMC and a flag
> in the clock driver. This did work with a correct configuration
> on both sides, but experiment showed that it was easy to do an error.

I still believe that we will need a property, at least to identify on
which we can try the new mode, and on which clocks it's irrelevant (at
least for the A33 and A83T).

However, I also believe we should make that mode switching explicit
through a function call, instead of relying on some side effect (of
some non-upstream code).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160830/b503a2fa/attachment.sig>
