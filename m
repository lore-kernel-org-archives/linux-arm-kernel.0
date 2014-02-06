From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:49:52 +0000
Subject: [PATCH 2/6] arm64: barriers: make use of barrier options with
 explicit barriers
In-Reply-To: <20140206114559.GM26035@mudshark.cambridge.arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-2-git-send-email-will.deacon@arm.com>
 <20140206114130.GJ29446@arm.com>
 <20140206114559.GM26035@mudshark.cambridge.arm.com>
Message-ID: <20140206114952.GL29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 11:45:59AM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2014 at 11:41:30AM +0000, Catalin Marinas wrote:
> > On Thu, Feb 06, 2014 at 11:30:49AM +0000, Will Deacon wrote:
> > > --- a/arch/arm64/include/asm/barrier.h
> > > +++ b/arch/arm64/include/asm/barrier.h
> > > @@ -20,14 +20,14 @@
> > >  
> > >  #ifndef __ASSEMBLY__
> > >  
> > > -#define sev()		asm volatile("sev" : : : "memory")
> > > +#define sev(l)		asm volatile("sev" #l : : : "memory")
> > 
> > Would we actually ever use sev(l) form C? And it's a new instruction
> > rather than an argument to the existing sev.
> 
> I don't know, but if it's not there then I'm pretty sure people will always
> use sev, even if sevl could be used. In fact, sev and sevl are both aliases
> of hint, so they're the same instruction with different immediate operands.

SEVL was pretty much introduced to avoid a branch in the spinlock
functions. I'm not aware of other uses (on arm64 we don't even use the
wfe() macro directly). I would skip this for now.

-- 
Catalin
