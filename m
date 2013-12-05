From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 05 Dec 2013 09:55:55 +0000
Subject: [GIT PULL] Cacheflush updates for 3.12
In-Reply-To: <20131204161329.GA14145@mudshark.cambridge.arm.com>
References: <20130812173155.GI25995@mudshark.cambridge.arm.com>
 <CAH9NwWd1AfN_YnO-fj94+wTbE8768H518=EndVcX=dFCV9WESg@mail.gmail.com>
 <20131204161329.GA14145@mudshark.cambridge.arm.com>
Message-ID: <1386237355.16677.34.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-04 at 16:13 +0000, Will Deacon wrote:
> On Wed, Dec 04, 2013 at 03:37:36PM +0000, Christian Gmeiner wrote:
> > 2013/8/12 Will Deacon <will.deacon@arm.com>:
> > > Please pull the following user-cacheflush updates for 3.12. This series both
> > > improves performance of cacheflush-heavy workloads (i.e. browser benchmarks)
> > > and also addresses a DoS issue on non-preemptible systems.
> 
> [...]
> 
> > Hi all.
> 
> Hello,
> 
> > I spend the last day running a bisect and I think I have found a problem :)
> > 
> > I have a simple automated test case running, which looks like this:
> > 
> > imx6d based device running X, chromium and x11vnc <----> windows pc connected
> > via VNC to the device. With this patchset applyed the browser tab
> > crashed after about
> > 5 minutes hitting the F5/refresh button every 1-3 seconds.
> 
> Hmm... it would be great if we had a simpler way to reproduce this, but ok.
> How many cores do you have on your IMX6? Also, how does the browser tab crash?
> Does it receive a SIGILL?

I think I'm also seeing this problem with Linaro Android on vexpress.
The latest Android version (KitKat) has moved to using the Chrome
browser and it crashes very easily after just a few seconds use (with
SIGSEGV's because execution jumped into kernel virtual memory range).

The reason I think it's the same issue as talked about in this email is
that after reading this I check a 3.10 kernel with the same Android
image and that was fine. Then I tried a previously crashing 3.13-rc2
kernel with the hack below to undo $subject, and that stopped the
crashes:

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index dbf0923..ff58932 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -560,7 +560,7 @@ do_cache_op(unsigned long start, unsigned long end,
int flags)
        if (!access_ok(VERIFY_READ, start, end - start))
                return -EFAULT;
 
-       return __do_cache_op(start, end);
+       return flush_cache_user_range(start, end);
 }

A Linaro Android vexpress build which shows the bug can de found at
https://android-build.linaro.org/builds/~linaro-android/vexpress-linaro/#build=172

And the bug is being tracked at 
https://bugs.launchpad.net/linaro-android/+bug/1254750
(ignore comments on that report about serial console issues, they should
have been on a different bug report)

-- 
Tixy

> > 28256d612726a28a8b9d3c49f2b74198c4423d6a is the first bad commit
> > commit 28256d612726a28a8b9d3c49f2b74198c4423d6a
> > Author: Will Deacon <will.deacon@arm.com>
> > Date:   Mon May 13 15:21:49 2013 +0100
> > 
> >     ARM: cacheflush: split user cache-flushing into interruptible chunks
> > 
> >     Flushing a large, non-faulting VMA from userspace can potentially result
> >     in a long time spent flushing the cache line-by-line without preemption
> >     occurring (in the case of CONFIG_PREEMPT=n).
> > 
> >     Whilst this doesn't affect the stability of the system, it can certainly
> >     affect the responsiveness and CPU availability for other tasks.
> > 
> >     This patch splits up the user cacheflush code so that it flushes in
> >     chunks of a page. After each chunk has been flushed, we may reschedule
> >     if appropriate and, before processing the next chunk, we allow any
> >     pending signals to be handled before resuming from where we left off.
> > 
> >     Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> I took another look at that patch and can't see anything obviously wrong
> with it. It may, however, be exposing bugs in userspace that you would
> struggle to hit before.
> 
> > :040000 040000 33ebf747dde46884ce4e7d4ce922fef3cd5b580e
> > 22cdb8a0bc6dc72cb92d93c13ed1a45081269f77 M      arch
> > 
> > 
> > If I revert 28256d612726a28a8b9d3c49f2b74198c4423d6a and
> > 97c72d89ce0ec8c73f19d5e35ec1f90f7a14bed7 my "test" runs hours.
> > 
> > 
> > What debug options should I enable to get meaningful output from the kernel?
> 
> An strace log of the failing case would be good. Another thing you could try
> is commenting out the cond_resched in __do_cache_op and see if that helps.
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
