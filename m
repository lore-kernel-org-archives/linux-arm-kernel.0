From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Tue, 19 Jul 2016 22:14:26 +0200
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <CAGXu5jKRDuELqGY1F-D4+MD+dMXSbiPGzf1hXb7Kp8ACBjpw9g@mail.gmail.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <578DF109.5030704@de.ibm.com>
 <CAGXu5jKRDuELqGY1F-D4+MD+dMXSbiPGzf1hXb7Kp8ACBjpw9g@mail.gmail.com>
Message-ID: <578E8A22.5080807@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2016 09:31 PM, Kees Cook wrote:
> On Tue, Jul 19, 2016 at 2:21 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> On 07/15/2016 11:44 PM, Kees Cook wrote:
>>> +config HAVE_ARCH_LINEAR_KERNEL_MAPPING
>>> +     bool
>>> +     help
>>> +       An architecture should select this if it has a secondary linear
>>> +       mapping of the kernel text. This is used to verify that kernel
>>> +       text exposures are not visible under CONFIG_HARDENED_USERCOPY.
>>
>> I have trouble parsing this. (What does secondary linear mapping mean?)
> 
> I likely need help clarifying this language...
> 
>> So let me give an example below
>>
>>> +
>> [...]
>>> +/* Is this address range in the kernel text area? */
>>> +static inline const char *check_kernel_text_object(const void *ptr,
>>> +                                                unsigned long n)
>>> +{
>>> +     unsigned long textlow = (unsigned long)_stext;
>>> +     unsigned long texthigh = (unsigned long)_etext;
>>> +
>>> +     if (overlaps(ptr, n, textlow, texthigh))
>>> +             return "<kernel text>";
>>> +
>>> +#ifdef HAVE_ARCH_LINEAR_KERNEL_MAPPING
>>> +     /* Check against linear mapping as well. */
>>> +     if (overlaps(ptr, n, (unsigned long)__va(__pa(textlow)),
>>> +                  (unsigned long)__va(__pa(texthigh))))
>>> +             return "<linear kernel text>";
>>> +#endif
>>> +
>>> +     return NULL;
>>> +}
>>
>> s390 has an address space for user (primary address space from 0..4TB/8PB) and a separate
>> address space (home space from 0..4TB/8PB) for the kernel. In this home space the kernel
>> mapping is virtual containing the physical memory as well as vmalloc memory (creating aliases
>> into the physical one). The kernel text is mapped from _stext to _etext in this mapping.
>> So I assume this would qualify for HAVE_ARCH_LINEAR_KERNEL_MAPPING ?
> 
> If I understand your example, yes. In the home space you have two
> addresses that reference the kernel image?

No, there is only one address that points to the kernel.
As we have no kernel ASLR yet, and the kernel mapping is 
a 1:1 mapping from 0 to memory end and the kernel is only
from _stext to _etext. The vmalloc area contains modules
and vmalloc but not a 2nd kernel mapping.

But thanks for your example, now I understood. If we have only
one address 
>>> +     if (overlaps(ptr, n, textlow, texthigh))
>>> +             return "<kernel text>";

This is just enough.

So what about for the CONFIG text:

       An architecture should select this if the kernel mapping has a secondary
       linear mapping of the kernel text - in other words more than one virtual
       kernel address that points to the kernel image. This is used to verify 
       that kernel text exposures are not visible under CONFIG_HARDENED_USERCOPY.


> I wonder if I can avoid the CONFIG entirely if I just did a
> __va(__pa(_stext)) != _stext test... would that break anyone?

Can this be resolved on all platforms at compile time?
