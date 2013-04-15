From: andre.przywara@linaro.org (Andre Przywara)
Date: Mon, 15 Apr 2013 15:13:55 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAJRNFKJoBzgt4UhxsH65_LyhcGXPnzB_pg3q-zeYT2OVv59q4A@mail.gmail.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
 <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
 <516BCAD0.9000708@linaro.org>
 <CAJRNFKJoBzgt4UhxsH65_LyhcGXPnzB_pg3q-zeYT2OVv59q4A@mail.gmail.com>
Message-ID: <516BFD13.1000400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 11:52 AM, Alexander Spyridakis wrote:
> On 15 April 2013 11:39, Andre Przywara <andre.przywara@linaro.org
> <mailto:andre.przywara@linaro.org>> wrote:
>
>      > [Q: does
>      >     all the hyp mode code have to also run on the A15s or
>      >     is it A7-safe?]
>
>     Good point. It seems like the code hangs in init_hyp_mode().
>     Will do more debugging in there now.
>
>
> I've run on this problem before, while trying to run KVM guests on A7 cores.
>
> For some reason the 3rd A7 hangs in arch/arm/kvm/init.S, on the
> instruction that updates HSCTLR between the two isbs on __do_hyp_init
> (mcr p15, 4, r0, c1, c0, 0). If you boot the system with maxcpus=4 then
> init_hyp_mode() will not hang on the A7 cluster. Other than that from my
> limited testing KVM on A7 works on a usual linux guest. I also tried to
> only boot the 3rd A7 core to rule out any racing issues, but still the
> same behaviour applies.

Could well be the same issue here. I chased it down till CPU 2 goes into 
HYP mode to do the initialization.
I am running with maxcpus=3 (this increases the likelyhood that 
kvm_target_cpu() runs on an A15), so CPU #2 is the only one A7.
As the HYP mode exception table is empty except for the HVC trap, it may 
be looping here. I am trying now to get the PC of the faulty instruction.


(on a TC2: 0-1: A15, 2-4: A7)
kvm_target_cpu() on CPU #1, part is c0f0
kvm [1]: entering init_hyp_mode on CPU 1
kvm [1]: kvm_mmu_init() returned 0 on CPU 1
kvm [1]: hyp_get_vectors() finished on CPU 1
kvm [1]: allocated stack for HV mode on 5 CPUs, now on CPU 1
kvm [0]: entering cpu_init_hyp_mode(8050fde0) on CPU 0
kvm [0]: c_i_h_m: set vectors finished
kvm [0]: c_i_h_m: initialization of local variables finished
kvm [0]: c_i_h_m: kvm_call_hyp() finished, returning...
kvm [1]: entering cpu_init_hyp_mode(8050fde0) on CPU 1
kvm [1]: c_i_h_m: set vectors finished
kvm [1]: c_i_h_m: initialization of local variables finished
kvm [1]: c_i_h_m: kvm_call_hyp() finished, returning...
kvm [0]: entering cpu_init_hyp_mode(8050fde0) on CPU 2
kvm [0]: c_i_h_m: set vectors finished
kvm [0]: c_i_h_m: initialization of local variables finished


Regards,
Andre.
