From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 15 Jan 2013 08:32:21 -0800
Subject: [PATCH v2] hardlockup: detect hard lockups without NMIs using
 secondary cpus
In-Reply-To: <CAFTL4hzYkPCmkfqBafkTA5E_snkLoC_y3p9xwumj=L1xWAWK0g@mail.gmail.com>
References: <1357941108-14138-1-git-send-email-ccross@android.com>
 <CAFTL4hzYkPCmkfqBafkTA5E_snkLoC_y3p9xwumj=L1xWAWK0g@mail.gmail.com>
Message-ID: <20130115163221.GN3384@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 01:13:10AM +0100, Frederic Weisbecker wrote:
> 2013/1/11 Colin Cross <ccross@android.com>:
> > Emulate NMIs on systems where they are not available by using timer
> > interrupts on other cpus.  Each cpu will use its softlockup hrtimer
> > to check that the next cpu is processing hrtimer interrupts by
> > verifying that a counter is increasing.
> >
> > This patch is useful on systems where the hardlockup detector is not
> > available due to a lack of NMIs, for example most ARM SoCs.
> > Without this patch any cpu stuck with interrupts disabled can
> > cause a hardware watchdog reset with no debugging information,
> > but with this patch the kernel can detect the lockup and panic,
> > which can result in useful debugging info.
> >
> > Signed-off-by: Colin Cross <ccross@android.com>
> 
> I believe this is pretty much what the RCU stall detector does
> already: checks for other CPUs being responsive. The only difference
> is on how it checks that. For RCU it's about checking for CPUs
> reporting quiescent states when requested to do so. In your case it's
> about ensuring the hrtimer interrupt is well handled.
> 
> One thing you can do is to enqueue an RCU callback (cal_rcu()) every
> minute so you can force other CPUs to report quiescent states
> periodically and thus check for lockups.

This would work in all but one case, and that is where RCU believes
that the non-responsive CPU is in dyntick-idle mode.  In that case,
RCU would not be expecting it to respond and would therefore ignore
any non-responsiveness.

> Now you'll face the same problem in the end: if you don't have NMIs,
> you won't have a very useful report.

Indeed, I must confess that I have thus far chickened out on solving
the general NMI problem.  The RCU stall detector does try to look at
stacks remotely in some cases, but this is often unreliable, and some
architectures seem to refuse to produce a remote stack trace.

							Thanx, Paul
