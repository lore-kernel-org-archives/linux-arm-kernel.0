From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Nov 2014 16:25:56 +0100
Subject: [PATCH 1/2] ARM: tegra: irq: fix buggy usage of irq_data irq field
In-Reply-To: <54773A33.2060705@arm.com>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
 <1417024532-5777-2-git-send-email-marc.zyngier@arm.com>
 <20141127082836.GA19323@ulmo> <5476EA0A.7090406@arm.com>
 <20141127120826.GA25222@ulmo> <5477330E.7020404@arm.com>
 <20141127144509.GA27744@ulmo> <54773A33.2060705@arm.com>
Message-ID: <20141127152555.GA20241@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 02:50:27PM +0000, Marc Zyngier wrote:
> On 27/11/14 14:45, Thierry Reding wrote:
[...]
> > Thanks for explaining this in so much detail. That makes perfect sense.
> > On the other hand it means that we'd be breaking DTs in a backwards-
> > incompatibile way, severely. Would there be provision for some sort of
> > fallback to keep existing DTBs working?
> 
> I've been thinking of this, but that's not very nice. The box will
> probably still boot, but suspend will be broken (all interrupts would be
> pointing to the GIC, bypassing the LIC entirely).

Given your description it sounds like suspend will still work, but the
box won't be able to resume. There must be a way to refuse suspend in
those cases. I think that's something we could live with, but not
resuming sounds pretty bad.

> I've been looking at how to patch the FDT at runtime (ideally replacing
> the top-level interrupt-parent), but that doesn't seem to be possible.
> 
> Suggestions?

>From what I remember the gic_arch_extn structure had a flags field that
needs to contain a specific flag to make resume work. Would it be
possible to force that flag if we detect that LIC is not the top-level
interrupt parent?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/3ee0cb6e/attachment.sig>
