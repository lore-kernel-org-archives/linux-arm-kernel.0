From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 20 Nov 2017 10:29:26 -0500
Subject: [PATCH v4][for 4.15] dmaengine: dmatest: move callback wait queue
 to thread context
In-Reply-To: <1511191578-1781-1-git-send-email-awallis@codeaurora.org>
References: <1511191578-1781-1-git-send-email-awallis@codeaurora.org>
Message-ID: <2ae61894-4a39-c40f-efd4-fbf87c9e60af@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2017 10:26 AM, Adam Wallis wrote:
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
> 
> Cc: stable at vger.kernel.org

FYI, I removed the other CC's to stable, since I am actively working on
upstreaming the dependency into all the stable branches.

> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=197605
> Fixes: adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> Reviewed-by: Sinan Kaya <okaya@codeaurora.org>
> Suggested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
> changes from v3: Added check to thread wait variable if terminate_all fails
> changes from v2: Added "Fixes" tag
> changes from v1: Added pre-req patches for stable
> 
>  drivers/dma/dmatest.c | 55 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 47edc7f..45a4ee9 100644
[..]

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
