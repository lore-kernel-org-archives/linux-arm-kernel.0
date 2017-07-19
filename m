From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Jul 2017 12:30:17 +0100
Subject: [PATCH 1/5] iommu: Add capability IOMMU_CAP_BYPASS
In-Reply-To: <CAALAos8nf-d5i74J7-sAJb2o9eFj2PVDeLLVd=wun+gW1ihXSA@mail.gmail.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <1500456838-18405-2-git-send-email-anup.patel@broadcom.com>
 <675744d3-b070-1245-6ebc-579c4b5f4a75@arm.com>
 <CAALAos_o25mtphxcVE0rr9dE8YAm-os2C_HD9oDnt41ZMDP8pA@mail.gmail.com>
 <20170719112315.GE13642@arm.com>
 <CAALAos8nf-d5i74J7-sAJb2o9eFj2PVDeLLVd=wun+gW1ihXSA@mail.gmail.com>
Message-ID: <20170719113017.GH13642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 04:56:38PM +0530, Anup Patel wrote:
> On Wed, Jul 19, 2017 at 4:53 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jul 19, 2017 at 04:49:00PM +0530, Anup Patel wrote:
> >> On Wed, Jul 19, 2017 at 4:28 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> >> > On 19/07/17 10:33, Anup Patel wrote:
> >> >> Some of the IOMMUs (such as ARM SMMU) are capable of bypassing
> >> >> transactions for which no IOMMU domain is configured.
> >> >>
> >> >> This patch adds IOMMU_CAP_BYPASS which can be used by IOMMU
> >> >> drivers to advertise transation bypass capability of an IOMMU.
> >> >
> >> > Whatever the intended semantics of this are, I can't help thinking it
> >> > would be better served by allowing callers to explicitly allocate their
> >> > own IOMMU_DOMAIN_IDENTITY domains. That would also be useful for the
> >> > problem we have with legacy virtio devices behind real IOMMUs.
> >>
> >> We want to use VFIO no-IOMMU mode for FlexRM device but
> >> currently it does not allow on our SOC because IOMMU ops are
> >> registered for platform bus.
> >
> > Why do you want to use no-IOMMU mode if you have an IOMMU, and why you do
> > think the individual IOMMU drivers are the place to implement this?
> >
> > NAK to the SMMU patches, for the reasons outlined by Robin.
> 
> We have limited number of SMRs on our SOC.
> 
> There are lot of devices for which we can potentially
> configure SMMU but then due to limited number of
> SMRs so we use SMMU only for certain devices.
> 
> For FlexRM device on our SOC, we don't intend to
> use SMMU hence we need VFIO no-IOMMU mode
> working for FlexRM device on our SOC.
> 
> Please re-consider your NAK.

I'm afraid it still stands for the current implementation. If you can't
solve the SMR restriction by grouping things appropriately (which would be
my strong preference), then I think you'll have to follow-up on Robin's
suggestion of implementing support for IDENTITY domains in VFIO for no-IOMMU
mode to be used even when an IOMMU is present.

Will
