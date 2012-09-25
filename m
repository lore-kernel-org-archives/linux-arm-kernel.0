From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Sep 2012 16:51:59 +0200
Subject: [PATCH V2] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
In-Reply-To: <20120925143720.GF14216@S2101-09.ap.freescale.net>
References: <1348572738-9743-1-git-send-email-marex@denx.de>
 <201209251540.18719.marex@denx.de>
 <20120925143720.GF14216@S2101-09.ap.freescale.net>
Message-ID: <201209251651.59967.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Sorry, I just dropped the patch, and you need to convince me that the
> patch is actually needed to fix a bug.
> 
> On Tue, Sep 25, 2012 at 03:40:18PM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > On Tue, Sep 25, 2012 at 01:32:18PM +0200, Marek Vasut wrote:
> > > > Currently, the kernel unconditionally adds "local-mac-address" and
> > > > "mac-address" properties under both FEC ethernet DT nodes in case
> > > > the update_fec_mac_prop() function is called. These properties are
> > > > loaded with MAC address compiled from vendors OUI and a per-device
> > > > NIC saved in OCOTP storage.
> 
> The function update_fec_mac_prop is only called for imx28-evk and m28evk
> boards which are known having valid/unique MAC address programmed in
> OCOTP.

Actually I disabled it on m28, since the OCOTP is not always programmed. The 
board is shipped with blank OCOTP. The imx28-evk is shipped with blank OCOTP as 
well, no?

> In that case, shouldn't we always read MAC from OCOTP instead
> of trusting the "local-mac-address" property from device tree, which
> might stand a chance that it's not valid or unique?

Definitelly not. If the bootloader doesn't pass correct local-mac-address 
property, the bootloader is broken and it is not our problem (any invalid DT 
passed from bootloader is not our problem and is not fixed by us ... most of the 
time). On the other hand:

1) if it doesn't pass any local-mac-address property, it is safe to read from 
OCOTP (this is the case of bootlets) to fill in the blank with at least 
something ... even though if the OCOTP is empty, FEC won't work anyway.

2) if the bootloader does pass a local-mac-address property, then it is 
intentional and it can be later overriden anyway by "ifconfig ... hw ether" if 
needed .

If the bootloader does pass such information, it is either sourced from OCOTP 
(in which case it might fall back to 1) and pass nothing ) or elsewhere, in 
which case it's 2) and the bootloader has obviously better knowledge of the 
hardware than we do.

I firmly disagree with force-overriding the DT properties, since esp. in case of 
development kits, it doesn't give the users the freedom to program their OCOTP 
the way they need it to.

Also, the users don't have freedom to frob with their MAC address easily -- when 
the OCOTP isn't programmed yet, their FEC won't work, for example in case of NFS 
root filesystem, this is a problem. With this patch, you don't have the problem.

> Shawn
> 
> > > > Some more advanced bootloaders do augment the DT passed to the kernel
> > > > by these properties already. In such case, it is wrong for kernel to
> > > > override these values.
> > > > 
> > > > Adjust the FEC MAC address loading so that in case the DT properties
> > > > are already present in the DT passed from the bootloader, skip the
> > > > loading from OCOTP altogether. If the DT properties are not present,
> > > > load them from OCOTP.
> > > > 
> > > > Note that the later case will lead to zeroed out MAC address if OCOTP
> > > > is not programmed. This will lead to FEC not working at all.
> > > > 
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > 
> > > Queued for 3.8, thanks.
> > 
> > Ain't this a bugfix? So maybe CC stable etc. ?
> > 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
