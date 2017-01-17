From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Tue, 17 Jan 2017 11:53:43 +0800
Subject: [Question] A question about arm64 pte
In-Reply-To: <20170116143601.GB6832@e104818-lin.cambridge.arm.com>
References: <d284f510-f025-db84-f21e-a5b167d4bcd2@huawei.com>
 <20170116115606.GA6832@e104818-lin.cambridge.arm.com>
 <6b7a9bd2-37af-40cd-b723-9e648fbbc7c8@huawei.com>
 <20170116143601.GB6832@e104818-lin.cambridge.arm.com>
Message-ID: <ecf2bd9f-9f96-0e6d-564d-93cff5bbf0cb@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/1/16 22:36, Catalin Marinas wrote:
> On Mon, Jan 16, 2017 at 08:39:56PM +0800, Yisheng Xie wrote:
>> On 2017/1/16 19:56, Catalin Marinas wrote:
>>> On Mon, Jan 16, 2017 at 06:08:47PM +0800, Yisheng Xie wrote:
>>>
>> However?when use memset to write the region it still works well, and
>> the bit PTE_RDONLY is also cleared. Is there anywhere clear the
>> PTE_RDONLY before write that page ?
> 
> See handle_pte_fault(). On the first access to a writable+clean page
> (PTE_WRITE set, PTE_RDONLY set, PTE_DIRTY cleared), the kernel traps it
> and, if pte_write() is true (your case), it calls pte_mkdirty(). The
> subsequently called ptep_set_access_flags() function would clear
> PTE_RDONLY, giving you a writable mapping.
> 
hi Catalin?
Sorry to disturb, but why page fault will happened here, for pte already
present with AF bit set?

Here is what I get when mmap a reserved memory region 0x39ef 0000~0x3a00 0000
use /dev/mem:
[  442.704228] pgd = ffff802785f14000
[  442.707641] [ffff86e4b000] *pgd=000000279080c003, *pud=0000002785f01003, *pmd=0000002783f5b003, *pte=0168000039ef0fd3

Thanks,
Yisheng Xie.
