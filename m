From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Nov 2017 18:05:55 +0000
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <20171116201701.GA143965@samitolvanen.mtv.corp.google.com>
References: <CAKwvOdkV_g0XAbGM+nF2zt=2+tHLLcj=pbSxRDd2HMbrtU3cZg@mail.gmail.com>
 <20171116165922.llrojrvomuihabrt@hirez.programming.kicks-ass.net>
 <CAKwvOd=k=iVQvWmzP1E3XHUCYLoJgx+F9zoPuE+R2oaw_ePUVA@mail.gmail.com>
 <20171116173417.nqsh5dpu65uj7b5s@hirez.programming.kicks-ass.net>
 <20171116174830.GX3624@linux.vnet.ibm.com>
 <CAKwvOdkDz1yRo=Skt_mWxs0uucK+adXx8kFQksMbTE3ofnpUMQ@mail.gmail.com>
 <20171116183950.GA3624@linux.vnet.ibm.com>
 <20171116184508.GC21898@arm.com>
 <20171116191307.GC3624@linux.vnet.ibm.com>
 <20171116201701.GA143965@samitolvanen.mtv.corp.google.com>
Message-ID: <20171120180554.GM32488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sami,

On Thu, Nov 16, 2017 at 12:17:01PM -0800, Sami Tolvanen wrote:
> On Thu, Nov 16, 2017 at 11:13:07AM -0800, Paul E. McKenney wrote:
> > Ah, if "this patch set" meant "adding LTO", I stand corrected and I
> > apologize for my confusion.
> 
> Again, I'm not proposing for LTO to be enabled by default. These patches
> just make it possible to enable it. Are you saying the possibility
> that a future compiler update breaks something is a blocker even for
> experimental features?

My opinion here is that it's a blocker for LTO on arm64, as the symptoms
aren't different to building with a compiler that has subtle code generation
issues. If you *really* want to support LTO, we could consider giving
acquire semantics to READ_ONCE for LTO builds, but that means trading
RCU read-side performance for whatever gains are provided by LTO.

Please don't confuse this with a reluctance to support clang; I'm keen to
see that supported, so let's focus on that for the moment (although I don't
see a good reason to support old clang builds with known issues).

> > I agree that we need LTO/PGO to be housebroken from an LKMM viewpoint
> > before it is enabled.
> 
> Can you elaborate what's needed from clang before this can move
> forward? For example, if you have specific test cases in mind, we can
> always work on including them in the LLVM test suite.

This is a thorny issue, but RCU (specifically rcu_dereference but probably
also some READ_ONCEs) relies on being able to utilise syntactic dependency
chains to order local accesses to shared variables. Paul has spent a
fair amount of time working to define these dependency chains here:

  https://wg21.link/P0190

Although the current direction of the C++ committee is to prefer
that dependencies are explicitly "marked", this is not deemed to be
acceptable for the kernel (in other words, everything is always considered
"marked").

If a compiler is capable of breaking unmarked dependency chains, then we
will run into subtle concurrency issues on arm64 because the hardware is
also capable of reordering independent accesses. My understanding is that
LTO makes these sort of optimisations far more likely because whole-program
analysis can enable value prediction, which can convert address dependencies
into control dependcies; the latter not ordering reads on arm64.

Will
