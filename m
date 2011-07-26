From: simon@sequanux.org (Simon Guinot)
Date: Tue, 26 Jul 2011 15:39:31 +0000
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
	<1311295758-27493-1-git-send-email-simon@sequanux.org>
	<CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
Message-ID: <20110726153930.GG16297@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saeed,

On Tue, Jul 26, 2011 at 05:35:50PM +0300, saeed bishara wrote:
> On Fri, Jul 22, 2011 at 3:49 AM, Simon Guinot <simon@sequanux.org> wrote:
> > From: Simon Guinot <sguinot@lacie.com>
> >
> > This fixes a regression introduced by e59347a
> > "arm: orion: Use generic irq chip".
> >
> > The same interrupt mask cache (stored within struct irq_chip_generic)
> > is shared between all the irq_chip_type instances. As each irq_chip_type
> > can use a distinct mask register, share a single mask cache is not
> > correct. This bug affects Orion SoCs, which have separate mask registers
> > for edge and level interrupts.
> >
> > This patch move mask_cache from struct irq_chip_generic into struct
> > irq_chip_type. Note that the interrupt support for Samsung SoCs is also
> > slightly affected.
> The patch looks to fix the issue with orion, but it seems that it
> won't work for SoC with multiple irq_chip_type that use one mask
> register.

Yes indeed, but does such SoCs exists ? I mean that the only supported
SoC using multiple irq_chip_type (for now) is Orion. What is the most
generic case for edge/level interrupts ? shared or separated mask
registers ?

If Orion is the specific case, maybe we could provide a dedicated
irq_mask() handler instead of using the generic one. It would be a
little sad.

Or we could find a way to make coexist this two mask cache policies
(even if I don't see how to do that cleanly) ?
Alternatively, we could allow to bypass this mask cache...

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110726/b92b8b8b/attachment.sig>
