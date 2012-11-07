From: bob.beckett@gmail.com (Robert Beckett)
Date: Wed, 7 Nov 2012 17:08:36 +0000
Subject: gic_set_affinity
In-Reply-To: <20121105120548.GH3351@mudshark.cambridge.arm.com>
References: <CAOmFF10StbsQ6WU6J=MFoM87zgD+XpZqQrr2dLsJHPnW0gVang@mail.gmail.com>
 <CAOmFF10ZvpoJ4gaW5WWhzvV4ecxrYJx-kobvNVmaNxBria6Jzg@mail.gmail.com>
 <20121105120548.GH3351@mudshark.cambridge.arm.com>
Message-ID: <CAOmFF10qn=JaNmjpkR3GjZ1dp2MVXqdxT=pdPrbPTijCejf79A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2012 12:05, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Nov 02, 2012 at 11:32:50AM +0000, Robert Beckett wrote:
>> (CC maintainers)
>>
>> On 1 November 2012 17:54, Robert Beckett <bob.beckett@gmail.com> wrote:
>> > Hello,
>> >
>> > I was looking through the arm gic code while debugging a problem I am
>> > having, and noticed something in gic_set_affinity.
>> >
>> > When something comes along and setts an irq affinity mask (e.g.
>> > through /proc/irq/<irq>/smp_affinity_mask), the calls goes like so :
>> >
>> > ...
>> > 1. irq_set_affinity : grabs the desc->lock
>> > 2. __irq_set_affinity_locked : calls chip->irq_set_affinity
>> > 3. gic_set_affinity : writes a new mask to the gic distributor
>> >
>> > my question is, what happens if an interrupt is raised between 1 and 3?
>> > To me, it looks like the interrupt could end up being handled on 2
>> > cpus. When it is raised, the handler will be called and sit spinning
>> > for desc->lock (e.g. in handle_fasteoi_irq). The mask will be set to
>> > set the affinity to the new cpu, the new cpu will receive the
>> > interrupt as it has not been ackd or disabled yet
>
> The interrupt will have been acked in gic_handle_irq before the flow handler
> is invoked, so it will transition to the active state and will not get
> signalled to another CPU. Since we never set more than one target CPU at the
> distributor level, the interrupt will only be forwarded to one CPU interface
> at any given time.
>
> Will

Thanks for the response,

I cant see anything in gic_handle_irq that would ack the interrupt
(unless it is an IPI interrupt).
For irqnr > 15, it just calls handle_IRQ, which would call the desc
handler, which would sit and wait on the desc->lock at the top of
handle_fasteoi_irq.
Which code are you referring to that is meant to ack the interrupt?

Bob
