From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 28 Apr 2014 14:20:40 -0600
Subject: [RFC PATCH v5 02/11] ARM SMMU: Add capability IOMMU_CAP_DMA_EXEC
In-Reply-To: <20140428193709.GE22135@arm.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
 <1398700371-20096-3-git-send-email-a.motakis@virtualopensystems.com>
 <20140428193709.GE22135@arm.com>
Message-ID: <1398716440.24318.330.camel@ul30vt.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-28 at 20:37 +0100, Will Deacon wrote:
> On Mon, Apr 28, 2014 at 04:52:42PM +0100, Antonios Motakis wrote:
> > The ARM SMMU can take an IOMMU_EXEC protection flag in addition to
> > IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.
> 
> The other way of handling this would be to negate the capability and
> advertise a NOEXEC cap instead. That would need the IOMMU_EXEC flag to
> become IOMMU_NOEXEC and the ARM SMMU driver updating accordingly, but it
> might make more sense if people don't object to mixing positive and negative
> logic in the IOMMU_* flags.
> 
> Any thoughts?

A benefit of doing that would be that the flag becomes enforceable.  As
written in this draft, if a user does not specify EXEC, the mapping may
or may not be executable, depending on the IOMMU capability (assuming
that if EXEC is not supported that it follows READ).  If the flag
changes to NOEXEC, then all the domains in the container should support
it or else the mapping should fail.  We could also avoid the test in
vfio code when doing a mapping and just let the IOMMU driver fail the
map if NOEXEC is unsupported.  Thanks,

Alex
