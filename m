From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Aug 2016 09:05:31 +0100
Subject: [PATCH v15 07/13] arm64: factor work_pending state machine to C
In-Reply-To: <1471382376-5443-8-git-send-email-cmetcalf@mellanox.com>
References: <1471382376-5443-1-git-send-email-cmetcalf@mellanox.com>
 <1471382376-5443-8-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160817080531.GA5601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Tue, Aug 16, 2016 at 05:19:30PM -0400, Chris Metcalf wrote:
> Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
> state machine that can be difficult to reason about due to duplicated
> code and a large number of branch targets.
> 
> This patch factors the common logic out into the existing
> do_notify_resume function, converting the code to C in the process,
> making the code more legible.
> 
> This patch tries to closely mirror the existing behaviour while using
> the usual C control flow primitives. As local_irq_{disable,enable} may
> be instrumented, we balance exception entry (where we will almost most
> likely enable IRQs) with a call to trace_hardirqs_on just before the
> return to userspace.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---
>  arch/arm64/kernel/entry.S  | 12 ++++--------
>  arch/arm64/kernel/signal.c | 36 ++++++++++++++++++++++++++----------
>  2 files changed, 30 insertions(+), 18 deletions(-)

I plan to queue this one in the arm64 tree for 4.9. Should hit -next
sometime next week.

Will
