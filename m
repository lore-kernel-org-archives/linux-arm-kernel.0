From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Tue, 28 Jun 2016 11:05:50 -0700
Subject: [PATCH v4 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <20160628165941.GS31744@leverpostej>
References: <1466618819-2697-1-git-send-email-ttnguyen@apm.com>
 <1466618819-2697-4-git-send-email-ttnguyen@apm.com>
 <20160623143201.GI8836@leverpostej>
 <CACgAJHyprybnpQuKqvD9rXstQBwoeVG+uGtEBp-pppcfSGMKgQ@mail.gmail.com>
 <20160627160036.GB29321@leverpostej>
 <CACgAJHzM-hzJJDr-HzZyDQ0SUg0PEd5SYKo8YPnRCDCVA9JuJg@mail.gmail.com>
 <20160628111355.GI31744@leverpostej> <577279E2.6070202@arm.com>
 <20160628141400.GN31744@leverpostej>
 <CACgAJHzNe68wDxkk5Uc8M8vHsjL5XoppmPys=37LqBWR5m5zxw@mail.gmail.com>
 <20160628165941.GS31744@leverpostej>
Message-ID: <CACgAJHy+dcDeq_Zr+7kCKKCpXK2qeyXjxuAOQjULdooT3G6RHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Jun 28, 2016 at 9:59 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jun 28, 2016 at 09:39:36AM -0700, Tai Tri Nguyen wrote:
>> Hi Mark,
>>
>> On Tue, Jun 28, 2016 at 7:14 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Jun 28, 2016 at 02:21:38PM +0100, Marc Zyngier wrote:
>> >> On 28/06/16 12:13, Mark Rutland wrote:
>> >> > Marc, is there a sensible way to prevent irq balancers from changing the
>> >> > affinity of an IRQ, e.g. a kernel-side pinning mechanism, or some way we
>> >> > can be notified and reject changes?
>> >>
>> >> You can get notified (see irq_set_affinity_notifier), but there no way
>> >> to veto the change.
>> >
>> > :(
>> >
>> >> What should probably be done is to set the affinity hint
>> >> (irq_set_affinity_hint), and use the notifier to migrate the context
>> >> if possible. Note that you'll be called in process context, which will
>> >> race against interrupts being delivered on the new CPU.
>> >
>> > I'll have to go digging into what exactly perf_pmu_migrate_context
>> > requires. Given the race, I'm not sure if that's going to work. It's
>> > certainly not going to be self contained.
>> >
>> > That also won't work for CPU PMUs, where it makes no sense to migrate
>> > context or IRQs.  For those we appear to already be using have
>> > IRQF_NOBALANCING, which sounds like exactly what we want.
>> >
>> > That appears to influence irq_can_set_affinity(), which the procfs
>> > helpers check.
>> >
>> > Tai, can you try requesting the IRQ with the IRQF_NOBALANCING flag?
>>
>> This seems to work.
>> I also tried to change smp_affinity through procfs and it returns write error.
>> The interrupt seems to be excluded from irq balancing.
>> Should I make the change?
>
> Yes please. I believe you also need IRQF_NO_THREAD per the CPU PMU
> drivers, so please add both flags. I'll do the same for the CCN and CCI
> PMU drivers.

Btw, please skip the v5 I've sent out yesterday. I'll soon send the v6
with this change.

Thanks,
-- 
Tai
