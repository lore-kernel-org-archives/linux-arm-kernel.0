From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Wed,  7 Oct 2009 11:49:36 +0200
Subject: Make totalhigh_pages of consistent type.
Message-ID: <1254908977-12827-1-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing the value of totalhigh_pages requires casting, see
typical print message:

arch/x86/mm/init_32.c:
  printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, "
      "%dk reserved, %dk data, %dk init, %ldk highmem)\n",
    nr_free_pages() << (PAGE_SHIFT-10),
    num_physpages << (PAGE_SHIFT-10),
    codesize >> 10,
    reservedpages << (PAGE_SHIFT-10),
    datasize >> 10,
    initsize >> 10,
    (unsigned long)(totalhigh_pages << (PAGE_SHIFT-10)));


The problem is that the type of totalhigh_pages is dependent on
CONFIG_HIGHMEM being set or not.

include/linux/highmem.h:
  #ifdef CONFIG_HIGHMEM
  
  extern unsigned long totalhigh_pages;
  
  #else /* CONFIG_HIGHMEM */
  
 -#define totalhigh_pages 0
 +#define totalhigh_pages 0UL
  ...

The patch changes the define, so that totalhigh_pages is of uniform
type in both cases.

Patch is build-tested on x86_32 and ARM

kind regards

Andreas
