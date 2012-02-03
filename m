From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 02 Feb 2012 20:16:24 -0500 (EST)
Subject: [PATCH] ARM: cache-v7: Disable preemption when reading CCSIDR
In-Reply-To: <20120203003633.GD14129@n2100.arm.linux.org.uk>
References: <1328210686-15909-1-git-send-email-sboyd@codeaurora.org>
 <20120202204411.GB14129@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1202021632400.2759@xanadu.home>
 <4F2B1E11.1040000@codeaurora.org>
 <20120203003633.GD14129@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1202022010020.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012, Russell King - ARM Linux wrote:

> On Thu, Feb 02, 2012 at 03:36:49PM -0800, Stephen Boyd wrote:
> > On 02/02/12 13:38, Nicolas Pitre wrote:
> > > What about a pair of helpers written in C instead?
> > >
> > > v7_flush_dcache_all() could be renamed, and a wrapper function called 
> > > v7_flush_dcache_all() would call the preemption disable helper, call the 
> > > former v7_flush_dcache_all code, then call the preemption enable helper.
> > >
> > > Then __v7_setup() could still call the core cache flush code without 
> > > issues.
> > 
> > I tried to put the preemption disable/enable right around the place
> > where it was needed. With this approach we would disable preemption
> > during the entire cache flush. I'm not sure if we want to make this
> > function worse for performance, do we? It certainly sounds easier than
> > writing all the preempt macros in assembly though.
> 
> Err, why do you think it's a big task?
> 
> preempt disable is a case of incrementing the thread preempt count, while
> preempt enable is a case of decrementing it, testing for zero, if zero,
> then checking whether TIF_NEED_RESCHED is set and calling a function.

Oh certainly.  And we already do just that in a few places already.  I 
re-read your previous email to realize that I initially misread your 
remark about the ickness of explicitly calling the scheduler.

> If that's too much, then the simple method in assembly to quickly disable
> preemption over a very few set of instructions is using mrs/msr and cpsid i.
> That'll be far cheaper than fiddling about with preempt counters or
> messing about with veneers in C code.

Indeed.  And I think that would be plenty sufficient here as the 
protected region is really short.  I don't think that warrants any 
macros.


Nicolas
