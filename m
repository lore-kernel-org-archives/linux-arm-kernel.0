From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Dec 2017 17:30:51 +0000
Subject: [RFC PATCH] arm64: deactivate saved ttbr when mm is deactivated
In-Reply-To: <20171204165533.GI29619@arm.com>
References: <1512404606-26498-1-git-send-email-vinmenon@codeaurora.org>
 <20171204165533.GI29619@arm.com>
Message-ID: <20171204173051.3okro3evhpaxxmzi@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 04:55:33PM +0000, Will Deacon wrote:
> On Mon, Dec 04, 2017 at 09:53:26PM +0530, Vinayak Menon wrote:
> > A case is observed where a wrong physical address is read,
> > resulting in a bus error and that happens soon after TTBR0 is
> > set to the saved ttbr by uaccess_ttbr0_enable. This is always
> > seen to happen in the exit path of the task.

> > The mm has been released and the pgd is freed, but probe_kernel_read
> > invoked from slub results in call to __arch_copy_from_user. At the
> > entry to __arch_copy_from_user, when SW PAN is enabled, this results
> > in stale value being set to ttbr0. May be a speculative fetch aftwerwards
> > is resulting in invalid physical address access.

> I wonder whether it would be better to avoid restoring the user TTBR0 if
> KERNEL_DS is set. We could do the same thing for PAN. Do we ever access
> user addresses under KERNEL_DS?

I believe we assume that we don't.

IIUC, with PAN+UAO, when we have KERNEL_DS set, any uaccess to a user
address would fault.

Thanks,
Mark.
