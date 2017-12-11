From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 11 Dec 2017 08:46:41 +0530
Subject: [PATCH v5] dmaengine: dmatest: move callback wait queue to
 thread context
In-Reply-To: <1511797501-7877-1-git-send-email-awallis@codeaurora.org>
References: <1511797501-7877-1-git-send-email-awallis@codeaurora.org>
Message-ID: <20171211031641.GK18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 10:45:01AM -0500, Adam Wallis wrote:
> Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> introduced a bug (that is in fact documented by the patch commit text)
> that leaves behind a dangling pointer. Since the done_wait structure is
> allocated on the stack, future invocations to the DMATEST can produce
> undesirable results (e.g., corrupted spinlocks).
> 
> Commit a9df21e34b42 ("dmaengine: dmatest: warn user when dma test times
> out") attempted to WARN the user that the stack was likely corrupted but
> did not fix the actual issue.
> 
> This patch fixes the issue by pushing the wait queue and callback
> structs into the the thread structure. If a failure occurs due to time,
> dmaengine_terminate_all will force the callback to safely call
> wake_up_all() without possibility of using a freed pointer.

Applied, thanks

-- 
~Vinod
