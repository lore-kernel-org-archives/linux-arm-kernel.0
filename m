From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 11 Jul 2011 17:02:46 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <alpine.DEB.2.00.1107111503100.2609@localhost6.localdomain6>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1107111503100.2609@localhost6.localdomain6>
Message-ID: <20110711160246.GA1161@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 03:31:30PM +0100, Frank Hofmann wrote:
> 
> 
> On Mon, 11 Jul 2011, Lorenzo Pieralisi wrote:
> 
> > On Fri, Jul 08, 2011 at 05:12:22PM +0100, Frank Hofmann wrote:
> >> Hi Lorenzo,
> >>
> >> only a few comments at this stage.
> >>

[...]

> >> How much memory do all the pagedirs require that are being kept around ?
> >> Why does each core need a separate one, what would happen to just use a
> >> single "identity table" for all ?
> >> I understand you can't use swapper_pg_dir for idle, so a separate one has
> >> to be allocated, yet the question remains why per-cpu required ?
> >>
> >>
> >
> > I just allocate a 1:1 mapping once cloned from init_mm, reused for all CPUs,
> > with an additional mapping.
> 
> Have started to wonder whether this facility (a 1:1-mapped pagedir for 
> kernel text/data, or maybe even "non-user text/data") could/should be made 
> available on a global scale; after all, both kexec, reset, hibernate, some 
> forms of idle/suspend do require "some sort of that" to go through MMU 
> reinitialization. I'm unfortunately not deep enough in the VM subsystem to 
> say how exactly this best would have to look like.
> 
> Merely mentioning this because it looks while everyone creates 1:1 
> mappings, there's ever so slight differences between how the 1:1 
> mapping(s) are created; we've seen:
> 
>  	* (re)using current->active_mm->pgd
>  	* (re)using swapper_pg_dir (different lengths for the 1:1 section)
>  	* using a separately-allocated/initialized pgdir
> 
> Such proliferation usually means there's a justified need to do that kind 
> of thing. Just the gritty details haven't been sorted how everyone with 
> that need could do _the same_ thing instead of reinventing various square 
> wheels.
> 
> The main reason why I've used swapper_pg_dir in the hibernation patch is 
> because it's the only static one in the system (the hibernation hooks are 
> in irqs-off codepaths and pgd_alloc isn't a good idea then), and happens 
> to have "clear" lower sections (in the user area) so that one's not 
> actually substituting anything when creating 1:1 mappings (and getting rid 
> of them restores the "pristine" state). But this assumption only holds as 
> long as swapper_pg_dir's use isn't changed. So a little creepy feeling 
> remains.
> 
> A generic "reset_mmu_pg_dir", wouldn't that be a good thing to have ?
>

It is a fair point, and certainly worth discussing. I will give it
some thought and get back to you.

> > The array of pointers is there to save pgdir on idle entry, one per-cpu.
> 
> If you're going through cpu_{do_}suspend/resume, the TTBRs are 
> saved/restored anyway, what do you need to keep the virtual addresses 
> around for ?
> 

Because I switch mm before calling suspend, which is called
with a cloned pgdir. I am not sure I can avoid that.

> 
> >
> >>
> >> I'm currently transitioning between jobs; will re-subscribe to arm-kernel
> >> under a different email address soon, this one is likely to stop working
> >> in August. Sorry the inconvenience and high-latency responses till then :(
> >>
> >> FrankH.
> >
> > May I thank you very much for the review in the interim,
> 
> You're welcome.
> FrankH.
> 

Thank you,
Lorenzo
