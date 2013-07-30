From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 30 Jul 2013 08:22:53 +0300
Subject: [PATCH v2 21/22] iommu/tegra: smmu: Support Multiple ASID
In-Reply-To: <51F6A943.8000004@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-22-git-send-email-hdoyu@nvidia.com>
 <51E8535A.30605@wwwdotorg.org>
 <20130729.133155.1836775489422797370.hdoyu@nvidia.com>
 <51F6A943.8000004@wwwdotorg.org>
Message-ID: <20130730082253.be35a8ddadbe757100e92c10@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jul 2013 19:41:23 +0200
Stephen Warren <swarren@wwwdotorg.org> wrote:
...
> > I think that this belongs to the system operation policy. Which H/W
> > should be configured to which Address Space(AS). This put all AHB
> > clients(PPCS) into AS[1](SYSTEM_PROTECTED), and the rest into
> > AS[0](SYSTEM_DEFAULT). AHB clients are mainly traditional H/Ws like
> > USB and SD/MMC so that they should be kept separated from the smart
> > IOMMU clients like host1x.
> > 
> > Is there any place to configure this kind of board specific policy
> > rather than here?
> 
> I'm not sure that answers the question I asked.
> 
> I mean that the driver expects that two AS always exist;
> SYSTEM_PROTECTED and SYSTEM_DEFAULT. However, the set of extant ASs is
> IIRC defined by the DT content. What if the DT doesn't define two ASs?
> Shouldn't there at least be an error-check for this case, so the driver
> doesn't just blindly continue and access smmu_handle->map[1] when the
> map[] array only has 1 entry?

OK, now I got it.

We can create multiple maps on the same AS in theory. So the limitation
is only for how many maps S/W creaed. This can/should be checked only
within kernel side. No constraints from DT.
