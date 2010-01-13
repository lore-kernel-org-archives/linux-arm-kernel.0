From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Jan 2010 10:30:14 +0000
Subject: Split page tables
In-Reply-To: <4B4CCA3C.9090502@l4dev.org>
References: <4B4CCA3C.9090502@l4dev.org>
Message-ID: <1263378614.32612.12.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 19:15 +0000, Bahadir Balban wrote:
> Catalin Marinas wrote:
> > You can configure a 2:2 split and if you want you can set TTBR1 to the
> > kernel TTBR but I don't think you'd gain much. You only save about 2K of
> > the user TTBR but since we allocate a 1 x 4K page pgd, there isn't any
> > difference. Note the translation table entries for the kernel would
> > contain either level 1 section entries or entries pointing to level 2
> > tables which would be shared between all the pgd tables. I think the
> > only gain is probably a memcpy of the kernel pgd into the user pgd
> > during process creation.
> 
> I understand that level 2 tables are already shared on global mappings.
> After taking a glance in pgtable.h, I see that there are 8-byte pgd
> entries and extra linux tables to make it fit for linux requirements.
> But still, it seems like instead of 16KB level1 tables per-space, a 2:2
> split would need 8KB level1 table per space which results in 8KB savings
> per-space. Am I missing something?

No, my calculations were wrong - you save 0x2000 which is 8KB indeed.

> That said, with linux pte duplicates on every 2nd level table, it might
> not be a significant gain. 

I think traditionally we had a 3:1 split for user:kernel which wasn't
suited for a TTBR split. The 2:2 split came as a requirement as more RAM
became available, so the 8KB save probably wasn't noticeable.

> Perhaps you had done the correlation long ago
> - but extra bits from tex remap and access flag is not enough to support
> linux bits directly on the hardware pte?

Yes, they are, and I already posted a patch:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/70340/focus=70345

but the thread seems to have died.

-- 
Catalin
