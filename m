From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 13:08:12 +0200
Subject: [RFC 04/10] memory: Add Tegra124 memory controller support
In-Reply-To: <20140627124638.7ec150cca163c89727b8953f@nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
 <20140627124638.7ec150cca163c89727b8953f@nvidia.com>
Message-ID: <20140627110811.GD2797@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 12:46:38PM +0300, Hiroshi DOyu wrote:
> 
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The memory controller on NVIDIA Tegra124 exposes various knobs that can
> > be used to tune the behaviour of the clients attached to it.
> >
> > Currently this driver sets up the latency allowance registers to the HW
> > defaults. Eventually an API should be exported by this driver (via a
> > custom API or a generic subsystem) to allow clients to register latency
> > requirements.
> >
> > This driver also registers an IOMMU (SMMU) that's implemented by the
> > memory controller.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/memory/Kconfig                   |    9 +
> >  drivers/memory/Makefile                  |    1 +
> >  drivers/memory/tegra124-mc.c             | 1945 ++++++++++++++++++++++++++++++
> >  include/dt-bindings/memory/tegra124-mc.h |   30 +
> >  4 files changed, 1985 insertions(+)
> >  create mode 100644 drivers/memory/tegra124-mc.c
> >  create mode 100644 include/dt-bindings/memory/tegra124-mc.h
> 
> I prefer reusing the existing SMMU and having MC and SMMU separated
> since most of SMMU code are not different from functionality POV, and
> new MC features are quite independent of SMMU.
> 
> If it's really convenient to combine MC and SMMU into one driver, we
> could move "drivers/iomm/tegra-smmu.c" here first, and add MC features
> on the top of it.

I'm not sure if we can do that, since the tegra-smmu driver is
technically used by Tegra30 and Tegra114. We've never really made use of
it, but there are device trees in mainline releases that contain the
separate SMMU node.

Perhaps one of the DT folks can comment on whether it would be possible
to break compatibility with existing DTs in this case, given that the
SMMU on Tegra30 and Tegra114 have never been used.

Either way, I do see advantages in incremental patches, but at the same
time the old driver and architecture was never enabled (therefore not
tested either) upstream and as shown by the Tegra DRM example can't cope
with more complex cases. So I'm not completely convinced that an
incremental approach would be the best here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/1881b1ae/attachment.sig>
