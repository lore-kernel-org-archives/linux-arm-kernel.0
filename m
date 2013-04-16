From: a.spyridakis@virtualopensystems.com (Alexander Spyridakis)
Date: Tue, 16 Apr 2013 20:37:37 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAEDV+g+8iE2_8Z6q7NYRPwKNDDBd8MnEEmB8KjrWwvUdSaxXmg@mail.gmail.com>
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
 <CAEDV+g+8iE2_8Z6q7NYRPwKNDDBd8MnEEmB8KjrWwvUdSaxXmg@mail.gmail.com>
Message-ID: <CAJRNFKJ4ayqup6kSTg_1jeU0cBen1sYoBXLsEzZujndiZ-kE6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2013 17:59, Christoffer Dall <cdall@cs.columbia.edu> wrote:
> On Mon, Apr 15, 2013 at 2:52 AM, Alexander Spyridakis
> <a.spyridakis@virtualopensystems.com> wrote:
>> I've run on this problem before, while trying to run KVM guests on A7 cores.
>>
>> For some reason the 3rd A7 hangs in arch/arm/kvm/init.S, on the instruction
>> that updates HSCTLR between the two isbs on __do_hyp_init (mcr p15, 4, r0,
>> c1, c0, 0). If you boot the system with maxcpus=4 then init_hyp_mode() will
>> not hang on the A7 cluster. Other than that from my limited testing KVM on
>> A7 works on a usual linux guest. I also tried to only boot the 3rd A7 core
>> to rule out any racing issues, but still the same behaviour applies.
>>
> You lost me on the maxcpus=4 and racing point here. If it works with
> maxcpus=4 then it works with two A7s, right? Why would running with
> maxcpus=3 (ie. one A7) rule out any race condition?

maxcpus=3 would still work (only one A7), but I didn't test it that
way. To make sure and avoid any race conditions from other cpus, I
changed the bootwrapper to explicitly boot only the 3rd A7 (rest of
the cpus being in an infinite loop) and it would still hang. Booting
only the 1st or 2nd A7 core by the same method would work as expected
(no hang in __do_hyp_init_).

Regards.
