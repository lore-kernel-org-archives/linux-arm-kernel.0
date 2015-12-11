From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 11 Dec 2015 15:13:13 -0500
Subject: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <566AF9BE.7090806@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com> <566A8404.4020507@linaro.org>
 <566AF9BE.7090806@arm.com>
Message-ID: <CAJ5Y-ebgXWsKZWi0L9kjFYQRp1ik2NRfhmm1FEvGXWu2NwP1Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2015 at 11:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 11/12/15 08:06, AKASHI Takahiro wrote:
>> On 12/03/2015 10:58 PM, Marc Zyngier wrote:
>>> On 02/12/15 22:40, Ashwin Chaugule wrote:
>>>> On 24 November 2015 at 17:25, Geoff Levand <geoff@infradead.org> wrote:
>>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>

[..]

>> How about the fixup! patch attached below?
>> The point is that, like Ashwin's first idea, we initialize cpus temporarily
>> before kvm_vgic_hyp_init() and then soon reset cpus again. Thus,
>> kvm cpu hotplug will still continue to work as before.
>> Now that cpu_init_hyp_mode() is revived as exactly the same as Marc's
>> original code, the change will not be a big jump.
>
> This seems quite complicated:
> - init EL2 on  all CPUs
> - do some initialization
> - tear all CPUs EL2 down
> - let KVM drive the vectors being set or not
>
> My questions are: why do we need to do this on *all* cpus? Can't that
> work on a single one?
>
> Also, the simple fact that we were able to get some junk value is a sign
> that something is amiss. I'd expect a splat of some sort, because we now
> have a possibility of doing things in the wrong context.

Yea. I had the same expectation too. Probably some leftover state from
the hyp stub at bootup kept us lucky.

>
>>
>> If kvm_hyp_call() in vgic_v3_probe()/kvm_vgic_hyp_init() is a *problem*,
>> I hope this should work. Actually I confirmed that, with this fixup! patch,
>> we could run a kvm guest and also successfully executed kexec on model w/gic-v3.
>>
>> My only concern is the following kernel message I saw when kexec shut down
>> the kernel:
>> (Please note that I was running one kvm quest (pid=961) here.)
>>
>> ===
>> sh-4.3# ./kexec -d -e
>> kexec version: 15.11.16.11.06-g41e52e2
>> arch_process_options:112: command_line: (null)
>> arch_process_options:114: initrd: (null)
>> arch_process_options:115: dtb: (null)
>> arch_process_options:117: port: 0x0
>> kvm: exiting hardware virtualization
>> kvm [961]: Unsupported exception type: 6248304    <== this message
>
> That makes me feel very uncomfortable. It looks like we've exited a
> guest with some horrible value in X0. How is that even possible?
>
> This deserves to be investigated.

Did this exception trigger as a result of the fixup? For giggles, what
happens if you dont tear down the EL2 setup after reading the number
of LRs? Are we missing another site where we need to setup and
teardown?

Ashwin
