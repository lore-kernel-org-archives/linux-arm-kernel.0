From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 11 Jul 2011 15:31:30 +0100 (BST)
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <20110711140047.GA346@e102568-lin.cambridge.arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1107111503100.2609@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 11 Jul 2011, Lorenzo Pieralisi wrote:

> On Fri, Jul 08, 2011 at 05:12:22PM +0100, Frank Hofmann wrote:
>> Hi Lorenzo,
>>
>> only a few comments at this stage.
>>
>> The sr_entry.S code is both exclusively .arm (using conditionals and
>> long-distance adr, i.e. not Thumb2-clean), and it uses post-armv5
>> instructions (like wfi). Same for the other *.S code in the patch series.
>> It's non-generic assembly within arch/arch/kernel/, wouldn't one better
>> place this into arch/arm/mm/...-v[67].S ?
>>
>
> Yes, it is certainly something I should improve to make it more generic.
>
>>
>> Then, sr_suspend/sr_resume; these functions are "C-exported" and are
>> directly calling cpu_do_suspend/do_resume to pass a supplied buffer; I've
>> done that for one iteration of the hibernation patch, yes, but that was a
>> bit sneaky and Russell stated then the interface is cpu_suspend/cpu_resume
>> not the proc funcs directly. Unless _those_ have been changed they're also
>> unsafe to call from C funcs (clobber all regs). Couldn't you simply use
>> cpu_suspend/resume directly ?
>>
>
> Well, short answer is no. On SMP we do need to save CPU registers
> but if just one single cpu is shutdown L2 is still on.
> cpu_suspend saves regs on the stack that has to be cleaned from
> L2 before shutting a CPU down which make things more complicated than
> they should. That's why I use cpu_do_{suspend,resume}, so that I can choose
> the memory used to save registers (uncached), but that's an abuse of
> API.

There's the option to use a switch_stack() as Will Deacon has provided via 
his kexec series. Agreed not mainline yet but good for ideas. Will's diff 
is here:

http://www.spinics.net/lists/arm-kernel/msg127951.html

and that one restores the original sp after the "stack switched" function 
returns.

If you use that to switch to a different (uncached) stack before doing 
cpu_suspend (and the 'idle' finisher through that), wouldn't that solve 
the problem ? When the suspend returns, the above would restore your 
cached stackpointer.

> I agree this is sneaky, but I wanted to avoid duplicating code that
> just saves registers. Maybe moving to an uncached stack might solve this
> problem if we want to reuse cpu_suspend from cpu idle, which is still an
> open point.

(me speedtyping above ...) As you say ;-)

>
>> How much memory do all the pagedirs require that are being kept around ?
>> Why does each core need a separate one, what would happen to just use a
>> single "identity table" for all ?
>> I understand you can't use swapper_pg_dir for idle, so a separate one has
>> to be allocated, yet the question remains why per-cpu required ?
>>
>>
>
> I just allocate a 1:1 mapping once cloned from init_mm, reused for all CPUs,
> with an additional mapping.

Have started to wonder whether this facility (a 1:1-mapped pagedir for 
kernel text/data, or maybe even "non-user text/data") could/should be made 
available on a global scale; after all, both kexec, reset, hibernate, some 
forms of idle/suspend do require "some sort of that" to go through MMU 
reinitialization. I'm unfortunately not deep enough in the VM subsystem to 
say how exactly this best would have to look like.

Merely mentioning this because it looks while everyone creates 1:1 
mappings, there's ever so slight differences between how the 1:1 
mapping(s) are created; we've seen:

 	* (re)using current->active_mm->pgd
 	* (re)using swapper_pg_dir (different lengths for the 1:1 section)
 	* using a separately-allocated/initialized pgdir

Such proliferation usually means there's a justified need to do that kind 
of thing. Just the gritty details haven't been sorted how everyone with 
that need could do _the same_ thing instead of reinventing various square 
wheels.

The main reason why I've used swapper_pg_dir in the hibernation patch is 
because it's the only static one in the system (the hibernation hooks are 
in irqs-off codepaths and pgd_alloc isn't a good idea then), and happens 
to have "clear" lower sections (in the user area) so that one's not 
actually substituting anything when creating 1:1 mappings (and getting rid 
of them restores the "pristine" state). But this assumption only holds as 
long as swapper_pg_dir's use isn't changed. So a little creepy feeling 
remains.

A generic "reset_mmu_pg_dir", wouldn't that be a good thing to have ?

> The array of pointers is there to save pgdir on idle entry, one per-cpu.

If you're going through cpu_{do_}suspend/resume, the TTBRs are 
saved/restored anyway, what do you need to keep the virtual addresses 
around for ?


>
>>
>> I'm currently transitioning between jobs; will re-subscribe to arm-kernel
>> under a different email address soon, this one is likely to stop working
>> in August. Sorry the inconvenience and high-latency responses till then :(
>>
>> FrankH.
>
> May I thank you very much for the review in the interim,

You're welcome.
FrankH.

>
> Lorenzo
>
>
