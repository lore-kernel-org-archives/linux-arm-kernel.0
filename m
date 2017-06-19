From: rientjes@google.com (David Rientjes)
Date: Mon, 19 Jun 2017 14:42:23 -0700 (PDT)
Subject: [PATCH] compiler, clang: Add always_inline attribute to inline
In-Reply-To: <47bd7df20466d5f7f557ca087b0189cf@codeaurora.org>
References: <20170615155440.GC26471@leverpostej>
 <1497887596-8731-1-git-send-email-psodagud@codeaurora.org>
 <alpine.DEB.2.10.1706191322590.95967@chino.kir.corp.google.com>
 <47bd7df20466d5f7f557ca087b0189cf@codeaurora.org>
Message-ID: <alpine.DEB.2.10.1706191439090.2360@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jun 2017, Sodagudi Prasad wrote:

> > > Commit abb2ea7dfd82 ("compiler, clang: suppress warning for unused
> > > static inline functions") re-defining the 'inline' macro but
> > > __attribute__((always_inline)) is missing. Some compilers may
> > > not honor inline hint if always_iniline attribute not there.
> > > So add always_inline attribute to inline as done by
> > > compiler-gcc.h file.
> > > 
> > 
> > IIUC, __attribute__((always_inline)) was only needed for gcc versions < 4
> > and that the inlining decision making is improved in >= 4.  To make a
> > change like this, I would think that we would need to show that clang is
> > making suboptimal decisions.  I don't think there's a downside to making
> > CONFIG_OPTIMIZE_INLINING specific only to gcc.
> > 
> > If it is shown that __attribute__((always_inline)) is needed for clang as
> > well, this should be done as part of compiler-gcc.h to avoid duplicated
> > code.
> 
> Hi David,
> 
> Here is the discussion about this change -
> https://lkml.org/lkml/2017/6/15/396
> Please check mark and will's comments.
> 

Yes, the arch/arm64/include/asm/cmpxchg.h instance appears to need 
__always_inline as several other functions need __always_inline in 
arch/arm64/include/*.  It's worth making that change as you suggested in 
your original patch.

The concern, however, is inlining all "inline" functions forcefully.  The 
only reason this is done for gcc is because of suboptimal inlining 
decisions in gcc < 4.

So the question is whether this is a single instance that can be fixed 
where clang un-inlining causes problems or whether that instance suggests 
all possible inline usage for clang absolutely requires __always_inline 
due to a suboptimal compiler implementation.  I would suggest the former.
