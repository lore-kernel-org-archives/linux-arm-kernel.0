From: ananth@in.ibm.com (Ananth N Mavinakayanahalli)
Date: Thu, 14 May 2015 09:18:35 +0530
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <5553E5BF.2020602@hitachi.com>
References: <553EF74D.8020706@redhat.com> <20150429102346.GK8236@arm.com>
 <55442BFA.50101@redhat.com> <554851CB.2010909@linaro.org>
 <20150505154830.GI1550@arm.com> <55519583.9020507@linaro.org>
 <5551F693.8050100@redhat.com> <555317E8.2000502@hitachi.com>
 <555370B9.2070203@redhat.com> <5553E5BF.2020602@hitachi.com>
Message-ID: <20150514034835.GB29151@in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 09:01:03AM +0900, Masami Hiramatsu wrote:
> On 2015/05/14 0:41, William Cohen wrote:
> > On 05/13/2015 05:22 AM, Masami Hiramatsu wrote:
> >> On 2015/05/12 21:48, William Cohen wrote:
> > 
> >>> Hi Dave,
> >>>
> >>> In some of the previous diagnostic output it looked like things would go wrong
> >>> in the entry.S when the D bit was cleared and the debug interrupts were 
> >>> unmasksed.  I wonder if some of the issue might be due to the starting the 
> >>> kprobe for the trampoline, but leaving things in an odd state when another
> >>> set of krpobe/kretporbes are hit when the trampoline is running.
> >>
> >> Hmm, does this mean we have a trouble if a user kprobe handler calls the
> >> function which is probed by other kprobe? Or, is this just a problem
> >> only for kretprobes?
> > 
> > Hi Masami,
> > 
> > I wrote an example based off of sample/kprobes/kprobes_sample.c to force 
> > the reentry issue for kprobes (the attached kprobe_rentry_example.c). That
> > seemed to run fine.  I think the reason that the trampoline handler got 
> > into trouble is because of the reset_current_kprobe() before the possible
> > call to kfree, but I haven't verified it.
> 
> I still doubt about kfree() reentrant call, since kretprobe handler only
> calls recycle_rp_inst() which doesn't free the instance but just push it back
> to the unused instance list.
> 
> > It seems like that should be at the end of trampoline handler just before
> > the return.  Other architectures have similar trampoline handlers,
> > so I am surprised that the other architectures haven't encountered this
> > issue with kretprobes.  Maybe this is due to specific of arm64 exception
> > handling.
> 
> Ah, indeed the reset_current_kprobe() here seems not good since some
> interruption or some other reason, another kprobes can be hit before
> returning.
> 
> If kprobes can handle reentered probes correctly, I think your patch
> (directly branch from trampoline) looks good to fix this problem.
> Actually, arm32 and x86 already has same method.
> 
> It seems that powerpc will have similar issue, does someone checked
> that? Ananth?

Yes, there is a window where this can happen on powerpc. I haven't
however been able to trigger it thus far -- will try with a different
sample and test.

Thanks for the heads-up.

Ananth
