From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 May 2014 13:52:16 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140527094749.GE3693@n2100.arm.linux.org.uk>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
Message-ID: <20140527135216.7eaf3b3f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, 27 May 2014 10:47:49 +0100, Russell King - ARM Linux wrote:

> > Absolutely. Just like it is *required* for hardware I/O coherency on
> > Marvell Armada platforms, even those that are non-SMP like Armada
> > 370 or Armada 380.
> 
> What this boils down to is this statement:
> 
> 	If we require hardware coherency between any other master and
> 	a CPU, we require the caches to be in write allocate mode.
> 
> whether "any other master" is another CPU or a device.  So, SMP is
> just a specific case of the general case, and we should treat the
> selection of this as per the generic case.

Right. However, remember that I have to support hardware I/O coherency
on processors for which is_smp() returns false, even when CONFIG_SMP=y
and CONFIG_SMP_ON_UP=y. The Armada 370 is in this case.

> > > You break this by allowing SMP to specify writeback read-allocate.
> > 
> > I am certainly not very familiar with the code in mm/mmu.c, but I'm
> > not sure to see why I allow SMP to specify writeback read-allocate.
> > What the code does is:
> 
> @@ -408,14 +408,14 @@ static void __init build_mem_type_table(void)
>                 if (cachepolicy > CPOLICY_WRITETHROUGH)
>                         cachepolicy = CPOLICY_WRITETHROUGH;
>  #endif
> +               if (cachepolicy > CPOLICY_WRITEBACK)
> +                       cachepolicy = CPOLICY_WRITEBACK;
>         }
> 
> and the rest of this hunk.

If specific hunk is inside a:

	if (cpu_arch < CPU_ARCH_ARMv6) {

and as far as I'm aware, there are no ARMv5 or earlier platforms that
are SMP-capable. Are there any?

> >  * In early_cachepolicy(), if a specific cachepolicy= argument is
> >    passed to the kernel, we use it, except for >= ARMv6, where
> >    CPOLICY_WRITEALLOC is forced.
> 
> What if you want to run ARMv6 UP (non-coherent) in read-allocate mode
> (which is the way it is today?)

That's indeed no longer possible with my patch, but we could allow
that with a default on write-allocate, but a possibility of using
cachepolicy=writeback to get back the previous default cache policy.
Would that work for you?

However, how to verify that cachepolicy=writeback doesn't contradict
the need for write-allocate policy for SMP or hardware I/O coherency?

Again, switching to use write-allocate by default was Catalin and Rob
suggestion. My original suggestion was to make it a per-platform
choice, through flags in machine_desc (see my PATCH RFCv1 at
http://thread.gmane.org/gmane.linux.ports.arm.kernel/325200/).

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
