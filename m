From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 19 Oct 2012 16:58:36 -0700
Subject: [RFC] ARM: sched_clock: update epoch_cyc on resume
In-Reply-To: <CAGsJ_4z_tF3LKy-vygr=kwah7q7U03Y2K2XKAkZTB1QC2pSYmw@mail.gmail.com>
 (Barry Song's message of "Tue, 24 Jul 2012 14:43:28 +0800")
References: <1342567672-29071-1-git-send-email-ccross@android.com>
 <CAGsJ_4z_tF3LKy-vygr=kwah7q7U03Y2K2XKAkZTB1QC2pSYmw@mail.gmail.com>
Message-ID: <87r4ouggk3.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Barry Song <21cnbao@gmail.com> writes:

> 2012/7/18 Colin Cross <ccross@android.com>:
>> Many clocks that are used to provide sched_clock will reset during
>> suspend.  If read_sched_clock returns 0 after suspend, sched_clock will
>> appear to jump forward.  This patch resets cd.epoch_cyc to the current
>> value of read_sched_clock during resume, which causes sched_clock() just
>> after suspend to return the same value as sched_clock() just before
>> suspend.
>>
>> In addition, during the window where epoch_ns has been updated before
>> suspend, but epoch_cyc has not been updated after suspend, it is unknown
>> whether the clock has reset or not, and sched_clock() could return a
>> bogus value.  Add a suspended flag, and return the pre-suspend epoch_ns
>> value during this period.
>
> Acked-by: Barry Song <21cnbao@gmail.com>
>
> this patch should also fix the issue that:
> 1. launch some rt threads, rt threads sleep before suspend
> 2. repeat to suspend/resume
> 3. after resuming, waking up rt threads
>
> repeat 1-3 again and again, sometimes all rt threads will hang after
> resuming due to wrong sched_clock will make sched_rt think rt_time is
> much more than rt_runtime (default 950ms in 1s). then rt threads will
> lost cpu timeslot to run since the 95% threshold is there.

Re-visiting this in light of a related problem.

I've run into a similar issue where IRQ threads are prevented from
running during resume becase the RT throttling kicks because RT
runtime is accumulated during suspend.  Using the 'needs_suspend'
version fixes this problem too.

However, because of the RT throttling issue, it seems like *all*
platforms should be using the 'needs_suspend' version always.  But, as
already pointed out, that makes the timed printk output during
suspend/resume rather unhelpful.

Having to choose between useful printk times during suspend/resume and
functioning IRQ threads during suspend/resume isn't a choice I want to
make.   I'd rather have both.  Any ideas?

Kevin
