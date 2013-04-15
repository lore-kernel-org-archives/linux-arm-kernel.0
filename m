From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Apr 2013 14:48:37 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <516BFD13.1000400@linaro.org>
References: <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
 <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
 <516BCAD0.9000708@linaro.org>
 <CAJRNFKJoBzgt4UhxsH65_LyhcGXPnzB_pg3q-zeYT2OVv59q4A@mail.gmail.com>
 <516BFD13.1000400@linaro.org>
Message-ID: <20130415134837.GI9827@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 02:13:55PM +0100, Andre Przywara wrote:
> On 04/15/2013 11:52 AM, Alexander Spyridakis wrote:
> > I've run on this problem before, while trying to run KVM guests on A7 cores.
> >
> > For some reason the 3rd A7 hangs in arch/arm/kvm/init.S, on the
> > instruction that updates HSCTLR between the two isbs on __do_hyp_init
> > (mcr p15, 4, r0, c1, c0, 0). If you boot the system with maxcpus=4 then
> > init_hyp_mode() will not hang on the A7 cluster. Other than that from my
> > limited testing KVM on A7 works on a usual linux guest. I also tried to
> > only boot the 3rd A7 core to rule out any racing issues, but still the
> > same behaviour applies.
> 
> Could well be the same issue here. I chased it down till CPU 2 goes into 
> HYP mode to do the initialization.
> I am running with maxcpus=3 (this increases the likelyhood that 
> kvm_target_cpu() runs on an A15), so CPU #2 is the only one A7.
> As the HYP mode exception table is empty except for the HVC trap, it may 
> be looping here. I am trying now to get the PC of the faulty instruction.

Yes, it sounds like you're taking a recursive fault because the vectors
aren't installed yet. Is there any chance you can find out what value you end
up writing (or trying to write) to the HSCTLR please?

Will
