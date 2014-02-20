From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Feb 2014 16:27:55 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140219193315.3732.21819@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
Message-ID: <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wed, Feb 19, 2014 at 07:33:15PM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-19 08:12:54)
> > On Wed, Feb 19, 2014 at 01:52:09AM +0000, Sebastian Capella wrote:
> > [...]
> > > diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> > > new file mode 100644
> > > index 0000000..16f406f
> > > --- /dev/null
> > > +++ b/arch/arm/kernel/hibernate.c
> > > +void notrace save_processor_state(void)
> > > +{
> > > +     WARN_ON(num_online_cpus() != 1);
> > > +     flush_thread();
> > 
> > Can you explain to me please why we need to call flush_thread() here ?
> > At this point in time syscore_suspend() was already called and CPU
> > peripheral state saved through CPU PM notifiers.
> 
> Copying Russ' response here: 
> 
> "I think the idea here is to get the CPU into a state so that later
> when we resume from the resume kernel, the actual CPU state matches
> the state we have in kernel. The main thing flush_thread does is clear
> out any and all FP state." - Russ Dill

See my reply to Russ.

[...]

> > > +static void notrace __swsusp_arch_restore_image(void *unused)
> > > +{
> > > +     struct pbe *pbe;
> > > +
> > > +     cpu_switch_mm(idmap_pgd, &init_mm);
> > 
> > Same here, thanks.
> 
> At restore time, we take the save buffer data and restore it to the same
> physical locations used in the previous execution.  This will require having
> write access to all of memory, which may not be generally granted by the
> current mm.  So we switch to 1-1 init_mm to restore memory.

I still do not understand why switching to idmap, which is a clone of
init_mm + 1:1 kernel mappings is required here. Why idmap ?

And while at it, can't the idmap be overwritten _while_ copying back the
resume kernel ? Is it safe to use idmap page tables while copying ?

I had a look at x86 and there idmap page tables used to resume are created
on the fly using safe pages, on ARM idmap is created at boot.

I am grokking the code to understand what is really needed here, will get
back to you asap but I would like things to be clarified in the interim.

Thanks,
Lorenzo
