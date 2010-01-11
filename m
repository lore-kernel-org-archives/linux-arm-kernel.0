From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 16:29:18 +0000
Subject: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do
	notinvalidate clean lines
In-Reply-To: <1263227190.6305.51.camel@pc1117.cambridge.arm.com>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
	<1263220628.6305.44.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
	<20100111152333.GB4109@n2100.arm.linux.org.uk>
	<1263227190.6305.51.camel@pc1117.cambridge.arm.com>
Message-ID: <20100111162918.GA7220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 04:26:30PM +0000, Catalin Marinas wrote:
> On Mon, 2010-01-11 at 15:23 +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 11, 2010 at 08:48:37PM +0530, Shilimkar, Santosh wrote:
> > > > Do you need to specify "r12" as well? What about "cc", are they
> > > > preserved by the secure monitor?
> > >
> > > r12 and reset of the registers are preserved. Lr needs to be saved but
> > > because of function call, the compiler saves/restores it.
> > 
> > That's not guaranteed; the compiler can re-use lr for its own purposes
> > within a function.  You need to add lr to the list of clobbered registers.
> 
> Do we need to specify "r12" in the list of clobbered registers as the
> inline asm explicitly modifies it? Or the compiler doesn't touch it.

Yes - again, the compiler should be told about everything that
potentially could change in an asm statement.

The compiler could decide to inline debug_writel, and use things
like r12 and lr to store temporary values within the parent function
across these calls.
