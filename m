From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Dec 2017 12:19:41 +0000
Subject: [PATCH 0/2] Fixes for SW PAN
In-Reply-To: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
References: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
Message-ID: <20171206121941.vcxgcjb5pzr7dlpn@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 11:16:06AM +0000, Will Deacon wrote:
> Hi all,
> 
> After lots of collective head scratching in response to Vinayak's mail
> here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545641.html
> 
> It turns out that we have a problem with SW PAN and kernel threads, where
> the saved ttbr0 value for a kernel thread can be stale and subsequently
> inherited by other kernel threads over a fork.
> 
> These two patches attempt to fix that. We've not be able to reproduce
> the exact failure reported above, but I added some assertions to the
> uaccess routines to check for discrepancies between the active_mm pgd
> and the saved ttbr0 value (ignoring the zero page) and these no longer
> fire with these changes, but do fire without them if EFI runtime services
> are enabled on my Seattle board.

Both patches look good to me, per my understanding of the problem, so
FWIW, for the series:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

However, I think we have another issue in this area. We have sequences
where we update the HW TTBR0 before the shadow, e.g. in efi_set_pgd(),
where we do:

	cpu_set_reserved_ttbr0();
	update_saved_ttbr0(current, current->active_mm);

... so if an exception comes in between after HW TTBR0 update but before
the shadow update, the stale shadow value will be restored upon the
exception return, leaving the HW TTBR0 stale.

That's easy enough to fix in the efi code, e.g.

	update_saved_ttbr0(current, current->active_mm);
	barrier();
	cpu_set_reserved_ttbr0();

... but I haven't yet figured out a nice way to sort out switch_mm(),
__switch_mm(), and check_and_switch_context().

Thanks,
Mark.
