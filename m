From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 2 Oct 2018 18:22:44 +0100
Subject: question about update mmu table entry when mmu and smmu use one
 page
In-Reply-To: <b26dd21d-fa2c-1499-b727-ed8ddd43e805@hisilicon.com>
References: <8CD08B4737CACA4ABE0228F45E441A916381ADEE@DGGEMM501-MBX.china.huawei.com>
 <5f0e7544-5464-7a74-9c6b-3f8b6a0e147a@hisilicon.com>
 <318cbf9d-8216-55f2-b6a6-fb96a9d1fb05@arm.com>
 <8CD08B4737CACA4ABE0228F45E441A9163861B9B@dggemm501-mbs.china.huawei.com>
 <b26dd21d-fa2c-1499-b727-ed8ddd43e805@hisilicon.com>
Message-ID: <6eb4d33e-b0d1-8b46-a6b1-3f1ac0af1891@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/2018 05:06, Zhongmiao wrote:
> 
> 
> On 2018/9/30 11:50, Zhongmiao wrote:
> 
> Hi Jean:
> 
> ??? i got it, you are right .? i have another question? about? atc inv cmd .
> 
> ??? For Example :
> ?????? application? malloc two VA? the length is 1MB.
> ?????????????????? VA_0 = 0x22e1f010
> ?????????????????? VA_1 = 0x22f1f020
> 
> ?????? when free VA_0 and VA_1 , i see the driver build two CMD_INV_ATC :
> 
> ???????????? 1.? cmd_0:0x10000001840,cmd_1:0x2200000d (size = 32MB)
> ???????????? 2.? cmd_0:0x10000001840,cmd_1:0x23000000 (size = 4KB)
> 
> ??? i think cmd "2" is redundant. How did you think about that?

It does seem redundant, but I don't know where it comes from. Each
INV_ATC command corresponds to one MMU notifier call from core mm, so
we'd need more details about what the mm is doing in order to understand
where this second invalidation comes from. For all we know it could come
from an additional mmap/munmap done internally by the libc.

Thanks,
Jean
