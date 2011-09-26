From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Sep 2011 17:27:35 +0100
Subject: [RFC PATCH 3/3] ARM: mm: add l2x0 suspend/resume support
In-Reply-To: <20110926145503.GM22455@n2100.arm.linux.org.uk>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1317047561-11020-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20110926145503.GM22455@n2100.arm.linux.org.uk>
Message-ID: <20110926162735.GB11647@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 03:55:03PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 26, 2011 at 03:32:41PM +0100, Lorenzo Pieralisi wrote:
> > +	__FINIT
> > +/*
> > + * Function entered with flags set by jump table in l2x0_resume
> > + * If zero flag is set this is a pl310
> > + * r0 = l2x0_data
> > + * r1 = L2 address
> > + */
> > +resume_l210:
> ...
> > +	.data
> > +	.align
> > +ENTRY(l2x0_resume)
> ...
> > +	b 	resume_l210
> > +ENDPROC(l2x0_restore_context)
>
> This is not a good idea - jumping from the data segment into the text
> segment.  We place initrds and initramfs images between the text and
> data segments which can push the branch relocation out of range.
>

Yes, that's easily fixed, I can move the code in the same section.
That is valid also for callers of e.g. cpu_resume as well though, or the
jump must be an absolute one, because it is the same code pattern, but
from text to data.

Lorenzo
