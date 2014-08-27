From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Aug 2014 17:51:59 +0100
Subject: [PATCH 3/6] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <20140827164714.GF13850@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-4-git-send-email-punit.agrawal@arm.com>
 <20140826131339.GO23445@arm.com>
 <CAKv+Gu8Nji0Jspk2cMCwVGKeODsiOb0NFUFWucm3rAbNdb_bTQ@mail.gmail.com>
 <20140826143011.GV23445@arm.com> <20140827164714.GF13850@arm.com>
Message-ID: <20140827165159.GD17601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 05:47:14PM +0100, Catalin Marinas wrote:
> On Tue, Aug 26, 2014 at 03:30:11PM +0100, Will Deacon wrote:
> > On Tue, Aug 26, 2014 at 03:21:09PM +0100, Ard Biesheuvel wrote:
> > > You need this patch in order to be able to return from an undef
> > > exception taken in EL1:
> > > 
> > > --- a/arch/arm64/kernel/entry.S
> > > +++ b/arch/arm64/kernel/entry.S
> > > @@ -287,7 +287,9 @@ el1_undef:
> > >          */
> > >         enable_dbg
> > >         mov     x0, sp
> > > -       b       do_undefinstr
> > > +       bl      do_undefinstr
> > > +
> > > +       kernel_exit 1
> > >  el1_dbg:
> > >         /*
> > >          * Debug exception handling
> > 
> > Hmm, I'm surprised we don't already need something like this for KGDB...
> 
> We don't expect undef exceptions at EL1, so far they are fatal as we
> don't have any hooks for them. Doesn't KGDB use dedicated breakpoint
> instructions?

Ah yeah, we use magic immediates in the BRK instruction. I was getting
confused with arch/arm/, where we actually use an undefined encoding for
the same thing. That explains why things appear to be working!

Will
