From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 31 May 2016 11:17:04 +0100
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
Message-ID: <574D64A0.2070207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/16 04:02, Marcin Wojtas wrote:
> Hi,
>
> After rebasing platform support of two different ARMv8 SoC's from v4.1
> baseline to v4.4 it occurred that stressed systems tend to have page
> allocation problems, related to creating new slabs:
>
> http://pastebin.com/FhRW5DsF
>
> Steps to reproduce:
> - use SATA drive (on-board or over PCIe) with 2 btrfs 50G partitions
> - run a couple of loops of following script:
> mount /dev/sd${1}1 /mnt
> mount /dev/sd${1}2 /mnt2
> i=0
> while [[ $i -lt ${2} ]]
> do
> echo -e "i = ${i}\n"
> dd if=/dev/zero of=/mnt/3g bs=3M count=1024 &
> dd if=/dev/zero of=/mnt/2g bs=2M count=1024 &
> dd if=/dev/zero of=/mnt/1g bs=1M count=1024 &
> dd if=/dev/zero of=/mnt2/2g bs=2M count=1024 &
> dd if=/dev/zero of=/mnt2/1g bs=1M count=1024 &
> dd if=/dev/zero of=/mnt2/3g bs=3M count=1024
> let "i++"
> done
>
> The issue also reproduced on v4.6. Usually problems occur within first
> iteration and then the rest is done without errors, also kernel remain
> stable. I got an information, that page alloc problem were observed
> also on Marvell ARMv7 platfrom (Armada38x).

I remember there were some issues around 4.2 with the revision of the 
arm64 atomic implementations affecting the cmpxchg_double() in SLUB, but 
those should all be fixed (and the symptoms tended to be considerably 
more fatal). A stronger candidate would be 97303480753e (which landed in 
4.4), which has various knock-on effects on the layout of SLUB internals 
- does fiddling with L1_CACHE_SHIFT make any difference?

Robin.

> About the debug itself - after adding simplest possible trace in
> trace/events/kmem.h (single argument u64 for counter or whatever kind
> of number), it was shown both on v4.1 and v4.4 following condition is
> achieved multiple times during test:
> In __alloc_pages_nodemask(), during the test kernel jumps huge amount
> of times (~250k times in v4.1 and ~570k in v4.4 per one script loop)
> into following 'unlikely' condition:
> page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
> if (unlikely(!page)) {
>      [...]
>      page = __alloc_pages_slowpath(alloc_mask, order, &ac);
> }
>
> The further difference is seen in __alloc_pages_slowpath().
> warn_alloc_page() (routine responsible for printing page alloc failure
> message) is reached via following condition:
> if (!can_direct_reclaim) {
>      [...]
>      goto nopage;
> }
> In v4.1 ~5 times and in v4.4 ~40 times per one script loop.
>
> Printing message however can be blocked by following condition in
> warn_alloc_fail():
> if ((gfp_mask & _GFP_NOWARN) || !_ratelimit(&nopage_rs) ||
>      debug_guardpage_minorder() > 0)
>          return;
> Only first two are relevant. As ratelimit is derived directly from
> CONFIG_HZ and this parameter differ between v4.1 and v4.4 (100 vs 250,
> also CONFIG_SCHED_HRTICK is enabled only in v4.4) the configs were
> swapped, but no change in behavior.
>
> Also within 'faulty' revision there is a difference, depending on
> filesystem used - with buildroot the dumps occur, but with same test
> under ubuntu - it's impossible see the failure output (and it's not a
> question of dmesg level:)). Comparing /proc/sys/vm contents didn't
> show anything meaningful.
>
> I tried to analyze changes around mm/ folder between v4.1 and v4.4
> that may cause such difference, but wasn't able to find out what may
> be causing the issue. Have anyone encountered such problems in recent
> revisions? I would be very grateful for any hint or comment. Also if
> any other data can be captured, please let know.
>
> Best regards,
> Marcin Wojtas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
