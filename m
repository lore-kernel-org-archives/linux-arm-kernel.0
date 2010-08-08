From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Aug 2010 23:24:02 +0100
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <alpine.LFD.2.00.1008061256170.28809@xanadu.home>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
	<1278083164.15298.55.camel@ra7055-laptop>
	<20100720211629.GB10553@n2100.arm.linux.org.uk>
	<AANLkTimyif7CCoNwdKMCA=P+y=0e9uhwfhRchbMuB7eY@mail.gmail.com>
	<20100805094521.GB23473@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1008061256170.28809@xanadu.home>
Message-ID: <20100808222402.GF23623@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 06, 2010 at 01:07:46PM -0400, Nicolas Pitre wrote:
> No idea.  That depends how gcc is considering inline asm.  Given there 
> is one input operand, I suppose gcc would account for the delay slot 
> before that operand is actually available.

For something which could very well become by default enabled across
the board - due to the push to have a single kernel binary for lots
of significantly different platforms - it seems little research has
been carried out on this point.

While I agree that other obvious solutions would be more expensive, I
think it makes sense to have the commit which is introducing this
method include a proper evaluation, not least so that people who need
to make the decision to enable this aren't repeating the same research
that someone else has done (or, worse, just decide to enable it 'just
because' without any understanding of what the effect may be.)

So, I'd be interested in hearing whether we do see any preceding ldr
delay slot scheduling for these asm instructions.

I think we also need to consider whether the volatile is really required.
This asm() doesn't have any side effects other than its output operand,
so I suspect that the volatile may get in the way of some optimisations
(such as deleting the operation if the output is not actually used.)
