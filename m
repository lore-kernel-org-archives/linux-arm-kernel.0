From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Jun 2015 17:42:28 +0100
Subject: [PATCH 09/10] arm64/BUG: Use BRK instruction for generic BUG traps
In-Reply-To: <20150617113518.GE3651@e103592.cambridge.arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
 <1434036566-9848-10-git-send-email-Dave.Martin@arm.com>
 <20150616144810.GE30522@arm.com>
 <20150617113518.GE3651@e103592.cambridge.arm.com>
Message-ID: <20150617164228.GA31594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, Jun 17, 2015 at 12:35:18PM +0100, Dave P Martin wrote:
> On Tue, Jun 16, 2015 at 03:48:10PM +0100, Will Deacon wrote:
> > On Thu, Jun 11, 2015 at 04:29:23PM +0100, Dave P Martin wrote:
> > > diff --git a/arch/arm64/include/asm/brk.h b/arch/arm64/include/asm/brk.h
> > > index 99b8dfb..f4d5894 100644
> > > --- a/arch/arm64/include/asm/brk.h
> > > +++ b/arch/arm64/include/asm/brk.h
> > > @@ -27,5 +27,6 @@
> > >  #define FAULT_BRK_IMM			0x100
> > >  #define KGDB_DYN_DBG_BRK_IMM		0x400
> > >  #define KGDB_COMPILED_DBG_BRK_IMM	0x401
> > > +#define BUG_BRK_IMM			0x7ff
> > 
> > Just curious, but how did you come up with this number?
> 
> There's a comment in debug-monitors.h that the "allowed values for
> kgbd" (sic) are 0x400..0x7ff.
> 
> So 0x7ff seemed unlikely to clash with any other use, and well
> out of the way of the values that kgbd currently uses.
> 
> It's debatable that the BUG value shouldn't be in the range at all.
> However, BUG_BRK_IMM is a contract between the kernel and itself for
> EL1 only, so it can be changed at any time in the future with minimal
> impact.
> 
> What's your view?

I wonder if that kgdb range is inclusive? Maybe best to use 0x800 to be
sure.

> > Could we define is_valid_bugaddr as a macro in the header file and avoid
> > the potential out-of-line call?
> 
> We could, but it would require a change to <linux/bug.h>.  Since
> this is slowpath anyway, I wasn't sure it was worth it.
> 
> Happy to add that and try to push it as part of this series if
> you like -- let me know.

Nah, it's fine. I hadn't spotted the declaration.

Will
