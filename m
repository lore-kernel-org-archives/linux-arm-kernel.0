From: deller@gmx.de (Helge Deller)
Date: Fri, 17 Feb 2017 09:22:44 +0100
Subject: [PATCHv3 2/2] arch: Rename CONFIG_DEBUG_RODATA and
 CONFIG_DEBUG_MODULE_RONX
In-Reply-To: <CAGXu5jJ4FD=6HLK_21T079JrO569DwWBTeiD18x3WRrYBsaAqw@mail.gmail.com>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-3-git-send-email-labbott@redhat.com>
 <20170216222529.GA7531@amd>
 <CAGXu5jJ4FD=6HLK_21T079JrO569DwWBTeiD18x3WRrYBsaAqw@mail.gmail.com>
Message-ID: <fe5a4a8c-6f5d-126d-abd9-025e9ff97351@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2017 02:08, Kees Cook wrote:
> On Thu, Feb 16, 2017 at 2:25 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> Hi!
>>
>>>
>>> -config DEBUG_RODATA
>>> +config STRICT_KERNEL_RWX
>>>       bool "Make kernel text and rodata read-only" if ARCH_OPTIONAL_KERNEL_RWX
>>>       depends on ARCH_HAS_STRICT_KERNEL_RWX
>>>       default !ARCH_OPTIONAL_KERNEL_RWX ||
>>
>> Debug features are expected to have runtime cost, so kconfig help is
>> silent about those. But there are runtime costs, right? It would be
>> nice to mention them in the help text...
> 
> It depends on the architecture. The prior help text for arm said:
> 
>          The tradeoff is that each region is padded to section-size (1MiB)
>          boundaries (because their permissions are different and splitting
>          the 1M pages into 4K ones causes TLB performance problems), which
>          can waste memory.
> 
> parisc (somewhat inaccurately) said:
> 
>          This option may have a slight performance impact because a
>          portion of the kernel code won't be covered by a TLB anymore.

The logic on parisc is actually:
If huge page support is enabled, we map 1MB pages (and behave like arm wrt alignments).
If huge page support is disabled we stay at 4k/PAGE_SIZE pages (without 1M alignment).
 
> IIUC, arm64 does what parisc is hinting at: mappings at the end are
> broken down to PAGE_SIZE. 

On parisc we never implemented that.

> On x86, IIUC, there's actually no change to
> TLB performance due to how the mappings are already set up.
> 
> I'm not sure the best way to express this in the new help text. Do you
> have some suggestions on wording? Personally, I don't really think
> it's worth mentioning this in Kconfig help,

I agree on this.

> which, in theory, is
> supposed to limit how technical it gets. And I think the performance
> impact is almost entirely negligible compared to the risks addressed.

Helge
