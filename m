From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 21 Sep 2016 17:13:07 +0800
Subject: ftrace function_graph causes system crash
In-Reply-To: <0e38f79fdc1f4671943da74764c15050@SIWEX5A.sing.micron.com>
References: <7d0e88fff8e64591ac31be3adbbf763c@SIWEX5A.sing.micron.com>
 <20160920100716.131d3647@gandalf.local.home>
 <0e38f79fdc1f4671943da74764c15050@SIWEX5A.sing.micron.com>
Message-ID: <20160921171307.3fb84c87@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bean,

On Wed, 21 Sep 2016 07:50:58 +0000 "Bean Huo (beanhuo)"  wrote:

> > From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> > On Behalf Of Steven Rostedt
> > Sent: Dienstag, 20. September 2016 16:07
> > To: Bean Huo (beanhuo) <beanhuo@micron.com>
> > Cc: Zoltan Szubbocsev (zszubbocsev) <zszubbocsev@micron.com>;
> > catalin.marinas at arm.com; will.deacon at arm.com; rfi at lists.rocketboards.org;
> > linux-kernel at vger.kernel.org; mingo at redhat.com; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: ftrace function_graph causes system crash
> > 
> > On Tue, 20 Sep 2016 13:10:39 +0000
> > "Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
> >   
> > > Hi, all
> > > I just use ftrace to do some latency study, found that function_graph
> > > can not Work, as long as enable it, will cause kernel panic. I searched this  
> > online.  
> > > Found that there are also some cause the same as mine. I am a newer of  
> > ftrace.  
> > > I want to know who know what root cause? Here is some partial log:
> > >
> > >  
> > 
> > Can you do a function bisect to find what function this is.
> > 
> > This script is used to help find functions that are being traced by function tracer
> > or function graph tracing that causes the machine to reboot, hang, or crash.
> > Here's the steps to take.
> > 
> > First, determine if function graph is working with a single function:
> > 
> > # cd /sys/kernel/debug/tracing
> > # echo schedule > set_ftrace_filter
> > # echo function_graph > current_tracer
> > 
> > If this works, then we know that something is being traced that shouldn't be.
> > 
> > # echo nop > current_tracer
> > 
> > # cat available_filter_functions > ~/full-file # ftrace-bisect ~/full-file ~/test-file
> > ~/non-test-file # cat ~/test-file > set_ftrace_filter
> > 
> > *** Note *** this will take several minutes. Setting multiple functions is an
> > O(n^2) operation, and we are dealing with thousands of functions.
> > So go have  coffee, talk with your coworkers, read facebook. And eventually,
> > this operation will end.
> > 
> > # echo function_graph > current_tracer
> > 
> > If it crashes, we know that ~/test-file has a bad function.
> > 
> >    Reboot back to test kernel.
> > 
> >    # cd /sys/kernel/debug/tracing
> >    # mv ~/test-file ~/full-file
> > 
> > If it didn't crash.
> > 
> >    # echo nop > current_tracer
> >    # mv ~/non-test-file ~/full-file
> > 
> > Get rid of the other test file from previous run (or save them off somewhere.
> > # rm -f ~/test-file ~/non-test-file
> > 
> > And start again:
> > 
> > # ftrace-bisect ~/full-file ~/test-file ~/non-test-file
> > 
> > The good thing is, because this cuts the number of functions in ~/test-file by half,
> > the cat of it into set_ftrace_filter takes half as long each iteration, so don't talk
> > so much at the water cooler the second time.
> > 
> > Eventually, if you did this correctly, you will get down to the problem function,
> > and all we need to do is to notrace it.
> > 
> > The way to figure out if the problem function is bad, just do:
> > 
> > # echo <problem-function> > set_ftrace_notrace # echo > set_ftrace_filter #
> > echo function_graph > current_tracer
> > 
> > And if it doesn't crash, we are done.
> > 
> > -- Steve  
> 
> 
> Hi, Steve
> Thanks very much! This is a very useful trace tool, I now know the problem function,
> It is gt_counter_read, if not trace this function, ftrace function_graph work well.

I'm not sure whether the commit d6df3576e6b4 ("clocksource/drivers/arm_global_timer
: Prevent ftrace recursion") can fix this issue.

this commit is merged since v4.3, I noticed your kernel version is v4.0

Thanks,
Jisheng

> Do you know now how to deeply debug and trace which line is wrong through Ftrace?
> 
> --Bean
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
