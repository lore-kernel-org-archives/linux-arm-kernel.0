From: agraf@suse.de (Alexander Graf)
Date: Tue, 7 Jun 2016 16:13:03 +0200
Subject: [PATCH] arm64: Implement ptep_set_access_flags() for hardware
 AF/DBM
In-Reply-To: <1460559682-31267-1-git-send-email-catalin.marinas@arm.com>
References: <1460559682-31267-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <4c2b3cff-d4a7-f3b8-ef0d-f6caa21f412e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.04.16 17:01, Catalin Marinas wrote:
> When hardware updates of the access and dirty states are enabled, the
> default ptep_set_access_flags() implementation based on calling
> set_pte_at() directly is potentially racy. This triggers the "racy dirty
> state clearing" warning in set_pte_at() because an existing writable PTE
> is overridden with a clean entry.
> 
> There are two main scenarios for this situation:
> 
> 1. The CPU getting an access fault does not support hardware updates of
>    the access/dirty flags. However, a different agent in the system
>    (e.g. SMMU) can do this, therefore overriding a writable entry with a
>    clean one could potentially lose the automatically updated dirty
>    status
> 
> 2. A more complex situation is possible when all CPUs support hardware
>    AF/DBM:
> 
>    a) Initial state: shareable + writable vma and pte_none(pte)
>    b) Read fault taken by two threads of the same process on different
>       CPUs
>    c) CPU0 takes the mmap_sem and proceeds to handling the fault. It
>       eventually reaches do_set_pte() which sets a writable + clean pte.
>       CPU0 releases the mmap_sem
>    d) CPU1 acquires the mmap_sem and proceeds to handle_pte_fault(). The
>       pte entry it reads is present, writable and clean and it continues
>       to pte_mkyoung()
>    e) CPU1 calls ptep_set_access_flags()
> 
>    If between (d) and (e) the hardware (another CPU) updates the dirty
>    state (clears PTE_RDONLY), CPU1 will override the PTR_RDONLY bit
>    marking the entry clean again.
> 
> This patch implements an arm64-specific ptep_set_access_flags() function
> to perform an atomic update of the PTE flags.
> 
> Fixes: 2f4b829c625e ("arm64: Add support for hardware updates of the access and dirty pte bits")
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Ming Lei <tom.leiming@gmail.com>
> Tested-by: Julien Grall <julien.grall@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: <stable@vger.kernel.org> # 4.3+

This patch breaks swapping for me.

I've hit weird issues where systems stopped working half-way, with the
kernel still being fine and user space applications just stopping to
respond.

After some debugging we found out that it always happens when swapping
(to anything, backing storage doesn't matter). A quick bisect points to
this commit as culprit and indeed, if I disable CONFIG_ARM64_HW_AFDBM
the system works as expected.

For reference, here's my test case:

  $ qemu-system-aarch64 -nographic -M virt -cpu host -m 800M -kernel
Image  -initrd initrd.test -enable-kvm -append rd.break=pre-mount\
loglevel=9

Inside the VM:

  $ modprobe zram; echo $(( 256 * 1024 * 1024 )) >
/sys/block/zram0/disksize; mkswap /dev/zram0; swapon /dev/zram0
  $ dd if=/dev/zero of=/dev/null bs=700M &
  $ top

In the broken case, you'll see either systemd cpu time spike (because
it's stuck in a page fault loop) or the system hang (because the
application owning the screen is stuck in a page fault loop).

The back traces indicate that the page fault handler goes through and
the process just keeps banging on the same page fault over and over
again. I have not yet figured out what *exactly* is going wrong or why
this patch would actually give us that effect.

I was able to fully reproduce the issue with current Linus tree (4.7-rc2+).


Alex
