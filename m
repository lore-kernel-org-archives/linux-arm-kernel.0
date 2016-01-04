From: john.stultz@linaro.org (John Stultz)
Date: Mon, 4 Jan 2016 09:13:39 -0800
Subject: [tip:timers/core] clocksource: Make clocksource validation work
 for all clocksources
In-Reply-To: <tip-1f45f1f33c8c8b96722dbc5e6b7acf74eaa721f7@git.kernel.org>
References: <56349607.6070708@huawei.com>
 <tip-1f45f1f33c8c8b96722dbc5e6b7acf74eaa721f7@git.kernel.org>
Message-ID: <CANcMJZD4P5qe7HtjsibjD_CNpv+yz=ttDJdpgg=vz3kUN5StOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 7:03 AM, tip-bot for Yang Yingliang
<tipbot@zytor.com> wrote:
> Commit-ID:  1f45f1f33c8c8b96722dbc5e6b7acf74eaa721f7
> Gitweb:     http://git.kernel.org/tip/1f45f1f33c8c8b96722dbc5e6b7acf74eaa721f7
> Author:     Yang Yingliang <yangyingliang@huawei.com>
> AuthorDate: Sat, 31 Oct 2015 18:20:55 +0800
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sat, 19 Dec 2015 15:59:57 +0100
>
> clocksource: Make clocksource validation work for all clocksources
>
> The clocksource validation which makes sure that the newly read value
> is not smaller than the last value only works if the clocksource mask
> is 64bit, i.e. the counter is 64bit wide. But we want to use that
> mechanism also for clocksources which are less than 64bit wide.
>
> So instead of checking whether bit 63 is set, we check whether the
> most significant bit of the clocksource mask is set in the delta
> result. If it is set, we return 0.
>
> [ tglx: Simplified the implementation, added a comment and massaged
>         the commit message ]
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Link: http://lkml.kernel.org/r/56349607.6070708 at huawei.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/timekeeping_internal.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
> index e20466f..5be7627 100644
> --- a/kernel/time/timekeeping_internal.h
> +++ b/kernel/time/timekeeping_internal.h
> @@ -17,7 +17,11 @@ static inline cycle_t clocksource_delta(cycle_t now, cycle_t last, cycle_t mask)
>  {
>         cycle_t ret = (now - last) & mask;
>
> -       return (s64) ret > 0 ? ret : 0;
> +       /*
> +        * Prevent time going backwards by checking the MSB of mask in
> +        * the result. If set, return 0.
> +        */
> +       return ret & ~(mask >> 1) ? 0 : ret;

Hey Thomas, Yang,
   I just noticed this patch, and I'm a little worried that its not
totally safe.  When testing 64bit values, if the msb is set, we know
its negative because no system going to get through more then 63 bits
of cycles between updates.

However, for systems with much shorter masks (ACPI PM for example is
only 24 bits), the MSB of the mask bit being set doesn't necessarily
indicate a invalid negative interval. This patch would possibly cause
time inconsistencies (time going backwards) on those systems.

So if something like this is added, we probably need some additional
smarts to ensure we don't cause problems with quick-wrapping
clocksources with the same fix to try to avoid negative intervals with
unsynced clocksources.

That said, back when we added the TIMEKEEPING_DEBUGGING work, we did
add non-terminal warnings if we saw cycle offsets larger then 50% of
the mask, so the intent of this patch isn't totally off base, but it
seems like leaning heavily on an assumption that isn't quite a hard
design rule of the subsystem (as with a warning, we can continue
working fine, but with this patch we might introduce inconsistencies).

One potential hack that could be tried: If unsynced clocksource has a
long enough interval that we can be sure the MSB being set always
means its an invalid negative interval, you could have the clocksource
shift the read value up by however many bits the mask length is short
of 64 (similarly adjusting the frequency up proportionally), and then
set its mask to all 64 bits. That way negative reads would be caught
by the pre-existing generic logic.

Sorry I didn't see this earlier, I wasn't on the cc list.

thanks
-john
