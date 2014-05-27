From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 May 2014 13:59:18 +0200
Subject: [PATCH RFCv2 3/5] ARM: allow CONFIG_SMP_ON_UP on non-SMP
 configurations
In-Reply-To: <20140526163556.GC3693@n2100.arm.linux.org.uk>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526163556.GC3693@n2100.arm.linux.org.uk>
Message-ID: <20140527135918.66a3803f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Mon, 26 May 2014 17:35:56 +0100, Russell King - ARM Linux wrote:

> > Instead of special casing these platforms to enable the SMP and TLB
> > broadcast bit and use shareable pages, this patch proposes to simply
> > allow CONFIG_SMP_ON_UP to be enabled even on non-SMP
> > configurations. When CONFIG_SMP_ON_UP is enabled in a !CONFIG_SMP
> > configuration, it will check that the processor is SMP capable, and
> > if yes use all the SMP characteristics (SMP and TLB broadcast bit,
> > shareable pages, etc.). It will not support multiprocessing of
> > course, but it will have sufficient capabilities to allow hardware
> > I/O coherency to work.
> > 
> > Signed-off-by: Thomas Petazzoni
> > <thomas.petazzoni@free-electrons.com> ---
> > Of course, the name of CONFIG_SMP_ON_UP is maybe no longer
> > appropriate. Suggestions are welcome to change this: this patch is
> > really the minimal set of changes to get things to work.
> > 
> > We could also decide to completely get rid of CONFIG_SMP_ON_UP and
> > make it always on. Suggestions welcome.
> 
> This feels very wrong - while you may need a SCU for coherency, which
> implies that you have a SMP capable CPU,

Actually, this patch is not so much about the SCU, but about having the
SMP bit set in ACTLR and the page table entries having the shareable
attribute. This is needed for Armada XP, Armada 375 and Armada 38x to
provide hardware I/O coherency even when CONFIG_SMP is disabled.

> this feels very much like
> overloading a currently well-defined facility with a well-defined
> purpose (which gets used for a lot of things) with a new purpose,
> which is going to be painful in the future if we ever need to
> separate the two things.  So no, I really don't like this.
> 
> If we need to change things here, make the change properly even if it
> means that it takes more time, and don't do quick sticky-plasters like
> this - the quick sticky-plaster method ultimately makes stuff less
> maintainable.

Sure, but you could give some hints or starting points as to what you
consider the proper way of making such a change?

> Secondly, doesn't this make your first patch redundant - if you need
> the SMP instructions, then is_smp() returns true, which then forces
> WBWA cache mode.

No, because the Armada 370 (single core processor) needs the
write-allocate cache policy to provide hardware I/O coherency, but its
MPIDR does not indicate it's a SMP-capable processor. So even with
CONFIG_SMP_ON_UP=y, is_smp() returns false on Armada 370, and the kernel
continues to use the WB cache mode.

Again, I'm all open to your suggestions on how to make the requirements
of hardware I/O coherency available on !CONFIG_SMP configurations. I've
highlighted very clearly in the cover letter of this patch series what
are these requirements.

Thanks for your feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
