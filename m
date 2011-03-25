From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 25 Mar 2011 16:08:08 +0000
Subject: [PATCH v2] ARM: perf: ensure overflows aren't missed due to IRQ
	latency
In-Reply-To: <1300986442-20461-1-git-send-email-will.deacon@arm.com>
References: <1300986442-20461-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110325160808.GR3130@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Mar 24, 2011 at 05:07:22PM +0000, Will Deacon wrote:
> If a counter overflows during a perf stat profiling run it may overtake
> the last known value of the counter:
> 
>     0        prev     new                0xffffffff
>     |----------|-------|----------------------|
> 
> In this case, the number of events that have occurred is
> (0xffffffff - prev) + new. Unfortunately, the event update code will
> not realise an overflow has occurred and will instead report the event
> delta as (new - prev) which may be considerably smaller than the real
> count.
> 
> This patch adds an extra argument to armpmu_event_update which indicates
> whether or not an overflow has occurred. If an overflow has occurred
> then we use the maximum period of the counter to calculate the elapsed
> events.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Reported-by: Ashwin Chaugule <ashwinc@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Looks nice!

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
