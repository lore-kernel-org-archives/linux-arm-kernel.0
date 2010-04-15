From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Apr 2010 23:36:21 +0100
Subject: [PATCH 2/2] arm: invalidate TLBs when enabling mmu
In-Reply-To: <l2sf17812d71004150524w1dc68807i323660a42a52958f@mail.gmail.com>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
	<1268143623-22361-2-git-send-email-saeed@marvell.com>
	<1268143623-22361-3-git-send-email-saeed@marvell.com>
	<20100414182726.GB13275@n2100.arm.linux.org.uk>
	<l2sf17812d71004150524w1dc68807i323660a42a52958f@mail.gmail.com>
Message-ID: <20100415223621.GA544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 15, 2010 at 08:24:02PM +0800, Eric Miao wrote:
> Another noticeable difference is the slow decompressing happens so far on
> kexec only, a normal boot without this additional "invalidate" does not
> exhibit such slowness. This leads to me to suspect that the MMU state might
> not be same between a normal bootup and a kexec soft reboot.
> 
> I may overlooked, but it looks to me that after a 1:1 mapping of ther user
> space area (from 0x0000_0000 to TASK_SIZE, which I guess will cause some
> other issue if the kexec kernel start entry starts beyond TASK_SIZE?), the
> MMU is NOT actually turned off through the reset. This might cause weird
> behavior with the original sequence of __armv7_mmu_cache_on ??

For kexec:

        cpu_proc_fin();
        setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
        cpu_reset(reboot_code_buffer_phys);

cpu_proc_fin() disables interrupts, flushes the cache and then disables
caches.

setup_mm_for_reboot() creates 1:1 mappings for the entire user address
space, which ends up being strongly ordered.

cpu_reset() is supposed to invalidate I/D caches, invalidate TLBs, and
disable the MMU prior to calling the passed address.  However, neither
ARMv6 nor ARMv7 does this - and I'm confused as to why not.
