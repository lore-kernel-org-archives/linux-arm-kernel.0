From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 Feb 2016 19:10:00 +0000
Subject: [PATCH V2] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
In-Reply-To: <1452D0BB-4AF3-4A19-983A-3A54E94A4F2F@caviumnetworks.com>
References: <1455820158-8529-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160223122616.GE4989@leverpostej>
 <56CCF03D.3000809@caviumnetworks.com>
 <20160224113227.GB11579@leverpostej>
 <1452D0BB-4AF3-4A19-983A-3A54E94A4F2F@caviumnetworks.com>
Message-ID: <20160224190628.GA9003@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 03:54:48PM +0000, Chalamarla, Tirumalesh wrote:
> 
> On 2/24/16, 3:32 AM, "Mark Rutland" <mark.rutland@arm.com> wrote:
> 
> >On Tue, Feb 23, 2016 at 03:50:21PM -0800, Tirumalesh Chalamarla wrote:
> >> in Summary,
> >> 
> >> if i change asid-base to cavium,asid-base and still use DT for
> >> supplying base value, is this a solution that will be accepted, 
> >
> >No. The property is _insufficient_, regardless of its name. This has
> >been pointed out more than once.
> >
> >A base alone does not tell you what set of IDs it is valid to use
> >without risking a clash. The OS is well within its rights to allocate
> >_any_ ID above that base. It is not a requirement of the hardware nor
> >the binding that the OS allocate a contiguous set of IDs starting at the
> >base.
> >
> >Consider:
> >
> >smmu_a {
> >	whatver,*id-base = <128>;
> >};
> >
> >smmu_b {
> >	whatever,*id-base = <64>;
> >};
> >
> >In both cases, the *IDs 129+ could be allocated on both SMMUs.
> 
> Does adding a check to see if base + number of contexts supported will not overlap with each other
> Make it acceptable. 
> Or do you want the size be provided from DT also?

At this point I think Robin's suggestion of giving the ThunderX SMMU a
different compatible string and treating that as a separate case
entirely is the best thing to do.

Then the only requirement is that _all_ the ThunderX SMMUs with shared
TLBs are under the control of the OS, and it can allocate IDs as it
chooses, so long as it ensures that there are no conflicts across all
the SMMUs it is in control of.

Mark.
