From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Sep 2016 11:33:26 +0100
Subject: [RFC PATCH 2/8] thread_info: allow custom in-task thread_info
In-Reply-To: <CALCETrWni0aZ71r-R6oYG98kZvZA8a184UR0YURk_=tXu8HXMw@mail.gmail.com>
References: <1473947349-14521-1-git-send-email-mark.rutland@arm.com>
 <1473947349-14521-3-git-send-email-mark.rutland@arm.com>
 <CALCETrWni0aZ71r-R6oYG98kZvZA8a184UR0YURk_=tXu8HXMw@mail.gmail.com>
Message-ID: <20160916103101.GA21702@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 11:37:47AM -0700, Andy Lutomirski wrote:
> On Thu, Sep 15, 2016 at 6:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Currently, task_struct is defined in <linux/sched.h>, which (indirectly)
> > pulls in a number of low-level arch headers such as <asm/preempt.h>
> > through a number of other headers. Thus, code and structures in these
> > headers can't rely on the definition of task_struct. Some of these
> > headers are necessary for the definition of task_struct, so moving
> > task_struct into its own header is insufficient tio avoid circular
> > includes.
> 
> The flippant answer is to fix the headers, but I tried that myself and
> gave up :(

Agreed; likewise (though I gave up quicker, I suspect). :(

Longer-term I'd still hope that we can do this.

> But how about this slightly less duplicative alternative:
> 
> struct thread_info {
> #ifdef arch_thread_info
>   struct arch_thread_info arch_ti;
> #endif
> };

I'm happy to have an arch_thread_info.

Just to check, what do you mean to happen with the flags field? Should
that always be in the generic thread_info? e.g.

struct thread_info {
	u32 flags;
#ifdef arch_thread_info
	struct arch_thread_info arch_ti;
#endif
};

Thanks,
Mark,
