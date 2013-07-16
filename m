From: anup@brainfault.org (Anup Patel)
Date: Tue, 16 Jul 2013 11:20:11 +0530
Subject: [PATCH] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene host
In-Reply-To: <CAFEAcA-0Csn9NuHGKjL1TuNVVnmA0woUvAhuwxTv3r5a+3nMGg@mail.gmail.com>
References: <1373888788-8055-1-git-send-email-anup.patel@linaro.org>
 <51E3ED7A.7050207@arm.com>
 <CAAhSdy25WVnynDyPcOMtqVNEepGGq9WFT3b1PV34P6iSBm-FUg@mail.gmail.com>
 <73A8FA0E-9F7F-4866-9544-57838F30BB91@suse.de>
 <CAAhSdy1tYsdm-2kJzoRfqb-FaPa0-t9x2+=jtMjgFqes+Pco6Q@mail.gmail.com>
 <03C760B4-A395-491C-B589-0689BC2C48BB@suse.de>
 <CAFEAcA-0Csn9NuHGKjL1TuNVVnmA0woUvAhuwxTv3r5a+3nMGg@mail.gmail.com>
Message-ID: <CAAhSdy2=VMUR48x7pYcP_+B9K6LtTfDbvgoyGhos+nzGpWUhcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 9:29 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 15 July 2013 15:21, Alexander Graf <agraf@suse.de> wrote:
>> On 15.07.2013, at 16:04, Anup Patel wrote:
>>> On Mon, Jul 15, 2013 at 6:32 PM, Alexander Graf <agraf@suse.de> wrote:
>>>> Anything that is compatible is compatible :). I don't know
>>>> the product roadmaps for X-Gene cores, but you will want to
>>>> make the field here as coarse grained as possible, while
>>>> maintaining the guarantee that a guest still behaves the same.
>>>
>>> Actually, I don't see X-Gene cores changing in-terms of register
>>> interface available to EL1 and EL0 in near future. This is the
>>> reason why I had named the target as KVM_ARM_TARGET_XGENE_V8.
>>
>> So where does the v8 come from? Is there any non-ARMv8 XGene? If
>> not, this is v1 really, right? What if we just call it v1 instead?
>> Then when a new core comes up that needs different treatment, we
>> create a new target.
>
> I think what we're actually seeing here is that we started with
> a design that specifically said (in the v7 space) "only A15
> on A15", and we're now trying to broaden that out, only we
> haven't actually set out anywhere how that broadening is
> supposed to work (ie what range of hosts will work with
> what range of guests, and how, and whether we want to have
> a "give me a guest CPU that looks like the host CPU" option).
>
> I think the original idea was that userspace would say
> which CPU it wanted, and the kernel would know about that
> CPU (including details like ID and feature registers which
> are going to vary from core to core).
>
> thanks
> -- PMM

I am fine in naming the target as KVM_ARM_TARGET_XGENE_POTENZA.
Selecting this target for given X-Gene host (now and in-future) would mean
that KVM VCPU is X-Gene Potenza compatible. I will send revised patch
for this.

Also, further refining PMM's suggestion, we can have user-space specify
what CPU type it wants and what CPU features it wants. The KVM ARM
or KVM ARM64 will try to give all desired CPU features but it may change
the CPU features based on underlying host CPU features.

IMHO, user-space should be capable of enabling/disabling certain CPU
features of KVM VCPU. Of course, some features like arch_timer would
be mandatory and always available to all VCPU target types.

Regards,
Anup
