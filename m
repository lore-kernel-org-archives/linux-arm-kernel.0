From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 Jul 2013 18:21:59 +0100
Subject: [PATCH] ARM: locks: remove opencoded #16 for ticket shift
In-Reply-To: <alpine.LFD.2.03.1307170952580.14924@syhkavp.arg>
References: <1373894879-30559-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307170952580.14924@syhkavp.arg>
Message-ID: <20130718172159.GC9837@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 02:56:59PM +0100, Nicolas Pitre wrote:
> On Mon, 15 Jul 2013, Will Deacon wrote:
> 
> > The ticket width of our spinlocks is defined by TICKET_SHIFT, so remove
> > the opencoded #16 from the trylock implementation.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> This is pointless.

I disagree (see below).

> >  		"	ldrex	%0, [%3]\n"
> >  		"	mov	%2, #0\n"
> > -		"	subs	%1, %0, %0, ror #16\n"
> 
> Any value other than 16 would break that code.  You'd rather ensure it 
> never gets defined to anything else.

There are two aspects to the ticket lock:

  1. The size of each ticket
  2. The location of the next ticket within the 32-bit lock word

TICKET_SHIFT actually defines (2) and could be 0 or 16, hence why I was
making this small cosmetic change. I admit that the naming isn't very good
and I should change the commit message to reflect what's actually going on.

Cheers,

Will
