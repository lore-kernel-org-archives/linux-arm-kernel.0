From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 4 Mar 2013 16:44:54 +0100
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <5134AF7E.5010605@keymile.com>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
 <1311295758-27493-1-git-send-email-simon@sequanux.org>
 <CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
 <20110726153930.GG16297@kw.sim.vm.gnt>
 <CAMAG_ee8YBvDsdQ2zNfn-7qdyTmVYBVb8xykMMv4pg8tEswJgg@mail.gmail.com>
 <5134AF7E.5010605@keymile.com>
Message-ID: <20130304154454.GG21620@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 03:28:14PM +0100, Gerlando Falauto wrote:
> Hi everyone,
> 
> I know this issue is from two years ago...
> 
> On 07/27/2011 10:45 AM, saeed bishara wrote:
> >On Tue, Jul 26, 2011 at 6:39 PM, Simon Guinot <simon@sequanux.org> wrote:
> >>Hi Saeed,
> >>
> >>On Tue, Jul 26, 2011 at 05:35:50PM +0300, saeed bishara wrote:
> >>>On Fri, Jul 22, 2011 at 3:49 AM, Simon Guinot <simon@sequanux.org> wrote:
> >>>>From: Simon Guinot <sguinot@lacie.com>
> >>>>
> >>>>This fixes a regression introduced by e59347a
> >>>>"arm: orion: Use generic irq chip".
> >>>>
> >>>>The same interrupt mask cache (stored within struct irq_chip_generic)
> >>>>is shared between all the irq_chip_type instances. As each irq_chip_type
> >>>>can use a distinct mask register, share a single mask cache is not
> >>>>correct. This bug affects Orion SoCs, which have separate mask registers
> >>>>for edge and level interrupts.
> >>>>
> >>>>This patch move mask_cache from struct irq_chip_generic into struct
> >>>>irq_chip_type. Note that the interrupt support for Samsung SoCs is also
> >>>>slightly affected.
> >>>The patch looks to fix the issue with orion, but it seems that it
> >>>won't work for SoC with multiple irq_chip_type that use one mask
> >>>register.
> >>
> >>Yes indeed, but does such SoCs exists ? I mean that the only supported
> >>SoC using multiple irq_chip_type (for now) is Orion.
> >thats right, but as you code is generic, we should find some way to
> >fix it or to prevent such devices to use this generic code.
> >  What is the most
> >>generic case for edge/level interrupts ? shared or separated mask
> >>registers ?
> >orion gpios use separate mask.
> >>
> >>If Orion is the specific case, maybe we could provide a dedicated
> >>irq_mask() handler instead of using the generic one. It would be a
> >>little sad.
> >I personally prefer this method, along with getting rid off the
> >multiple irq_chip_types, my main consideration in this case is
> >performance.
> >the irq_gc_mask_clr_bit/irq_gc_ack_set_bit/irq_gc_unmask_enable_reg
> >are critical since it get called for every (level) interrupt, and it
> >would be great if you optimize those functions,
> >I think you better do the following:
> >1. use pre-calculated offsets instead using  gc->reg_base + cur_regs(d)->ack.
> >2. put all hot variables (lock, mask/ack/eoi register offset) in the
> >same cache line if possible.
> >
> >regards
> >saeed
> 
> I ran into the same problem (currently running 3.0.40)... but it
> looks like this patch was never applied anywhere.
> I also quickly scanned the log between now and then and could not
> find any reference to this problem. Was a fix ever committed or we
> still have this regression?

Hi Gerlando,

AFAIK this issue is still here. I include the current Orion maintainers
in the Cc list.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130304/0fabd282/attachment-0001.sig>
