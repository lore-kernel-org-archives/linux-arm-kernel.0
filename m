From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 22:37:22 +0800
Subject: [PATCH V2] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
In-Reply-To: <201209251540.18719.marex@denx.de>
References: <1348572738-9743-1-git-send-email-marex@denx.de>
 <20120925114411.GE14216@S2101-09.ap.freescale.net>
 <201209251540.18719.marex@denx.de>
Message-ID: <20120925143720.GF14216@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I just dropped the patch, and you need to convince me that the
patch is actually needed to fix a bug.

On Tue, Sep 25, 2012 at 03:40:18PM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Tue, Sep 25, 2012 at 01:32:18PM +0200, Marek Vasut wrote:
> > > Currently, the kernel unconditionally adds "local-mac-address" and
> > > "mac-address" properties under both FEC ethernet DT nodes in case
> > > the update_fec_mac_prop() function is called. These properties are
> > > loaded with MAC address compiled from vendors OUI and a per-device
> > > NIC saved in OCOTP storage.
> > > 

The function update_fec_mac_prop is only called for imx28-evk and m28evk
boards which are known having valid/unique MAC address programmed in
OCOTP.  In that case, shouldn't we always read MAC from OCOTP instead
of trusting the "local-mac-address" property from device tree, which
might stand a chance that it's not valid or unique?

Shawn

> > > Some more advanced bootloaders do augment the DT passed to the kernel
> > > by these properties already. In such case, it is wrong for kernel to
> > > override these values.
> > > 
> > > Adjust the FEC MAC address loading so that in case the DT properties
> > > are already present in the DT passed from the bootloader, skip the
> > > loading from OCOTP altogether. If the DT properties are not present,
> > > load them from OCOTP.
> > > 
> > > Note that the later case will lead to zeroed out MAC address if OCOTP
> > > is not programmed. This will lead to FEC not working at all.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Queued for 3.8, thanks.
> 
> Ain't this a bugfix? So maybe CC stable etc. ?
> 
> Best regards,
> Marek Vasut
