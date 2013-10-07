From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Oct 2013 10:29:00 +0100
Subject: [PATCH 3/3] KVM: ARM: Add support for Cortex-A7
In-Reply-To: <CA+eFSM2KieXziRFE3s143Huj-bY++fmt__fRSa4JO_=m9B8sNg@mail.gmail.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
 <1380210568-23175-4-git-send-email-jonathan.austin@arm.com>
 <20130926161743.GD1389@cbox>	<52446A48.9070501@arm.com>
 <CA+eFSM1YdhBDMAvyXknMA62Ao3CEntMptdi7RD=NXis1F-BmfQ@mail.gmail.com>
 <CAFEAcA9muNxMtSQHqrByk6Gjw4iWS=vF33T=R42tvAQSTLiAeA@mail.gmail.com>
 <CA+eFSM0k3mA4uOiEvmE_tfVjnpq8DpXV-=nJXhucUDePJRTYXw@mail.gmail.com>
 <52526BDC.3050305@arm.com>
 <CA+eFSM2KieXziRFE3s143Huj-bY++fmt__fRSa4JO_=m9B8sNg@mail.gmail.com>
Message-ID: <52527EDC.4030605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/13 10:17, Gavin Guo wrote:
> On Mon, Oct 7, 2013 at 4:07 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> On 07/10/13 07:16, Gavin Guo wrote:
>>> On Sun, Oct 6, 2013 at 10:56 PM, Peter Maydell <peter.maydell@linaro.org
>>> <mailto:peter.maydell@linaro.org>> wrote:
>>>
>>>     On 6 October 2013 23:03, Gavin Guo <gavin.guo@canonical.com
>>>     <mailto:gavin.guo@canonical.com>> wrote:
>>>     > Does it mean the currently qemu can't support A15 vcpu running on
>>>     host A7?
>>>
>>>     No, that's a kernel restriction. That is why the patch description
>>>     reads:
>>>     # This patch adds support for running Cortex-A7 guests on Cortex-A7
>>>     hosts.
>>>
>>>     (What QEMU is currently missing is A7 support, so you can't ask it to
>>>     run an A7 guest CPU.)
>>>
>>>     -- PMM
>>>
>>>
>>> Thanks, I saw the checking in the kvm_vcpu_set_target(). I'm confused
>>> that what is the concern to run the same cpu type? Does it matter to run
>>> A15 on A7 or inverse?
>>
>> It does. MIDR registers are different. Cache size is different. It may
>> work, or it may not. And at the very least, you should present a
>> consistent view of the underlying system to the unsuspecting OS.
>>
>>         M.
>> --
>> Jazz is not dead. It just smells funny...
>>
> 
> Hi Marc,
> 
> How about the guest os with 4 x A15 vcpus run on a TC2 with 5 cores
> enabled (2 x A15 + 3 x A7). Does it mean that the 4 x A15 vcpus need
> to run on the 2 x A15 real cpus and can't be migrate to the 3 x A7? It

This isn't what I said. If you want to migrate your A15 vcpus to an A7,
you need to make sure that your guest still sees an A15, despite running
on an A7.

> seems that running 4 x A15 vcpus on the 2 x A15 and 2 x A7 core and
> leaving 1 A7 idle can take more computing power if all of the 4 x A15
> guest os vcpus are full of loading. BTW, thanks for your reply,
> according to your reply I know the MIDR and cache size are different.
> Furthermore, I'd like to know if it is possible to make vcpu and real
> cpu in different type? If yes, I would like to study how to modify to
> make it work.

If you want to run KVM in a heterogeneous configuration (big-little
like), you need to be able to dynamically change the trapping of some
CP15 accesses, depending on which physical CPU your vcpu is running on.

So we need an infrastructure to select a HCR/HSTR/HCPTR configuration
based on the vcpu matching the CPU or not. And of course handling the
additional trapping, if necessary.

For A7 vs A15, I'd expect the trapping to be fairly minimal, but until
someone has spent quality time to write the above and work out what
actually needs trapping, KVM on big-little system will stay a pipe dream.

	M.
-- 
Jazz is not dead. It just smells funny...
