From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 15:23:33 +0000
Subject: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
	<1263220628.6305.44.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
Message-ID: <20100111152333.GB4109@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 08:48:37PM +0530, Shilimkar, Santosh wrote:
> Thanks for cooments !!
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> > Sent: Monday, January 11, 2010 8:07 PM
> > To: Shilimkar, Santosh
> > Cc: linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org;
> > tony at atomide.com; Woodruff, Richard
> > Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
> >
> > Does your secure monitor corrupt r4-r8? Maybe you could add a comment
> > with a few words on this API.
>
> Yes they are corrupted. I will add some comments on the API.
>
> > Do you need to specify "r12" as well? What about "cc", are they
> > preserved by the secure monitor?
>
> r12 and reset of the registers are preserved. Lr needs to be saved but
> because of function call, the compiler saves/restores it.

That's not guaranteed; the compiler can re-use lr for its own purposes
within a function.  You need to add lr to the list of clobbered registers.

> I didn't get your this comment "What about "cc", are they preserved
> by the secure monitor ?  Do you mean rest of the register. If yes then
> the secure monitor don't tamper those registers.

No - Catalin means are the NZCV flags changed by the secure monitor, or
are they preserved?  If they're preserved, you don't need a "cc" clobber.
If they're not preserved, you do.
