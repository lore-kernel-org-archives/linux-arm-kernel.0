From: andre.przywara@linaro.org (Andre Przywara)
Date: Fri, 19 Apr 2013 14:58:57 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAEDV+g+3nkdvbLdj0m-ZdDKt0JY2vgzhP2AQA2nf=R3h4yTQmQ@mail.gmail.com>
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
 <20130415134837.GI9827@mudshark.cambridge.arm.com>
 <CAEDV+gJB7Bj9O7pftFqoYQ=goORjdurBnEfQVmC5arDuNJfpBg@mail.gmail.com>
 <32d532438f5b621e40679aea9f5888c7@localhost> <516E586C.5030407@linaro.org>
 <8e0bda3fd84d1b0c5aa55161ca178a8e@localhost>
 <CAEDV+g+3nkdvbLdj0m-ZdDKt0JY2vgzhP2AQA2nf=R3h4yTQmQ@mail.gmail.com>
Message-ID: <51713F91.5080102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2013 11:12 AM, Christoffer Dall wrote:
>
>
>
> On Wed, Apr 17, 2013 at 1:16 AM, Marc Zyngier <marc.zyngier@arm.com
> <mailto:marc.zyngier@arm.com>> wrote:
>
>     On Wed, 17 Apr 2013 10:08:12 +0200, Andre Przywara
>     <andre.przywara at linaro.org <mailto:andre.przywara@linaro.org>> wrote:
>      > On 04/16/2013 06:33 PM, Marc Zyngier wrote:
>      >> On Tue, 16 Apr 2013 09:26:26 -0700, Christoffer Dall
>      >> <cdall at cs.columbia.edu <mailto:cdall@cs.columbia.edu>> wrote:
>      >>> On Mon, Apr 15, 2013 at 6:48 AM, Will Deacon
>     <will.deacon at arm.com <mailto:will.deacon@arm.com>>
>      >> wrote:
>      >>>> On Mon, Apr 15, 2013 at 02:13:55PM +0100, Andre Przywara wrote:
>      >>>>> On 04/15/2013 11:52 AM, Alexander Spyridakis wrote:
>      >>>>>> I've run on this problem before, while trying to run KVM
>     guests on
>      >> A7
>      >>>>>> cores.
>      >>>>>>
>      >>>>>> For some reason the 3rd A7 hangs in arch/arm/kvm/init.S, on the
>      >>>>>> instruction that updates HSCTLR between the two isbs on
>      >> __do_hyp_init
>      >>>>>> (mcr p15, 4, r0, c1, c0, 0). If you boot the system with
>     maxcpus=4
>      >>>>>> then
>      >>>>>> init_hyp_mode() will not hang on the A7 cluster. Other than that
>      >> from
>      >>>>>> my
>      >>>>>> limited testing KVM on A7 works on a usual linux guest. I also
>     tried
>      >>>>>> to
>      >>>>>> only boot the 3rd A7 core to rule out any racing issues, but
>     still
>      >> the
>      >>>>>> same behaviour applies.
>      >>>>>
>      >>>>> Could well be the same issue here. I chased it down till CPU
>     2 goes
>      >> into
>      >>>>> HYP mode to do the initialization.
>      >>>>> I am running with maxcpus=3 (this increases the likelyhood that
>      >>>>> kvm_target_cpu() runs on an A15), so CPU #2 is the only one A7.
>      >>>>> As the HYP mode exception table is empty except for the HVC
>     trap, it
>      >> may
>      >>>>> be looping here. I am trying now to get the PC of the faulty
>      >>>>> instruction.
>      >>>>
>      >>>> Yes, it sounds like you're taking a recursive fault because the
>     vectors
>      >>>> aren't installed yet. Is there any chance you can find out
>     what value
>      >>>> you end
>      >>>> up writing (or trying to write) to the HSCTLR please?
>      >>>>
>      >>> Actually I'm a little confused, wasn't Andre seeing a halt on
>     an A15
>      >>> cpu, not an A7? Or is the theory that an A7 locks up and the
>     calling
>      >>> A15 hangs on the SMP call to cpu_init_hyp_mode, waiting for the
>     A7 to
>      >>> complete?
>      >>
>      >> Yes, A15 hanging, not A7. That's why I'm strongly opposed to this
>     patch.
>      >> I'm pretty sure the A7s only have a side effect that triggers a
>     kernel
>      >> bug
>      >> on the A15 side. Before taking *any* patch around this, we should
>      >> understand the issue fully, and not start patching random stuff just
>      >> because Linus is going to tag 3.9.
>      >
>      > I think there is a misunderstanding. The RCU watchdog was complaining
>      > because the A15 wasn't making any progress. As Christoffer said,
>     this is
>
>      > because it was waiting for CPU 2 to return from the SMP call. It is
>      > actually the A7 hanging inside HYP mode.
>      > I tried some ways to get information out of there, but had no luck so
>      > far. The different mapping between HYP and SVC doesn't make it
>     easy to
>      > dump some variables, but I am still working on it (but only half
>     steam
>
>     You could force a full mapping of the kernel text in HYP. Ugly, but
>     should
>     work.
>
>      > because I am home looking after my sick daughter). So for now I
>     assume
>      > that it is the HSCTLR setting Alexander observed already.
>
>     I'll give it a go today or tomorrow, depending how quickly I can get rid
>     of my backlog after a couple of days off work.
>
>     Assuming this is an A7 handing on HSCTLR access, it should be pretty
>     easy
>     to narrow down by booting only on the A7s, leaving the A15s held in
>     reset.
>
>
> You could also try installing a vector handler early and detect faults,
> and add an alternative return path from the init function with some
> error reporting value in r0 or something like that, just for debugging,
> naturally, but that could be a way to detect if we really are taking
> recursive faults here.

OK, I added code to return earlier on CPUs not from cluster 0.
Indeed it hangs in the HSCR write. The two A15s pass this instruction, 
writing 0x30c5187F into the register.
This means all the fixed bits for A15 correctly, C,A,M and I set and 
WXN, EE, TE cleared. FI was also cleared
The A7 wanted to write the very same value. I tried to set bit 21, which 
kind of the A7 TRM hints to do: but no change.
Before the HSCLTR write, the register reads 0x30c50878, with SCTLR being 
0x30c5387d.
So the code wants to set M, A, C and I in HSCLTR. Interestingly SCTLR 
has the V bits set, could that be an issue?

Regards,
Andre.
