From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Feb 2016 09:32:17 -0700
Subject: [PATCH] drivers: perf: arm: implement CPU_PM notifier
In-Reply-To: <20160225094417.GB31728@red-moon>
References: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7hsi0hr3wj.fsf@baylibre.com> <20160225094417.GB31728@red-moon>
Message-ID: <CANLsYkzq_oFLZ-ijBtxHp2rU=NR5R1PLb0znv2zPTv=4Z2isGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2016 at 02:44, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Feb 24, 2016 at 05:10:20PM -0800, Kevin Hilman wrote:
>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>>
>> > When a CPU is suspended (either through suspend-to-RAM or CPUidle),
>> > its PMU registers content can be lost, which means that counters
>> > registers values that were initialized on power down entry have to be
>> > reprogrammed on power-up to make sure the counters set-up is preserved
>>
>> This assumes that the PMUs are always sharing a power rail with a
>> specific CPU, not the cluster.  Is that a reliable assumption?
>
> As reliable as assuming the GIC HW state needs save/restore on idle-state
> entry, if we have no power domains information linked to CPU PM
> notifiers saving/restoring everything every time an idle state deeper
> than wfi is entered is the best we can do.
>
> As far as this patch is concerned, if the PMU is on a different power
> domain than the CPU, I agree that stopping/resetting/restoring the
> PMU registers is a waste of cycles (I will test it also by triggering
> the notifiers on wfi, to make sure the reset is not disruptive on
> a cpu that is not powered off), I see no alternative other than disabling
> idle to carry out profiling sanely (or implement CPU PM notifiers with
> runtime PM).

I totally understand - I'm faced with the same problem on Coresight.
To me the ultimate solution is still to integrate CPU power domain
management with runtime PM (like we talked about many times before).
I know Lina is working on something that will get us close to that but
it's not finished yet.

>
> Thanks,
> Lorenzo
