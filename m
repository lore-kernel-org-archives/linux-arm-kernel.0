From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 27 Mar 2013 18:20:28 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <20130327163642.GA1136@localhost.cambridge.arm.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301998.5053.17.camel@laptop>
 <5151BEF2.9090100@linux.intel.com>
 <1364373980.5053.57.camel@laptop>
 <CAKfTPtAox+h0YmpP6W==hJ5FaNzDfF8bQmadmU86MrfnJt67QQ@mail.gmail.com>
 <1364374820.5053.63.camel@laptop>
 <20130327111855.GI801@MacBook-Pro.local>
 <1364393634.5053.71.camel@laptop>
 <20130327163642.GA1136@localhost.cambridge.arm.com>
Message-ID: <CAKfTPtAKTh76-4tVe=ZcEc_hh0J1CaKeU_n3KD3D3Po4T2FMbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2013 17:36, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Mar 27, 2013 at 02:13:54PM +0000, Peter Zijlstra wrote:
>> On Wed, 2013-03-27 at 11:18 +0000, Catalin Marinas wrote:
>> > On Wed, Mar 27, 2013 at 09:00:20AM +0000, Peter Zijlstra wrote:
>> > > On Wed, 2013-03-27 at 09:54 +0100, Vincent Guittot wrote:
>> > > > It's not mandatory to have little cores on low numbers even if it's
>> > > > advised
>> > >
>> > > ARGH!
>> >
>> > I haven't followed this thread closely, so just a random comment from
>> > me. An argument from some is that they want to boot Linux on the big CPU
>> > to be quicker. The most convenient is to have the big CPU at 0.
>>
>> I suppose that's almost sensible ;-) I just despair at the amount of
>> variation that's allowed.
>>
>> I'm guessing that swapping cpus in the bootloader or someplace really
>> early is equally hard in that we (Linux) assume we boot on cpu 0 or
>> something like that?
>
> I think it's worth trying (by changing the CPU topology in the DT). At a
> quick look, I don't see anything hard-coded in the kernel boot sequence.
> It uses smp_processor_id() which translates to
> current_thread_info()->cpu on ARM. I'm not sure how early we need this
> but it's probably after DT parsing, so we could set 'cpu' to a non-zero
> value for the booting processor. There are a few tweaks in the arch/arm
> code code with cpu_logical_map setup (which maps between
> smp_processor_id and the actual hardware CPU id and assumes 0 is the
> booting CPU).

The are few other places in the code that makes the assumption that
the 1st online CPU is the booting CPU like the disable_nonboot_cpus

>
> So if the above works, the scheduler guys can mandate that little CPUs
> are always first and for ARM it would be a matter of getting the right
> CPU topology in the DT (independent of what hw vendors think of CPU
> topology) and booting Linux on CPU 4 etc.
>
> --
> Catalin
