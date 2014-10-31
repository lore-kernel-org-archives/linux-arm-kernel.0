From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 31 Oct 2014 14:27:42 +0100
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <20141030150839.GG20072@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw@mail.gmail.com>
 <20141030150839.GG20072@ulmo.nvidia.com>
Message-ID: <20141031132740.GA9371@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 04:08:41PM +0100, Thierry Reding wrote:
> On Wed, Oct 15, 2014 at 03:09:30PM -0700, Olof Johansson wrote:
> > Hi,
> > 
> > Oh, a few more comments:
> > 
> > On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > 
> > > diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> > > index c32d31981be3..1c932e7e7b8d 100644
> > > --- a/drivers/memory/Makefile
> > > +++ b/drivers/memory/Makefile
> > > @@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)  += fsl-corenet-cf.o
> > >  obj-$(CONFIG_FSL_IFC)          += fsl_ifc.o
> > >  obj-$(CONFIG_MVEBU_DEVBUS)     += mvebu-devbus.o
> > >  obj-$(CONFIG_TEGRA20_MC)       += tegra20-mc.o
> > > -obj-$(CONFIG_TEGRA30_MC)       += tegra30-mc.o
> > > +
> > > +obj-$(CONFIG_ARCH_TEGRA)       += tegra/
> > > diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
> > > new file mode 100644
> > > index 000000000000..51b9e8fcde1b
> > > --- /dev/null
> > > +++ b/drivers/memory/tegra/Makefile
> > > @@ -0,0 +1,5 @@
> > > +obj-y                                   = tegra-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)                += tegra30-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_114_SOC)       += tegra114-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_124_SOC)       += tegra124-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_132_SOC)       += tegra124-mc.o
> > 
> > You'll need a Kconfig and not just a makefile -- there are definitely
> > dependencies on this driver (IOMMU in particular).
> 
> This is handled within the tegra-mc driver by only setting up the IOMMU
> when TEGRA_IOMMU_SMMU is enabled. That config option remains in place.
> 
> > Also, the problem of having a global enable bit that is only under
> > control of TrustZone FW is a big problem -- if the bit is not set, the
> > driver will not work (and the machine will crash).
> > 
> > I think you'll need to come up with a way to detect that in the
> > driver. I don't have a good idea of how it can be done though.
> 
> I don't think I ever got back to you on this. We discussed this
> internally and it seems like there's no way to detect this properly, so
> the best suggestion so far was to make it a requirement on the secure
> firmware to enable IOMMU or not. Since there's no way for the kernel to
> detect whether IOMMU was enabled or not, I think the firmware would
> equally have to adjust the SMMU's device tree node's status property
> appropriately.

The other option would be for the firmware not to touch the SMMU device
tree node and the kernel simply assuming that if it's running in non-
secure mode then there must be secure firmware and it has enabled the
SMMU. Enabling the SMMU would become part of the contract between
firmware and kernel, much like locking the VPR is required to get the
GPU to work.

Those are really the only two choices we have.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/a42133d3/attachment-0001.sig>
