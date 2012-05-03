From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 3 May 2012 04:03:12 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <4FA1F499.8000408@jonmasters.org>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <20120430190015.GV24211@n2100.arm.linux.org.uk>
 <4FA1F499.8000408@jonmasters.org>
Message-ID: <20120503030312.GM6871@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 10:59:37PM -0400, Jon Masters wrote:
> On 04/30/2012 03:00 PM, Russell King - ARM Linux wrote:
> > On Mon, Apr 30, 2012 at 11:07:46AM +0100, Will Deacon wrote:
> >> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> >> index 80abafb..bfcadc0 100644
> >> --- a/arch/arm/kernel/ptrace.c
> >> +++ b/arch/arm/kernel/ptrace.c
> >> @@ -916,14 +916,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
> >>  {
> >>         unsigned long ip;
> >>  
> >> -       /*
> >> -        * Save IP.  IP is used to denote syscall entry/exit:
> >> -        *  IP = 0 -> entry, = 1 -> exit
> >> -        */
> >> -       ip = regs->ARM_ip;
> >> -       regs->ARM_ip = why;
> >> -
> >> -       if (!ip)
> >> +       if (why)
> > 
> > Umm yes, that original code is complete crap, because the old IP value
> > has no meaning what so ever.  The replacement looks much better here.
> 
> Hey Russell,
> 
> So given that Will's replacement works in my investigation, etc. Can you
> pull that please with my reported/tested-by ACK? I think it's a stable
> candidate too. I mean, ok, it won't crash your system unless you have
> audit capability, but it's still a good idea to fix I think.

How about splitting the damn thing into syscall_trace_enter() and
syscall_trace_exit(), losing the "why" argument along with all possible
confusion as to which audit hook to call?
