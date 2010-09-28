From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 28 Sep 2010 13:51:37 -0400 (EDT)
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <AANLkTinttOaK4COroXBbruXeCyFztLsfdW85XXqTDMJO@mail.gmail.com>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
	<1278083164.15298.55.camel@ra7055-laptop>
	<20100720211629.GB10553@n2100.arm.linux.org.uk>
	<AANLkTimyif7CCoNwdKMCA=P+y=0e9uhwfhRchbMuB7eY@mail.gmail.com>
	<20100805094521.GB23473@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1008061256170.28809@xanadu.home>
	<20100808222402.GF23623@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1008091251460.10330@xanadu.home>
	<AANLkTinttOaK4COroXBbruXeCyFztLsfdW85XXqTDMJO@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1009281339330.1146@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Sep 2010, Eric Miao wrote:

> On Tue, Aug 10, 2010 at 12:55 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Sun, 8 Aug 2010, Russell King - ARM Linux wrote:
> >
> >> On Fri, Aug 06, 2010 at 01:07:46PM -0400, Nicolas Pitre wrote:
> >> > No idea. ?That depends how gcc is considering inline asm. ?Given there
> >> > is one input operand, I suppose gcc would account for the delay slot
> >> > before that operand is actually available.
> >>
> >> For something which could very well become by default enabled across
> >> the board - due to the push to have a single kernel binary for lots
> >> of significantly different platforms - it seems little research has
> >> been carried out on this point.
> >>
> >> While I agree that other obvious solutions would be more expensive, I
> >> think it makes sense to have the commit which is introducing this
> >> method include a proper evaluation, not least so that people who need
> >> to make the decision to enable this aren't repeating the same research
> >> that someone else has done (or, worse, just decide to enable it 'just
> >> because' without any understanding of what the effect may be.)
> >
> > Sure, I agree. ?I'll contact gcc people for a definitive answer.
> >
> 
> Nico, any feedback?

Yes.  As far as scheduling goes, the current gcc implementation simply 
considers any inline assembly as a pipeline flush.  This is not perfect, 
but without the volatile this is still acceptable as demonstrated by 
your comparison example, probably better than dereferencing a global 
variable.  I'll ask the Linaro toolchain group to see if it is 
possible to improve gcc for this, but I suspect the improvement would be 
marginal compared to the current results.

> >> I think we also need to consider whether the volatile is really required.
> >> This asm() doesn't have any side effects other than its output operand,
> >> so I suspect that the volatile may get in the way of some optimisations
> >> (such as deleting the operation if the output is not actually used.)
> >
> > Indeed, the volatile should go. ?This is even getting in the way of
> > better scheduling.
> >
> 
> Yep. I don't see the necessity here for the volatile. Actually after removing
> it, it resulted a better instruction scheduling.

Indeed.  The volatile qualifier for inline assembly is a big hammer 
preventing any code movement around and across them.


Nicolas
