From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Jun 2018 17:58:58 +0200
Subject: arm: mach-mvebu: dts: enable-method is always overwritten
In-Reply-To: <a2d4701e-28b3-07ee-6b2f-588b2e9a75c4@online.net>
References: <a2d4701e-28b3-07ee-6b2f-588b2e9a75c4@online.net>
Message-ID: <20180608155858.GB19702@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2018 at 05:43:11PM +0200, Yves Lefloch wrote:
> Hello everybody,

Adding Chris Packham. He did some work in this area.

       Andrew

> 
> I'm facing an issue that I believe to be a conflict between device-tree and
> machine_desc.
> 
> My platform is arm/mach-mvebu. I have a DT based on "armada-xp-db-dxbc2.dts"
> (I just included it and added a few okays), my CPU is a Marvell Bobcat2
> switching chip. My kernel is a vanilla 4.16.
> 
> Everything works fine except that my second core won't boot: `CPU1: failed
> to come online'.
> I tracked down the problem to arch/arm/mach-mvebu/platsmp.c: in this file is
> defined a machine_desc that hardcodes the SMP ops to `marvell,armada-xp-smp'
> whereas my device tree (by including armada-xp-98dx3236.dtsi) attempts to
> set the ops to `marvell,98dx3236-smp' through enable-method. In setup_arch()
> the machine_desc's ops overwrites the enable-method's ops, causing the wrong
> smp_boot_secondary() call to be issued.
> 
> Now there is a note from 2014 saying that this machine_desc's `smp' field is
> hardcoded like that because of "old Device Trees that were not specifying
> the cpus enable-method property". As far as I can tell, this is still the
> case, for instance "armada-370-db.dts" doesn't have any enable-method
> property.
> 
> I have worked around this by commenting out `armada_xp_smp_ops.smp' but
> obviously I would prefer to keep a vanilla kernel.
> 
> So I propose to:
> - Add `enable-method = "marvell,armada-xp-smp"' to armada-370-xp.dtsi,
> because it seems that all Armada 370/XP include it;
> - Remove the `smp' field of `armada_xp_smp_ops'.
> 
> If you agree with the diagnosis and the proposed fix I will write a patch.
> 
> Regards,
> Yves Lefloch.
