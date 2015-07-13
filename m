From: Dave.Martin@arm.com (Dave P Martin)
Date: Mon, 13 Jul 2015 18:05:35 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG
 traps
In-Reply-To: <20150713165638.GD22840@leverpostej>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
 <20150713164315.GC22840@leverpostej>
 <20150713165151.GC10670@e103592.cambridge.arm.com>
 <20150713165638.GD22840@leverpostej>
Message-ID: <20150713170535.GF22651@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 05:56:39PM +0100, Mark Rutland wrote:
> On Mon, Jul 13, 2015 at 05:51:51PM +0100, Dave P Martin wrote:
> > On Mon, Jul 13, 2015 at 05:43:15PM +0100, Mark Rutland wrote:
> > > Hi,
> > > 
> > > On Mon, Jul 13, 2015 at 02:25:56PM +0100, Dave P Martin wrote:

[...]

> > > > +#ifdef CONFIG_DEBUG_BUGVERBOSE
> > > > +#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
> > > > +#define __BUGVERBOSE_LOCATION(file, line)				\
> > > > +		".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
> > > > +	"2:	.string \"" file "\"\n\t"				\
> > > > +		".popsection\n\t"					\
> > > > +									\
> > > > +		".long 2b - 0b\n\t"					\
> > > > +		".short " #line "\n\t"
> > > > +#else
> > > > +#define _BUGVERBOSE_LOCATION(file, line)
> > > > +#endif
> > > 
> > > Given the reliance on the labels in the caller, I think it might make
> > 
> > Not sure what you mean here, can you elaborate?
> 
> We're relying on label "0:" in the caller/user of the macro when we emit
> ".long 2b - 0b".
> 
> I think it would be clearer if folded into the caller (even with the
> inline ifdef this necessitates).

Ah, I see what you're getting at.  I think there is room for improvement
there.

> Though I could be missing something here that renders that impossible.

Well, you can't put an #ifdef in the middle of a macro definition as
such, but there are other ways around that.  I'll see what I can do.

Cheers
---Dave
