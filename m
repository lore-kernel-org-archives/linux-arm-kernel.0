From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 19:17:55 +0100
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
 <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150713181755.GP2632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 11, 2015 at 09:25:23PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Most broadcast TLB invalidations are unnecessary.  So when
> invalidating for a given mm/vma target the only the needed CPUs via
> and IPI.
> 
> For global TLB invalidations, also use IPI.
> 
> Tested on Cavium ThunderX.
> 
> This change reduces 'time make -j48' on kernel from 139s to 116s (83%
> as long).

Any idea *why* you're seeing such an improvement? Some older kernels had
a bug where we'd try to flush a negative (i.e. huge) range by page, so it
would be nice to rule that out. I assume these measurements are using
mainline?

Having TLBI responsible for that amount of a kernel build doesn't feel
right to me and doesn't line-up with the profiles I'm used to seeing.

You have 16-bit ASIDs, right?

Will
