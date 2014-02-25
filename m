From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 25 Feb 2014 11:32:51 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140223200208.12998.47604@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140222103840.GH21483@n2100.arm.linux.org.uk>
 <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
 <20140223200208.12998.47604@capellas-linux>
Message-ID: <20140225113251.GB6855@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 08:02:08PM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-22 04:09:10)
> > On Sat, Feb 22, 2014 at 10:38:40AM +0000, Russell King - ARM Linux wrote:
> > > On Wed, Feb 19, 2014 at 04:12:54PM +0000, Lorenzo Pieralisi wrote:
> > > > On Wed, Feb 19, 2014 at 01:52:09AM +0000, Sebastian Capella wrote:
> > > > > +/*
> > > > > + * Snapshot kernel memory and reset the system.
> > > > > + * After resume, the hibernation snapshot is written out.
> > > > > + */
> > > > > +static int notrace __swsusp_arch_save_image(unsigned long unused)
> > > > > +{
> > > > > + int ret;
> > > > > +
> > > > > + ret = swsusp_save();
> > > > > + if (ret == 0)
> > > > > +         soft_restart(virt_to_phys(cpu_resume));
> > > > 
> > > > By the time the suspend finisher (ie this function) is run, the
> > > > processor state has been saved and I think that's all you have to do,
> > > > function can just return after calling swsusp_save(), unless I am missing
> > > > something.
> > > > 
> > > > I do not understand why a soft_restart is required here. On a side note,
> > > > finisher is called with irqs disabled so, since you added a function for
> > > > soft restart noirq, it should be used, if needed, but I have to understand
> > > > why in the first place.
> > > 
> > > It's required because you can't just return from the finisher.  A normal
> > > return from the finisher will always be interpreted as an abort rather
> > > than success (because the state has to be unwound.)
> > > 
> > > This is the only way to get a zero return from cpu_suspend().
> > 
> > Yes, that's the only reason why this code is jumping to cpu_resume, since
> > all it is needed is to snapshot the CPU context and by the time the
> > finisher is called that's done. Wanted to say that soft reboot is not
> > useful (cache flushing and resume with MMU off), but what you are saying
> > is correct. We might be saving swsusp_save return value in a global
> > variable and just return from the finisher, but that's horrible and
> > given the amount of time it takes to snapshot the image to disk the
> > cost of this soft reboot will be dwarfed by that.
> > 
> > I wanted to ask and clarify why the code was written like this though, given
> > its complexity.
> 
> We could also return a constant > 1.  __cpu_suspend code will replace
> a 0 return with 1 for paths exiting suspend, but will not change return
> values != 0.  

Yes, we could but that's an API abuse and as I mentioned that soft_reboot is
not a massive deal, should not block your series. It is certainly
something to be benchmarked though since wiping the entire cache hierarchy
for nothing is not nifty.

> cpu_suspend_abort:
>         ldmia   sp!, {r1 - r3}          @ pop phys pgd, virt SP, phys
> 	resume fn
> 	teq     r0, #0
> 	moveq   r0, #1                  @ force non-zero value
> 	mov     sp, r2
> 	ldmfd   sp!, {r4 - r11, pc}
> 
> We could take advantage of that if we wanted, but Lorenzo pointed out
> also that the relative benefit is very low since the cost of
> resuming is >> soft_restart. 

The cost of writing to disk, to be precise. Again, this should be benchmarked.

> I'll go with leaving the soft_restart as is unless someone feels
> strongly against.

Leaving it as it is is fine for now, but should be commented, because that's
not clear why it is needed by just reading the code.

Thanks,
Lorenzo
