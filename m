From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 27 Jul 2011 11:45:21 +0300
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <20110726153930.GG16297@kw.sim.vm.gnt>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
	<1311295758-27493-1-git-send-email-simon@sequanux.org>
	<CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
	<20110726153930.GG16297@kw.sim.vm.gnt>
Message-ID: <CAMAG_ee8YBvDsdQ2zNfn-7qdyTmVYBVb8xykMMv4pg8tEswJgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 6:39 PM, Simon Guinot <simon@sequanux.org> wrote:
> Hi Saeed,
>
> On Tue, Jul 26, 2011 at 05:35:50PM +0300, saeed bishara wrote:
>> On Fri, Jul 22, 2011 at 3:49 AM, Simon Guinot <simon@sequanux.org> wrote:
>> > From: Simon Guinot <sguinot@lacie.com>
>> >
>> > This fixes a regression introduced by e59347a
>> > "arm: orion: Use generic irq chip".
>> >
>> > The same interrupt mask cache (stored within struct irq_chip_generic)
>> > is shared between all the irq_chip_type instances. As each irq_chip_type
>> > can use a distinct mask register, share a single mask cache is not
>> > correct. This bug affects Orion SoCs, which have separate mask registers
>> > for edge and level interrupts.
>> >
>> > This patch move mask_cache from struct irq_chip_generic into struct
>> > irq_chip_type. Note that the interrupt support for Samsung SoCs is also
>> > slightly affected.
>> The patch looks to fix the issue with orion, but it seems that it
>> won't work for SoC with multiple irq_chip_type that use one mask
>> register.
>
> Yes indeed, but does such SoCs exists ? I mean that the only supported
> SoC using multiple irq_chip_type (for now) is Orion.
thats right, but as you code is generic, we should find some way to
fix it or to prevent such devices to use this generic code.
 What is the most
> generic case for edge/level interrupts ? shared or separated mask
> registers ?
orion gpios use separate mask.
>
> If Orion is the specific case, maybe we could provide a dedicated
> irq_mask() handler instead of using the generic one. It would be a
> little sad.
I personally prefer this method, along with getting rid off the
multiple irq_chip_types, my main consideration in this case is
performance.
the irq_gc_mask_clr_bit/irq_gc_ack_set_bit/irq_gc_unmask_enable_reg
are critical since it get called for every (level) interrupt, and it
would be great if you optimize those functions,
I think you better do the following:
1. use pre-calculated offsets instead using  gc->reg_base + cur_regs(d)->ack.
2. put all hot variables (lock, mask/ack/eoi register offset) in the
same cache line if possible.

regards
saeed
