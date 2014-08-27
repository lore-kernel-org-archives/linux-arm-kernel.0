From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Aug 2014 07:52:48 +0200
Subject: [PATCH] ARM: tegra: add PCIe-related pins to the Jetson TK1
 pinmux tables
In-Reply-To: <53FD0980.2010803@suse.de>
References: <1408742308-18004-1-git-send-email-swarren@wwwdotorg.org>
 <53FB10B8.3010408@suse.de> <53FB160F.6000700@nvidia.com>
 <53FB27AB.8010608@nvidia.com> <53FD0980.2010803@suse.de>
Message-ID: <20140827055247.GC15640@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 12:26:08AM +0200, Andreas F?rber wrote:
> Am 25.08.2014 14:10, schrieb Mikko Perttunen:
> > On 25/08/14 13:55, Mikko Perttunen wrote:
> >> On 25/08/14 13:32, Andreas F?rber wrote:
> >>> Am 22.08.2014 23:18, schrieb Stephen Warren:
> >>>> From: Stephen Warren <swarren@nvidia.com>
> >>>>
> >>>> This pinmux tables currently omit any configuration for PCIe clk_req,
> >>>> wake, and rst pins, which in turn causes intermittent failures in
> >>>> U-Boot's PCIe support. Import an updated version of the pinmux tables
> >>>> which rectifies this.
> >>>>
> >>>> (While I'm still hoping to remove the pinmux tables from DTs for
> >>>> Tegra124+ devices, while they're still here, they may as well be
> >>>> complete and correct).
> >>>>
> >>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> >>>> ---
> >>>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 35
> >>>> +++++++++++++++++++++++++++++++
> >>>>   1 file changed, 35 insertions(+)
> >>>
> >>> I've tested this patch on both -rc1 and yesterday's torvalds/linux.git
> >>> with tegra_defconfig: Both with or without this patch I get empty lspci
> >>> output.
> >>>
> >>> There doesn't seem to be a tegra/linux.git for-next branch based on -rc1
> >>> yet - are patches from other subsystem trees needed to get the on-board
> >>> Ethernet detected or maybe some config option?
> >>
> >> git://gitorious.org/thierryreding/linux.git staging/pci
> >
> > .. and apparently the device tree patches are in staging/tegra.
> 
> Thanks for the URLs. I tested yesterday's staging/master, but booting
> from SD seemed broked, sdhci-tegra probe kept deferring. Is that a known
> issue?

Yes, this is a known issue. The root is that currently there's no way to
allow deferred probing if an IOMMU hasn't been probed, so a driver needs
to continue without IOMMU support even if the IOMMU would come up later
in the boot process. The staging/iommu branch contains a patch to fix it
but it looks as if that won't be merged.

I've since removed the code that registers the Tegra SMMU with the code
that I introduced but haven't removed the registry patch yet, which will
cause the SMMU never to show up and therefore indefinitely deferring
probe. You can easily solve this by removing the iommus property from
the sdhci nodes in DTS or by removing the calls to iommu_attach() and
iommu_detach() from the SDHCI driver (reverting "mmc: sdhci-tegra: Add
IOMMU support").

I'll see if I can find the time today to fix up the branches.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/1849b2aa/attachment.sig>
