From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 28 Jun 2011 09:22:20 +0300
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <20110627110234.GC16103@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTimnuEK_9RedmD1OgcunX3rPvd-O0Q@mail.gmail.com>
	<20110627110234.GC16103@n2100.arm.linux.org.uk>
Message-ID: <BANLkTin80Z34=_uQaP=Dbv7eDxU1PH_qSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 2:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 27, 2011 at 01:34:48PM +0300, saeed bishara wrote:
>> Russell,
>> ? I'm curious about the correctness of this patch for systems with
>> outer cache. shouldn't the dsb be issued before the outer cache
>> maintenance?
>
> Maybe we should do two passes over SG lists then - one for the inner and
> another for the outer cache?
>
> In effect we could do three passes:
>
> 1. Calculate the total size of the SG list to determine whether full
> ? cache flush is more efficient.
> 2. Flush inner cache
> ? Then dsb()
> 3. Flush outer cache
> ? Another dsb()
>
looking at l2x0 cache, it seems to me that it would be possible to do
asynchronous l2 cache maintenance for
range operations, so maybe that can be utilized in order to
parallelism between inner cache and outer cache maintenance,
so the flow can be:
2. Flush sg buffer from inner cache
3. dsb()
4. start Flush outer cache for that buffer
5. Flush next sg buffer from inner cache
6. dsb
7. goto 4.
8. when no more buffers left, wait for outer cache operations

saeed
