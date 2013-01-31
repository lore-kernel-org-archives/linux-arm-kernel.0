From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Thu, 31 Jan 2013 18:08:32 +0400
Subject: IPC SHM alignment on ARMv7
In-Reply-To: <20130131134747.GY23505@n2100.arm.linux.org.uk>
References: <510A7262.4060307@parallels.com>
 <20130131134747.GY23505@n2100.arm.linux.org.uk>
Message-ID: <510A7AE0.10309@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 05:47 PM, Russell King - ARM Linux wrote:
> Err, no.  Try again - this is the mainline kernel:

I'm sorry, I forgot to note that it's very old code,
it's from the tglx/history.git that you may find here:
http://git.kernel.org/?p=linux/kernel/git/tglx/history.git;a=commit;h=4197692eef113eeb8e3e413cc70993a5e667e5b8

The piece of code I'm telling about hasn't changed
very much since then, it looks in the following way
in that commit:

  25 unsigned long
  26 arch_get_unmapped_area(struct file *filp, unsigned long addr,
  27         unsigned long len, unsigned long pgoff, unsigned long flags)
  28 {
  29     struct mm_struct *mm = current->mm;
  30     struct vm_area_struct *vma;
  31     unsigned long start_addr;
  32 #ifdef CONFIG_CPU_V6
  33     unsigned int cache_type;
  34     int do_align = 0, aliasing = 0;
  35
  36     /*
  37      * We only need to do colour alignment if either the I or D
  38      * caches alias.  This is indicated by bits 9 and 21 of the
  39      * cache type register.
  40      */
  41     cache_type = read_cpuid(CPUID_CACHETYPE);
  42     if (cache_type != read_cpuid(CPUID_ID)) {
  43         aliasing = (cache_type | cache_type >> 12) & (1 << 9);
  44         if (aliasing)
  45             do_align = filp || flags & MAP_SHARED;
  46     }


The last commit that touches the file is 
394ef6403abc36900d9303395a49a72d32666f2a
(http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=394ef6403abc36900d9303395a49a72d32666f2a)
and currently the lines look in the following way:

[arch/arm/mm/mmap.c]
[...]
54 unsigned long
55 arch_get_unmapped_area(struct file *filp, unsigned long addr,
56                 unsigned long len, unsigned long pgoff, unsigned long 
flags)
57 {
58         struct mm_struct *mm = current->mm;
59         struct vm_area_struct *vma;
60         int do_align = 0;
61         int aliasing = cache_is_vipt_aliasing();
62         struct vm_unmapped_area_info info;
63
64         /*
65          * We only need to do colour alignment if either the I or D
66          * caches alias.
67          */
68         if (aliasing)
69                 do_align = filp || (flags & MAP_SHARED);


Particularly, the lines

  68     if (aliasing)
  69         do_align = filp || (flags & MAP_SHARED);

hasn't changed since then.


I intentionally provided a reference to a historical branch
to point out that this code hasn't changed.

-- 
Sincerely yours,
Alexander Kartashov

Intern
Core team

www.parallels.com

Skype: aleksandr.kartashov
Email: alekskartashov at parallels.com
