From: mingo@kernel.org (Ingo Molnar)
Date: Mon, 20 Feb 2017 08:21:30 +0100
Subject: [PATCHv3 2/2] arch: Rename CONFIG_DEBUG_RODATA and
 CONFIG_DEBUG_MODULE_RONX
In-Reply-To: <CAGXu5jJ4FD=6HLK_21T079JrO569DwWBTeiD18x3WRrYBsaAqw@mail.gmail.com>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-3-git-send-email-labbott@redhat.com>
 <20170216222529.GA7531@amd>
 <CAGXu5jJ4FD=6HLK_21T079JrO569DwWBTeiD18x3WRrYBsaAqw@mail.gmail.com>
Message-ID: <20170220072130.GB8974@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> On Thu, Feb 16, 2017 at 2:25 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >>
> >> -config DEBUG_RODATA
> >> +config STRICT_KERNEL_RWX
> >>       bool "Make kernel text and rodata read-only" if ARCH_OPTIONAL_KERNEL_RWX
> >>       depends on ARCH_HAS_STRICT_KERNEL_RWX
> >>       default !ARCH_OPTIONAL_KERNEL_RWX ||
> >
> > Debug features are expected to have runtime cost, so kconfig help is
> > silent about those. But there are runtime costs, right? It would be
> > nice to mention them in the help text...
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
> 
> IIUC, arm64 does what parisc is hinting at: mappings at the end are
> broken down to PAGE_SIZE. On x86, IIUC, there's actually no change to
> TLB performance due to how the mappings are already set up.

BTW., a good strategy with RAM sizes above say 4GB would be to just round up to 
the next large-TLB boundary (2MB) and waste 0-2MB of RAM - which is only 0.05% of 
4GB of RAM. On most workloads, especially with SSDs it's probably a positive RAM 
vs. performance trade-off.

Thanks,

	Ingo
