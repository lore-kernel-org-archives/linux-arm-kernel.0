From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Sep 2011 12:21:55 +0100
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <CACrgxGB16ibPARkf8TN4S47vOZwm+W2pBJyEj=e+F0uFK5NjmA@mail.gmail.com>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-5-git-send-email-john.stultz@linaro.org>
	<20101214093002.GA18425@n2100.arm.linux.org.uk>
	<AANLkTim1Wspod2LnfVw7atzP921C6o7EiKRVqw9LeqhG@mail.gmail.com>
	<20101214190503.GB24303@n2100.arm.linux.org.uk>
	<AANLkTimw839TCrzY0X4n8_AcwwdT1kFxNQNNsFC9SRdb@mail.gmail.com>
	<BANLkTinmCNi3MgcZo5CJorpoLNxwMwhVOA@mail.gmail.com>
	<20110404133718.GC22480@n2100.arm.linux.org.uk>
	<1301924629.15819.42.camel@e102109-lin.cambridge.arm.com>
	<CACrgxGB16ibPARkf8TN4S47vOZwm+W2pBJyEj=e+F0uFK5NjmA@mail.gmail.com>
Message-ID: <20110905112155.GF3269@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 08:32:28AM +0100, Jiejing.Zhang  wrote:
> I met this issue on our development board: iMX53 + 2.6.35.2 Kernel,
> this is stack trace when the dead lock happens.
> 
> You can see the hung task are dead lock at __read_lock(), after I add
> more debug message and dump the hung task's stack trace.
> 
> After apply this patch, the hung is gong.

Russell doesn't agree with the original patch, so we have to live with
this dead-lock in mainline :(. From my perspective, it is a perfectly
valid patch and there is no race. I'll keep it in my trees for now.

If a user space app is so badly written that it calls the cache flushing
function while remapping the same memory range from a different thread,
it deserve some failures. But even then, the cache flushing function is
simply cleaning the D-cache which is a safe operation (as compared to
invalidation).

For reference, that's the original post:

http://article.gmane.org/gmane.linux.ports.arm.kernel/99356

-- 
Catalin
