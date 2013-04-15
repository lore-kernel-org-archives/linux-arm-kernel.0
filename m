From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Apr 2013 11:45:42 +0100
Subject: [PATCH v2] arm64: Fix task tracing
In-Reply-To: <20130415101159.GA25095@localhost.cambridge.arm.com>
References: <20130408153132.GQ17476@mudshark.cambridge.arm.com>
 <1365510814-21343-1-git-send-email-cov@codeaurora.org>
 <20130415101159.GA25095@localhost.cambridge.arm.com>
Message-ID: <20130415104542.GE9827@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 11:11:59AM +0100, Catalin Marinas wrote:
> On Tue, Apr 09, 2013 at 01:33:34PM +0100, Christopher Covington wrote:
> > For accurate accounting pass contextidr_thread_switch the prev
> > task pointer, since cpu_switch_to has at that point changed the
> > the stack pointer.
> > 
> > Signed-off-by: Christopher Covington <cov@codeaurora.org>
> > ---
> >  arch/arm64/kernel/process.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 0337cdb..a49b25a 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -315,7 +315,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
> >  	/* the actual thread switch */
> >  	last = cpu_switch_to(prev, next);
> >  
> > -	contextidr_thread_switch(next);
> > +	contextidr_thread_switch(prev);
> 
> The original code was indeed wrong but using prev isn't any better. For
> a newly created thread, prev is probably 0 (if it's in a register,
> cpu_context has been zeroed by copy_thread()) or some random stack
> value.

Really? If prev is NULL in context_switch(...), the scheduler will implode,
and I can't see where else switch_to is called from.

Which code path are you thinking of?

Will
