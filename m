From: bahadir@l4dev.org (Bahadir Balban)
Date: Tue, 12 Jan 2010 21:15:08 +0200
Subject: Split page tables
In-Reply-To: <1263288689.29654.8.camel@pc1117.cambridge.arm.com>
References: <4B4B830D.20309@l4dev.org>
	<1263288689.29654.8.camel@pc1117.cambridge.arm.com>
Message-ID: <4B4CCA3C.9090502@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> Hi Bahadir,
> 
> (good to see you around :-))
> 

Good to see you too, Catalin.

> You can configure a 2:2 split and if you want you can set TTBR1 to the
> kernel TTBR but I don't think you'd gain much. You only save about 2K of
> the user TTBR but since we allocate a 1 x 4K page pgd, there isn't any
> difference. Note the translation table entries for the kernel would
> contain either level 1 section entries or entries pointing to level 2
> tables which would be shared between all the pgd tables. I think the
> only gain is probably a memcpy of the kernel pgd into the user pgd
> during process creation.
> 

I understand that level 2 tables are already shared on global mappings.
After taking a glance in pgtable.h, I see that there are 8-byte pgd 
entries and extra linux tables to make it fit for linux requirements. 
But still, it seems like instead of 16KB level1 tables per-space, a 2:2 
split would need 8KB level1 table per space which results in 8KB savings 
per-space. Am I missing something?

That said, with linux pte duplicates on every 2nd level table, it might 
not be a significant gain. Perhaps you had done the correlation long ago 
- but extra bits from tex remap and access flag is not enough to support 
linux bits directly on the hardware pte?


Thanks,

--
Bahadir
