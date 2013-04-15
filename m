From: andre.przywara@linaro.org (Andre Przywara)
Date: Mon, 15 Apr 2013 11:39:28 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
 <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
Message-ID: <516BCAD0.9000708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 11:14 AM, Peter Maydell wrote:
> On 15 April 2013 09:54, Christoffer Dall <cdall@cs.columbia.edu> wrote:
>> On Mon, Apr 15, 2013 at 1:43 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> As for the affinity, we can enforce this very easily.
>>>
>> OK, but let's not go down this road until we've verified that this is
>> really an issue that needs to be handled by excluding A7s.  Andre, can
>> you give us some more details?

Sure, I am about to collect some data.

>
> We *must* exclude KVM vcpu threads from ever running on A7s,
> because the cp15 handling code as it stands does not virtualize
> various registers (most notably the ID/feature registers) and
> so the vcpu will bounce between "looks like an A15" and "looks
> like a weird hybrid between A7 and A15".

Can't we propagate some least common denominator or safe values for 
those registers instead of propagating the host ones? Or ignore writes 
to them? Or are there any real showstoppers which I overlooked? Things 
like cache architecture properties could just be set to some basic 
values, right?
On x86 propagating too much of host CPU information has proven to be 
problematic, so for instance cache info is very generic. Things are more 
complicated here, because CPUID is (guest) userland accessible.

Eventually the user/qemu should be able to override this, but as a 
default and for now we should inject one fixed handcrafted CPU 
regardless of the actual host CPU. If A7 is easier in this regards, this 
should be considered, too.

> Assuming we don't want to tackle full big.LITTLE host support
> right now, I can see two options:
>   * forbid KVM completely on a system with any non-A15s
>   * force KVM vcpus to only ever run on the A15s

I thought a bit about this. It is not so easy to accomplish in a sane 
way. The CPU is chosen by the scheduler, actually for the QEMU thread. 
taskset could be of use here, but the affinity could be changed at any 
time by userland. I thought about returning -EINVAL for the KVM_RUN 
ioctl if the CPU is not appropriate, but a) QEMU does not know how to 
handle this properly and b) kvm_arch_vcpu_load currently returns void, 
so we would need to change it for all KVM architectures.
Not sure if its worth to establish this until we fix bL support properly.


> [Q: does
>     all the hyp mode code have to also run on the A15s or
>     is it A7-safe?]

Good point. It seems like the code hangs in init_hyp_mode().
Will do more debugging in there now.

Regards,
Andre.
