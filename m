From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Wed, 16 Feb 2011 05:39:43 +0100
Subject: Question about ARM function graph tracing
In-Reply-To: <1297821945.23343.136.camel@gandalf.stny.rr.com>
References: <4D4B3D63.4090207@am.sony.com>
	<AANLkTinoFRE2ho9u9yF5nhfgr1gGouHV3anf2OX0mN2T@mail.gmail.com>
	<4D4C61A5.4050403@am.sony.com> <4D5B2AC9.3030502@am.sony.com>
	<1297821945.23343.136.camel@gandalf.stny.rr.com>
Message-ID: <20110216043941.GA21346@nowhere>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 09:05:45PM -0500, Steven Rostedt wrote:
> On Tue, 2011-02-15 at 17:39 -0800, Tim Bird wrote:
> I've had to debug things that broke in the function graph tracer like
> this before. Is dynamic ftrace available in arm?
> 
> Hmm, from arch/arm/Kconfig:
> 
> 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
> 
> 
> I guess so. If you are running something other than this XIP_KERNEL, I
> would suggest using the dynamic functions to binary search the issue.
> 
> cat available_filter_functions > /tmp/funcs
> 
> Then copy half the funcs to /tmp/funcs1 and the other half
> to /tmp/funcs2
> 
> cat /tmp/funcs1 > set_ftrace_filter
> 
> This may take a while, as setting the filter one by one is slow.
> 
> then run the function graph tracer. If it locks up, try it again
> with /tmp/funcs2. If it locks up, you may have two issues or it could be
> something wrong with the function graph tracer itself. But I'm betting
> one will work and one wont.
> 
> Then just keep chopping these funcs files until you get down to a set of
> functions that are causing issues. Then it should point out the problem.
> 
> This is the procedure I used to find out why a kvm guest was locking up
> with function graph tracer.
> 
> See commit:
> 
> 258af47479980d8238a04568b94a4e55aa1cb537
> 
> Something tells me you may have a similar issue ;)


That's a very nice idea to debug ftrace recursions!

As a last resort, in case the binary search doesn't work, you can try:

1) do a local_irq_save() in asm (to avoid possible recursions with common funcs)
2) test recursion, if so, printk_once() the traced func
3) exit recursion
3) local_irq_restore() in asm
