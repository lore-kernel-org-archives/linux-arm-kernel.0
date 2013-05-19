From: rostedt@goodmis.org (Steven Rostedt)
Date: Sun, 19 May 2013 08:34:04 -0400
Subject: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
In-Reply-To: <20130519093526.GD19883@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
Message-ID: <1368966844.6828.111.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-05-19 at 12:35 +0300, Michael S. Tsirkin wrote:

> No, I was not assuming that. What I'm trying to say is that a caller
> that does something like this under a spinlock:
> 	preempt_disable
> 	pagefault_disable
> 	error = copy_to_user
> 	pagefault_enable
> 	preempt_enable_no_resched
> 
> is not doing anything wrong and should not get a warning,
> as long as error is handled correctly later.
> Right?
> 

What I see wrong with the above is the preempt_enable_no_resched(). The
only place that should be ever used is right before a schedule(), as you
don't want to schedule twice (once for the preempt_enable() and then
again for the schedule itself).

Remember, in -rt, a spin lock does not disable preemption.

-- Steve
