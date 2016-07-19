From: keescook@chromium.org (Kees Cook)
Date: Tue, 19 Jul 2016 12:31:15 -0700
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <578DF109.5030704@de.ibm.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <578DF109.5030704@de.ibm.com>
Message-ID: <CAGXu5jKRDuELqGY1F-D4+MD+dMXSbiPGzf1hXb7Kp8ACBjpw9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 2:21 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 07/15/2016 11:44 PM, Kees Cook wrote:
>> +config HAVE_ARCH_LINEAR_KERNEL_MAPPING
>> +     bool
>> +     help
>> +       An architecture should select this if it has a secondary linear
>> +       mapping of the kernel text. This is used to verify that kernel
>> +       text exposures are not visible under CONFIG_HARDENED_USERCOPY.
>
> I have trouble parsing this. (What does secondary linear mapping mean?)

I likely need help clarifying this language...

> So let me give an example below
>
>> +
> [...]
>> +/* Is this address range in the kernel text area? */
>> +static inline const char *check_kernel_text_object(const void *ptr,
>> +                                                unsigned long n)
>> +{
>> +     unsigned long textlow = (unsigned long)_stext;
>> +     unsigned long texthigh = (unsigned long)_etext;
>> +
>> +     if (overlaps(ptr, n, textlow, texthigh))
>> +             return "<kernel text>";
>> +
>> +#ifdef HAVE_ARCH_LINEAR_KERNEL_MAPPING
>> +     /* Check against linear mapping as well. */
>> +     if (overlaps(ptr, n, (unsigned long)__va(__pa(textlow)),
>> +                  (unsigned long)__va(__pa(texthigh))))
>> +             return "<linear kernel text>";
>> +#endif
>> +
>> +     return NULL;
>> +}
>
> s390 has an address space for user (primary address space from 0..4TB/8PB) and a separate
> address space (home space from 0..4TB/8PB) for the kernel. In this home space the kernel
> mapping is virtual containing the physical memory as well as vmalloc memory (creating aliases
> into the physical one). The kernel text is mapped from _stext to _etext in this mapping.
> So I assume this would qualify for HAVE_ARCH_LINEAR_KERNEL_MAPPING ?

If I understand your example, yes. In the home space you have two
addresses that reference the kernel image? The intent is that if
__va(__pa(_stext)) != _stext, there's a linear mapping of physical
memory in the virtual memory range. On x86_64, the kernel is visible
in two locations in virtual memory. The kernel start in physical
memory address 0x01000000 maps to virtual address 0xffff880001000000,
and the "regular" virtual memory kernel address is at
0xffffffff81000000:

# grep Kernel /proc/iomem
  01000000-01a59767 : Kernel code
  01a59768-0213d77f : Kernel data
  02280000-02fdefff : Kernel bss

# grep startup_64 /proc/kallsyms
ffffffff81000000 T startup_64

# less /sys/kernel/debug/kernel_page_tables
...
---[ Low Kernel Mapping ]---
...
0xffff880001000000-0xffff880001a00000          10M     ro         PSE
 GLB NX pmd
0xffff880001a00000-0xffff880001a5c000         368K     ro   GLB NX pte
0xffff880001a5c000-0xffff880001c00000        1680K     RW   GLB NX pte
...
---[ High Kernel Mapping ]---
...
0xffffffff81000000-0xffffffff81a00000          10M     ro         PSE
 GLB x  pmd
0xffffffff81a00000-0xffffffff81a5c000         368K     ro   GLB x  pte
0xffffffff81a5c000-0xffffffff81c00000        1680K     RW   GLB NX pte
...

I wonder if I can avoid the CONFIG entirely if I just did a
__va(__pa(_stext)) != _stext test... would that break anyone?

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
