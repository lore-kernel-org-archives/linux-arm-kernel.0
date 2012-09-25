From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 23:18:52 +0800
Subject: [PATCH V2] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
In-Reply-To: <201209251651.59967.marex@denx.de>
References: <1348572738-9743-1-git-send-email-marex@denx.de>
 <201209251540.18719.marex@denx.de>
 <20120925143720.GF14216@S2101-09.ap.freescale.net>
 <201209251651.59967.marex@denx.de>
Message-ID: <20120925151849.GG14216@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 04:51:59PM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > Sorry, I just dropped the patch, and you need to convince me that the
> > patch is actually needed to fix a bug.
> > 
> > On Tue, Sep 25, 2012 at 03:40:18PM +0200, Marek Vasut wrote:
> > > Dear Shawn Guo,
> > > 
> > > > On Tue, Sep 25, 2012 at 01:32:18PM +0200, Marek Vasut wrote:
> > > > > Currently, the kernel unconditionally adds "local-mac-address" and
> > > > > "mac-address" properties under both FEC ethernet DT nodes in case
> > > > > the update_fec_mac_prop() function is called. These properties are
> > > > > loaded with MAC address compiled from vendors OUI and a per-device
> > > > > NIC saved in OCOTP storage.
> > 
> > The function update_fec_mac_prop is only called for imx28-evk and m28evk
> > boards which are known having valid/unique MAC address programmed in
> > OCOTP.
> 
> Actually I disabled it on m28, since the OCOTP is not always programmed. The 
> board is shipped with blank OCOTP.

Then removing the call to update_fec_mac_prop for m28 is enough.

> The imx28-evk is shipped with blank OCOTP as 
> well, no?
> 
No.  imx28-evk is shipped with MAC programmed into OCOTP.

> > In that case, shouldn't we always read MAC from OCOTP instead
> > of trusting the "local-mac-address" property from device tree, which
> > might stand a chance that it's not valid or unique?
> 
> Definitelly not. If the bootloader doesn't pass correct local-mac-address 
> property, the bootloader is broken and it is not our problem (any invalid DT 
> passed from bootloader is not our problem and is not fixed by us ... most of the 
> time).

It is our problem.  We shouldn't trust bootloader on that whenever it's
possible for ourselves to figure it out.  You can say "hey bootloader,
this is your problem not ours", but FEC driver in kernel is not working.
Isn't it a problem for kernel when FEC is not working?

> On the other hand:
> 
> 1) if it doesn't pass any local-mac-address property, it is safe to read from 
> OCOTP (this is the case of bootlets) to fill in the blank with at least 
> something ... even though if the OCOTP is empty, FEC won't work anyway.
> 
> 2) if the bootloader does pass a local-mac-address property, then it is 
> intentional and it can be later overriden anyway by "ifconfig ... hw ether" if 
> needed .
> 
> If the bootloader does pass such information, it is either sourced from OCOTP 
> (in which case it might fall back to 1) and pass nothing ) or elsewhere, in 
> which case it's 2) and the bootloader has obviously better knowledge of the 
> hardware than we do.
> 
> I firmly disagree with force-overriding the DT properties, since esp. in case of 
> development kits, it doesn't give the users the freedom to program their OCOTP 
> the way they need it to.
> 
> Also, the users don't have freedom to frob with their MAC address easily -- when 
> the OCOTP isn't programmed yet, their FEC won't work, for example in case of NFS 
> root filesystem, this is a problem. With this patch, you don't have the problem.
> 
Please bear in mind, we only call update_fec_mac_prop for boards that
are known having MAC programmed in OCOTP.

Shawn
