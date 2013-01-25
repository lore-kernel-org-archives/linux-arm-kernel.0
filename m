From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 25 Jan 2013 16:59:34 +0000
Subject: [PATCH 19/19] [INCOMPLETE] ARM: make return_address available
 for ARM_UNWIND
In-Reply-To: <1359132254.21576.230.camel@gandalf.local.home>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-20-git-send-email-arnd@arndb.de>
 <20130125162608.GD2069@linaro.org>
 <1359132254.21576.230.camel@gandalf.local.home>
Message-ID: <20130125165934.GE2069@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 11:44:14AM -0500, Steven Rostedt wrote:
> [ I got an error with linux-arm-kernel at list.infradead.org and had to
> remove from CC ]

Blame Arnd :)

> 
> On Fri, 2013-01-25 at 16:26 +0000, Dave Martin wrote:
> 
> > However, if the purpose if making return_address() notrace is just to
> > prevent infinite recursion, where finite recursion is safe, then it
> > feels fixable as described above.
> > 
> > Steven, do you know whether such an approach might be safe?
> > 
> 
> I rewrote the function trace recursion code (see linux-next). The
> function tracer wont recurse on itself. If the return_address() is only
> used by callbacks and not directly by the mcount(ftrace_caller), then
> after the first trace, ftrace wont let recursion of the callback. IOW,
> callbacks of ftrace don't need to worry about re-entrancy at the same
> context level (but do for different contexts, ie. normal, irq, softirq
> and NMI).
> 
> (commit edc15cafcbfa3d73f819cae99885a2e35e4cbce5 in linux-next and
> friends)

Cool.  Are you aware of return_address being used elsewhere?  Currently
I'm not aware of anything else which uses it, and grep is not finding
any calls outside ftrace.h that I can see.

Cheers
---Dave
