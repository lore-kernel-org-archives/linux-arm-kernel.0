From: panand@redhat.com (Pratyush Anand)
Date: Wed, 10 Aug 2016 13:58:08 +0530
Subject: Query about ARM64 virt_to_phys and vice versa implementation
Message-ID: <20160810082808.GA24137@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Would like to discuss virt_to_phys() and phys_to_virt() conversion in latest
kernel. I can see that if VA < PAGE_OFFSET, then we just subtract kimage_voffset
from VA and we get the PA. However, there is no such condition for
phys_to_virt(). phys_to_virt is always done by (PA - PHYS_OFFSET + PAGE_OFFSET).
So, how does phys_to_virt() work for all the cases? I must be missing something.

-- I am using a platform with VA bits = 42.
   Therefore PAGE_OFFSET on my platform is 0xfffffe0000000000
   PHYS_OFFSET is 0x8000000000
   kimage_voffset is 0xfffffb8006000000

Now lets find physical address of log_buf:
# cat /proc/kallsyms | grep -w "d log_buf"
fffffc0008ca6b40 d log_buf

Since VA < PAGE_OFFSET (fffffc0008ca6b40 < fffffe0000000000)
Therefore as per definition of virt_to_phys() from asm/memory.h:
PA = VA - kimage_voffset = fffffc0008ca6b40 - fffffb8006000000 = 8002CA6B40

Now convert PA=8002CA6B40 to VA.
VA = PA - PHYS_OFFSET + PAGE_OFFSET = 8002CA6B40 - 8000000000 + fffffe0000000000
= fffffe0002CA6B40 which not equal to fffffc0008ca6b40.

So, do we have dual mapping for all physical addresses? If not, how does it
work? What I am missing. 

If its dual mapping, then probably we will need to fix couple of things in
kexec-tools.

~Pratyush
