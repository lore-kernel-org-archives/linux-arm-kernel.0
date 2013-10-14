From: zonque@gmail.com (Daniel Mack)
Date: Mon, 14 Oct 2013 15:44:21 +0200
Subject: [PATCH RFC 0/1] ARM: boot: make atags area relocatable
Message-ID: <1381758262-31159-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been hunting an effect of failed ARM kernel boots when kexec is
used, and here's a RFC for a solution of what I figured out.

kexec currently assumes that the kernel image compression rate is 1:4,
and stuffs the dtb image after what is assumed the end of the kernel
image. However, it does not read in the kernel's symbol table or
anything alike and hence can't know about the size of the bss
section. In my case, it turns out that upon __vet_atags is executed,
the dtb image lies inside the bss area and is hence overridden with
zeros later on.

This patch makes an attempt to fix this problem by detecting the
described condition and relocating the atags/bss section to where
the '_end' symbol is stored.

Disclaimer: I'm really not sure whether my virt_to_phys() approach
and other asm details are fully correct. I'm open to suggestions :)

Successfully tested on a AM335x platform that fails to kexec without
the patch.


Thanks,
Daniel


Daniel Mack (1):
  ARM: head-common.S: relocate atags area if necessary

 arch/arm/kernel/head-common.S | 58 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

-- 
1.8.3.1
