From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 28 Sep 2018 13:06:14 +0100
Subject: question about update mmu table entry when mmu and smmu use one
 page??
In-Reply-To: <5f0e7544-5464-7a74-9c6b-3f8b6a0e147a@hisilicon.com>
References: <8CD08B4737CACA4ABE0228F45E441A916381ADEE@DGGEMM501-MBX.china.huawei.com>
 <5f0e7544-5464-7a74-9c6b-3f8b6a0e147a@hisilicon.com>
Message-ID: <318cbf9d-8216-55f2-b6a6-fb96a9d1fb05@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/09/2018 03:50, Zhongmiao wrote:
> 
> Hi Jean:
> 
> ???? i'm testing mmu and smmu use one page by vfio drvier (use your
> patch) ;
> 
> ???? the test module:
> ??????????? PCIE(RC) <--> PCIE(EP)
> 
> 
> ???? the program module :
> 
> ??????????????? 1. bind device to vfio
> 
> ??????????????? 2. alloc pasid
> 
> ??????????????? 3. malloc VA
> 
> ??????????????? 4. PCIE EP device write / read by this VA
> 
> ??????????????? 5. free VA (when "4" done)
> 
> Question:
> 
> ??? when application update mmu table entry, and software must make sure
> send "CMD_TLBI_NH_VA" and inv atc ,and so on.
> 
> ??? but i do not see CMD_TLBI_NH_VA when application alloc/free . only
> atc inv and cmd sync when "free".

Excellent, that's expected :) We don't need to issue a CMD_TLBI_NH_VA
because the SMMU participates in broadcast TLB invalidation. When
unmapping the VA from the program's page tables, the CPU issues a TLB
invalidation to the inner-shareable domain (in your case, probably a
TLBI VAE1IS instruction). This invalidation is also received by the
SMMU, which removes the TLB entry associated for this (ASID, VA) pair.

Currently we only support SVA when the SMMU has broadcast invalidation:
* We require that SMMU_IDR0.BTM = 1
* Then we set SMMU_CR2.PTM = 0
* In the context descriptor, we write the ASID of the process
  and set ASET = 0. Any TLB entry created for this context can now be
  invalidated by the CPU.

Unfortunately the ATC doesn't participate in broadcast TLBI, so we need
to send the ATC invalidation explicitly.

You can check if the broadcast invalidation succeeded by repeating step
4 after the free. It should cause the device to send a PRI Page Request,
and the I/O page fault code to return IOMMU_PAGE_RESP_INVALID, resulting
in an "Invalid Request" PRG Response (which can be seen with tracepoint
event iommu:dev_page_response).

Depending on the libc, free doesn't necessarily unmap the underlying
page, so when testing SVA I prefer calling mmap(MAP_ANONYMOUS) and
munmap() directly.

Thanks,
Jean
