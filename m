From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 06 Mar 2015 19:02:10 +0000
Subject: [PATCH 4.0-rc1 v17 5/6] x86/nmi: Use common printk functions
In-Reply-To: <20150305194653.GA17436@gmail.com>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-6-git-send-email-daniel.thompson@linaro.org>
 <20150305005424.GA21715@gmail.com> <1425558597.2769.53.camel@linaro.org>
 <20150305194653.GA17436@gmail.com>
Message-ID: <1425668530.2769.82.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-05 at 20:46 +0100, Ingo Molnar wrote:
> * Daniel Thompson <daniel.thompson@linaro.org> wrote:
> 
> > On Thu, 2015-03-05 at 01:54 +0100, Ingo Molnar wrote:
> > > * Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > > 
> > > > Much of the code sitting in arch/x86/kernel/apic/hw_nmi.c to support 
> > > > safe all-cpu backtracing from NMI has been copied to printk.c to 
> > > > make it accessible to other architectures.
> > > > 
> > > > Port the x86 NMI backtrace to the generic code.
> > > 
> > > Is there any difference between the generic and the x86 code as they 
> > > stand today?
> > 
> > Shouldn't be any user observable change but there are some changes,
> > mostly due to review comments.
> > 
> > 1. The seq_buf structures are initialized at boot and *after* they
> >    are consumed (originally they were initialized just before use).
> > 
> > 2. The generic code doesn't maintain an equivalent of backtrace_mask
> >    (which was essentially a copy of cpus_online made when backtracing
> >    was requested) and instead iterates using for_each_possible_cpu()
> >    to initialize and dump the seq_buf:s.
> 
> Ok, I have no fundamental objections:
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> I suspect you want to carry the x86 bits yourself?

I've done plenty of bisectability testing on this set so patches 4 and 5
could be separated from the set and go via the x86 tree. However with
your ack I hope that taking the patchset via the irqchip route should be
possible.

Jason: After I've attended to Joe Perches/Steven Rostedt's comments will
you be comfortable enough to take patches 1-5 through one of your
trees? 

It would be great to deliver patch 6 too but rmk is having a short break
so getting an ack for that may not work out


Daniel.
