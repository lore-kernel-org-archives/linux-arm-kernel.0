From: ccross@google.com (Colin Cross)
Date: Mon, 14 Feb 2011 20:11:23 -0800
Subject: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
Message-ID: <AANLkTi=JF1c-aFHpSZ-XECLEPSMsFihXT+w3=NXdYn8L@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 5:21 PM, Colin Cross <ccross@google.com> wrote:
> On Fri, Feb 11, 2011 at 8:17 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> This adds core support for saving and restoring CPU coprocessor
>> registers for suspend/resume support. ?This contains support for suspend
>> with ARM920, ARM926, SA11x0, PXA25x, PXA27x, PXA3xx, V6 and V7 CPUs.
>
> I would like to use cpu_suspend in a case where the L2 is still
> enabled. ?When cpu_resume is called, the MMU and cache bits in SCTLR
> are disabled, so the reads skip the L2 cache, and the data that was
> saved (sleep_save_sp and *sleep_save_sp) is not read back.
>
> Is it possible to call the outer_cache functions from cpu_suspend to
> flush sleep_save_sp and the saved data?

Even with a cache flush, cpu_resume_turn_on_mmu fails because the page
table modification, done with the cache off, ends up in memory, but
the L2 contains the old value.  When the MMU and cache are enabled,
the 1:1 mapping disappears.  The page table would need to be
invalidated during suspend.

I can avoid the problem entirely by leaving the MMU on and skipping
cpu_resume when the CPU does not go through reset.
