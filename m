From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 05 Dec 2013 14:23:27 +0000
Subject: [GIT PULL] Cacheflush updates for 3.12
In-Reply-To: <20131204161329.GA14145@mudshark.cambridge.arm.com>
References: <20130812173155.GI25995@mudshark.cambridge.arm.com>
 <CAH9NwWd1AfN_YnO-fj94+wTbE8768H518=EndVcX=dFCV9WESg@mail.gmail.com>
 <20131204161329.GA14145@mudshark.cambridge.arm.com>
Message-ID: <1386253407.3525.8.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-04 at 16:13 +0000, Will Deacon wrote:
> took another look at that patch and can't see anything obviously wrong
> with it. 

If the memory region isn't guaranteed to be page aligned then doesn't it
flush up to PAGE_SIZE-1 more bytes than requested and so exceed the
bounds check in do_cache_op? Fixing this as below _appears_ to stop the
Browser crashes I'm seeing (still doing some more testing)...

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index dbf0923..cbc9dae 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -512,6 +512,10 @@ __do_cache_op(unsigned long start, unsigned long end)
        unsigned long chunk = PAGE_SIZE;
 
        do {
+               unsigned long chunk_end = start + chunk;
+               if (chunk_end > end)
+                       chunk_end = end;
+
                if (signal_pending(current)) {
                        struct thread_info *ti = current_thread_info();
 
@@ -531,7 +535,7 @@ __do_cache_op(unsigned long start, unsigned long end)
                        return -ERESTART_RESTARTBLOCK;
                }
 
-               ret = flush_cache_user_range(start, start + chunk);
+               ret = flush_cache_user_range(start, chunk_end);
                if (ret)
                        return ret;



-- 
Tixy
