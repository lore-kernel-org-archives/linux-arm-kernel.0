From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 10:03:09 +0100
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and
 synchronization
In-Reply-To: <53B1D8AC.7060104@mit.edu>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu>
Message-ID: <20140701090309.GC28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:37:48PM +0100, Andy Lutomirski wrote:
> On 06/22/2014 08:11 PM, Nathan Lynch wrote:
> > Initialize the vdso page list at boot, install the vdso mapping at
> > exec time, and update the data page during timer ticks.  This code is
> > not built if CONFIG_VDSO is not enabled.
> > 
> > Account for the vdso length when randomizing the offset from the
> > stack.  The vdso is placed immediately following the sigpage with a
> > separate install_special_mapping call in arm_install_vdso.

[...]

> > +/* assumes mmap_sem is write-locked */
> > +void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
> > +{
> > +	int ret;
> > +
> > +	mm->context.vdso = ~0UL;
> > +
> > +	if (vdso_pagelist == NULL)
> > +		return;
> > +
> > +	/*
> > +	 * Put vDSO base into mm struct before calling
> > +	 * install_special_mapping so the perf counter mmap tracking
> > +	 * code will recognise it as a vDSO.
> > +	 */
> > +	mm->context.vdso = addr;
> > +
> > +	ret = install_special_mapping(mm, addr, vdso_mapping_len,
> > +				      VM_READ|VM_EXEC|
> > +				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > +				      vdso_pagelist);
> 
> Eek.  You're mapping the shared data VM_MAYWRITE.  This will cause
> bizarre and confusing failures if ptrace pokes at it.

Hmm, but how else can we support software breakpoints on the vdso?

Will
