From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 May 2012 18:08:38 +0100
Subject: [PATCH 2/2] MFD: mc13xxx workaround SPI hardware bug on i.Mx
In-Reply-To: <1338282389-26177-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
 <1338282389-26177-2-git-send-email-philippe.retornaz@epfl.ch>
 <1338282389-26177-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120530170837.GR9947@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 11:06:29AM +0200, Philippe R?tornaz wrote:
> The MC13xxx PMIC is mainly used on i.Mx SoC. On thoses SoC the SPI
> hardware will deassert CS line as soon as the SPI FIFO is empty.
> The MC13xxx hardware is very sensitive to CS line change as it
> corrupts the transfert if CS is deasserted in the middle of a register
> read or write.
> It is not possible to use the CS line as a GPIO on some SoC, so we
> need to workaround this by implementing a single SPI transfer to
> access the PMIC.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though it's really sad this can't be done in the SPI controller where
the bug is.  You should also set use_single_rw in the regmap_config,
though this is less critical as currently the core won't automatically
generate any bulk I/O.

Obviously this will affect a much wider range of devices when used with
i.MX.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120530/0b925a82/attachment.sig>
