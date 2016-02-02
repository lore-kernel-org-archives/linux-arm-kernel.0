From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 2 Feb 2016 12:51:38 -0500
Subject: [PATCH] recordmcount: arm: Implement make_nop
In-Reply-To: <20160202173141.GB9044@debian>
References: <1454116686-30190-1-git-send-email-sboyd@codeaurora.org>
 <20160130184005.GA29607@debian>
 <20160201194432.GK4848@codeaurora.org>
 <20160202173141.GB9044@debian>
Message-ID: <20160202125138.71606201@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Feb 2016 18:31:41 +0100
Rabin Vincent <rabin@rab.in> wrote:

> On Mon, Feb 01, 2016 at 11:44:32AM -0800, Stephen Boyd wrote:
> > On 01/30, Rabin Vincent wrote:  
> > > For __gnu_mcount_nc, wouldn't it be better to replace both the push {lr}
> > > and the bl with nop instructions, instead of keeping a (useless) push +
> > > pop sequence?  
> > 
> > Agreed. I was trying to do a 1-to-1 copy of the ftrace code on
> > ARM.  I was wondering the same thing in that code path while
> > doing this though. Can't we replace both instructions instead of
> > one instruction when we're patching in nops at runtime?  
> 
> As Steven pointed out the last time this came up, we can't do it safely
> at runtime:
> 
> https://marc.info/?l=linux-arm-kernel&m=132517584531389&w=2

There is actually a way to do it, but it requires break points.

	push lr
	call mcount

Now add a break point:

	brk
	call mcount

Anything that hits the breakpoint, have it return after the call to
mcount.

Sync all CPUs where tasks have either hit the breakpoint and is
skipping the mcount regardless, or has already done the push lr and
is calling mcount. To be even more paranoid, you could add a step to:

	brk
	brk

and if the second brkpoint is hit, then call mcount to make sure it
does the necessary step with lr. Again sync the CPUS (which is simply
just sending an IPI to all of them).

Once the breakpoints are in place, you can convert them over to nops.

	brk
	nop

and then to

	nop
	nop

-- Steve
