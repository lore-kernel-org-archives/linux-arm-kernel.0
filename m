From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 16:04:56 +0000
Subject: [PATCH v3 38/62] arm/acpi: Add placeholder for efi and acpi load
 address
In-Reply-To: <564C6763.6050107@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-39-git-send-email-shannon.zhao@linaro.org>
 <564B1666.4060008@citrix.com> <564B2152.9000904@huawei.com>
 <564B3845.4060801@citrix.com> <564BEA22.1040909@huawei.com>
 <564C6763.6050107@citrix.com>
Message-ID: <alpine.DEB.2.02.1511261604080.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015, Julien Grall wrote:
> On 18/11/15 03:01, Shannon Zhao wrote:
> > "All above tables will be mapped to Dom0 non-RAM space. Since when
> > booting through ACPI it doesn't need the grant table region(see below
> > section 3), it could use this region to store the tables or use the same
> > way to find one memory region to store them."
> > 
> > Firstly, as Jan suggested, these tables should not be in RAM space, so
> > we drop the previous way that copying these tables to Dom0 RAM.
> > Then I suggested map these tables to the space after the Dom0 RAM space,
> > but this not right because Dom0 RAM region might be at the edge of
> > physical RAM space and there might be device MMIO regions.
> > Then you suggest it could map these tables to the region which is used
> > for grant table(or the region found by the same way) while it's not used
> > when it boots with ACPI. These regions are not used by Xen and will not
> > be used by Dom0 either currently. But as you say, it will be wrong if
> > Dom0 memory is not 1:1 mapped.
> 
> Will you remember in 6 months why you wrote the code like that?
> 
> My point on the previous mail is you don't describe what you did,
> neither in the code nor in the commit message.
> 
> Most of the place in the code are trying to avoid the assumption that
> DOM0 is using direct mapped. If not, we always have a comment/commit
> message explaining why we are doing like that and the implication (see
> the grant table example [1]).
> 
> > So how about below idea:
> > We still copy these tables to Dom0 RAM space but when we create
> > EFI_MMAP_TABLE, we remove the space occupied by these tables from the
> > EfiConventionalMemory descriptor.
> 
> As you don't need the grant table region, why don't you re-use it fopr
> your tables? It may also be possible that we have some space just after
> for the EFI table.

I think that the current approach is good, please just extend the
in-code comment in patch #40.
