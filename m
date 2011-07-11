From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 11 Jul 2011 19:05:47 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <alpine.DEB.2.00.1107111746480.2609@localhost6.localdomain6>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1107111503100.2609@localhost6.localdomain6>
	<20110711160246.GA1161@e102568-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1107111746480.2609@localhost6.localdomain6>
Message-ID: <20110711180545.GA3451@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 05:57:29PM +0100, Frank Hofmann wrote:
> On Mon, 11 Jul 2011, Lorenzo Pieralisi wrote:
> 
> [ ... ]
> >>> The array of pointers is there to save pgdir on idle entry, one per-cpu.
> >>
> >> If you're going through cpu_{do_}suspend/resume, the TTBRs are
> >> saved/restored anyway, what do you need to keep the virtual addresses
> >> around for ?
> >>
> >
> > Because I switch mm before calling suspend, which is called
> > with a cloned pgdir. I am not sure I can avoid that.
> 
> On resume, you'll be restoring the same thread as was previously running, 
> right ? If so, all you do there is copying current->active_mm->pgd to some 
> other place ?

You are right, I will remove that code unless I can use the saved value
on resume and I cannot rely on current to be retrieved at that point.

> 
> Also, if you'd be using cpu_suspend(), would there still be a need for 
> cpu_switch_mm() before ? It'd rather be a case of possibly calling that 
> before the MMU-off sequence / cpu_resume() ?
> 
> Or is it that you use the new pgdir to make a memory region uncacheable ?

Yes, that's the reason why I switch mm (eg uncacheable memory used to
save registers through cpu_do_suspend and mapped in the cloned pgdir at boot +
some control variables used when MMU is off).

Thanks,
Lorenzo
