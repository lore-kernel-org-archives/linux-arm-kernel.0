From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 18 Jan 2016 11:34:31 +0100
Subject: [PATCH V3 19/21] pci, acpi: Support for ACPI based generic PCI
 host controller init
In-Reply-To: <569CAF7E.9040000@huawei.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-20-git-send-email-tn@semihalf.com>
 <569CAF7E.9040000@huawei.com>
Message-ID: <569CBFB7.1020409@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.01.2016 10:25, liudongdong (C) wrote:
> I see here is different from V2 patch,
> in V2 patch,  0x0000022004000000 is cpu addr.
> but in V3 patch, 0x0000022004000000 is pci addr.
> which one is right ?

You are right, I look back at v2 and see bug there. But v3 fixes it, for 
MEM & IO we always need to calculate this way:
CPU address defined as: cpu_addr = res->start + entry->offset;
PCI address: pci_addr = res->start;

>
> 0x0000022004000000  is the value of AddressMinimum.
> AddressMinimum evaluates to a 64-bit integer that specifies the lowest
> possible base address of the Memory range
> QWordMemory ( // 64-bit BAR Windows
>      ResourceProducer, PosDecode,
>      MinFixed, MaxFixed,
>      Cacheable, ReadWrite,
>      0x000000000000000, // Granularity
>      0x0000022004000000, // Min Base Address
>      0x000002200fffffff, // Max Base Address
>      0x0000021ff9000000, // Translate
>      0x000000000c000000 // Length
> )

For your case:
cpu_addr = 0x0000022004000000 + 0x0000021ff9000000:
pci_addr = 0x0000022004000000;

Regards,
Tomasz
