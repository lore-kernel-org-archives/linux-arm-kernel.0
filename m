From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 14 Mar 2014 12:47:28 +0100
Subject: [RFC PATCH V3 3/6] arm: mm: implement get_user_pages_fast
In-Reply-To: <20140312171126.GK27965@twins.programming.kicks-ass.net>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
 <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
 <20140312163200.GJ27965@twins.programming.kicks-ass.net>
 <20140312165510.GA9950@mudshark.cambridge.arm.com>
 <20140312171126.GK27965@twins.programming.kicks-ass.net>
Message-ID: <20140314114728.GX3104@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 06:11:26PM +0100, Peter Zijlstra wrote:
> Ah this is because you have context tagged TLBs so your context switch
> doesn't locally flush TLBs and therefore you cannot keep track of this?
> 
> Too much x86 in my head I suppose.

Something you could consider is something like:

typdef struct {
	...
+	unsigned long tlb_flush_count;
} mm_context_t;

struct thread_info {
	...
+	unsigned long tlb_flush_count;
};


void flush_tlb*() {
	ACCESS_ONCE(mm->context.tlb_flush_counter)++;

	...
}

void switch_to(prev, next) {
	...

	if (prev->mm != next->mm &&
	    next->mm.context.tlb_flush_counter !=
	    task_thread_info(next)->tlb_flush_counter) {
		task_thread_info(next)->tlb_flush_counter =
			next->mm.context.tlb_flush_counter;
		local_tlb_flush(next->mm);
	}
}

That way you don't have to IPI cpus that don't currently run tasks of
that mm because the next time they get scheduled the switch_to() bit
will flush their mm for you.

And thus you can keep a tight tlb invalidate mask.

Now I'm not at all sure this is beneficial for ARM, just a thought.

Also I suppose one should think about the case where the counter
wrapped. The easy way out there is to unconditionally flush the entire
machine in flush_tlb*() when that happens.
