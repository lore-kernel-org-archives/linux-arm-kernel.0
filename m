From: ning.n.jiang@gmail.com (Ning Jiang)
Date: Sat, 30 Mar 2013 19:56:36 +0800
Subject: [PATCH] ARM: timer: Shutdown clock event device when stopping
 local timer
In-Reply-To: <20130330100408.GA17995@n2100.arm.linux.org.uk>
References: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
 <5155DE43.4000601@codeaurora.org>
 <CAH3Oq6QA0DCEDc-Yh+k=3bgUH7xzKxHSC1aWSoL4NzaYCZZHbg@mail.gmail.com>
 <20130330100408.GA17995@n2100.arm.linux.org.uk>
Message-ID: <CAH3Oq6RMWy=+JtPEt7Kpm83wdyyQfzfKSB2+ji2Mforoaar_8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Mar 30, 2013 at 05:57:38PM +0800, Ning Jiang wrote:
>> 2013/3/30 Stephen Boyd <sboyd@codeaurora.org>:
>> > On 03/29/13 02:24, ning.n.jiang at gmail.com wrote:
>> >> From: Ning Jiang <ning.n.jiang@gmail.com>
>> >>
>> >> Currently there are two problems when we try to stop local timer.
>> >> First, it calls set_mode function directly so mode state is not
>> >> updated for the clock event device. Second, it makes the device
>> >> unused instead of shutdown.
>> >
>> > What device is this a problem on? I believe this only matters to drivers
>> > which enable their timer in their set_next_event() callback? But even
>> > then, does anything actually happen because the interrupt should have
>> > been disabled in the local timer stop callback.
>> >
>>
>> Right. Drivers which enable timer in set_next_event() will have this problem.
>> It will not have functional problem in my case. But my device cannot enter
>> low power mode with a pending interrupt even if it is disabled.
>
> You're not telling us what you have discovered.  How does set_next_event()
> get called after we've set the mode to UNUSED in the current code?

In the current code we did not set the mode to UNUSED but only call
set_mode callback function for the clock event device. This normally
disables current clock event device. The dying CPU eventually will
switch to idle thread, call tick_nohz_idle_enter(), try to cancel the
sched_timer and reprogram the next event. Then set_next_event() gets
called. The call stack will be like:

tick_nohz_idle_enter
  -> __tick_nohz_idle_enter
    -> tick_nohz_stop_sched_tick
      -> hrtimer_cancel
        -> hrtimer_try_to_cancel
          -> remove_hrtimer
            -> __remove_hrtimer
              -> hrtimer_force_reprogram
                -> tick_program_event
                  -> clockevents_program_event
                    -> set_next_event

In set_next_event() we'll re-enable and re-program the clock event device.
