From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 11 Jul 2011 15:00:47 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
Message-ID: <20110711140047.GA346@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 05:12:22PM +0100, Frank Hofmann wrote:
> Hi Lorenzo,
> 
> only a few comments at this stage.
> 
> The sr_entry.S code is both exclusively .arm (using conditionals and
> long-distance adr, i.e. not Thumb2-clean), and it uses post-armv5
> instructions (like wfi). Same for the other *.S code in the patch series.
> It's non-generic assembly within arch/arch/kernel/, wouldn't one better
> place this into arch/arm/mm/...-v[67].S ?
> 

Yes, it is certainly something I should improve to make it more generic.

> 
> Then, sr_suspend/sr_resume; these functions are "C-exported" and are
> directly calling cpu_do_suspend/do_resume to pass a supplied buffer; I've
> done that for one iteration of the hibernation patch, yes, but that was a
> bit sneaky and Russell stated then the interface is cpu_suspend/cpu_resume
> not the proc funcs directly. Unless _those_ have been changed they're also
> unsafe to call from C funcs (clobber all regs). Couldn't you simply use
> cpu_suspend/resume directly ?
> 

Well, short answer is no. On SMP we do need to save CPU registers 
but if just one single cpu is shutdown L2 is still on. 
cpu_suspend saves regs on the stack that has to be cleaned from
L2 before shutting a CPU down which make things more complicated than
they should. That's why I use cpu_do_{suspend,resume}, so that I can choose
the memory used to save registers (uncached), but that's an abuse of
API.
I agree this is sneaky, but I wanted to avoid duplicating code that
just saves registers. Maybe moving to an uncached stack might solve this
problem if we want to reuse cpu_suspend from cpu idle, which is still an
open point.

> How much memory do all the pagedirs require that are being kept around ?
> Why does each core need a separate one, what would happen to just use a
> single "identity table" for all ?
> I understand you can't use swapper_pg_dir for idle, so a separate one has
> to be allocated, yet the question remains why per-cpu required ?
> 
> 

I just allocate a 1:1 mapping once cloned from init_mm, reused for all CPUs,
with an additional mapping.
The array of pointers is there to save pgdir on idle entry, one per-cpu.

> 
> I'm currently transitioning between jobs; will re-subscribe to arm-kernel
> under a different email address soon, this one is likely to stop working
> in August. Sorry the inconvenience and high-latency responses till then :(
> 
> FrankH.

May I thank you very much for the review in the interim,

Lorenzo
