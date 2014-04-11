From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Apr 2014 17:00:29 +0100
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411153249.GZ11096@twins.programming.kicks-ass.net>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153249.GZ11096@twins.programming.kicks-ass.net>
Message-ID: <20140411160028.GR16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 05:32:49PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 11, 2014 at 05:22:07PM +0200, Oleg Nesterov wrote:
> > And I am just curious, why arm's copy_to_user_page() disables premption
> > before memcpy?
> 
> Without looking, I suspect its because the VIVT caches, they need to get
> shot down on every context switch.

So... let's think about that for a moment... if we have a preemption event,
then that's a context switch, which means...

No, this is obviously not the reason, because such an event on a fully
VIVT system would result in the caches being flushed, meaning that we
wouldn't need to do anything if we could be predicably preempted at that
point.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
