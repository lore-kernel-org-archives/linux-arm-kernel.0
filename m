From: sjg@chromium.org (Simon Glass)
Date: Tue, 27 Sep 2011 11:29:07 -0700
Subject: [RFC PATCH 0/3] Add accurate boot timing to a Linux system
In-Reply-To: <4E802F7D.9000006@parrot.com>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
	<20110924083203.GZ17169@n2100.arm.linux.org.uk>
	<4E802F7D.9000006@parrot.com>
Message-ID: <CAPnjgZ11uannvUOGSM_FuR9mhSY_yiSGv3vuJtmsMFMgV+Jo0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthieu,

On Mon, Sep 26, 2011 at 12:53 AM, Matthieu CASTET
<matthieu.castet@parrot.com> wrote:
> Hi,
>
> Russell King - ARM Linux a ?crit :
>> On Fri, Sep 23, 2011 at 04:03:15PM -0700, Simon Glass wrote:
>>> An accurate timer is required to make the numbers meaningful. Many
>>> modern platforms have a microsecond timer. This patch set uses a
>>> function called timer_get_us() to read the timer.
>>
>> Not another 'get a time value' function. ?Why do we need soo many?
>> We have - at least:
>>
>> ktime_get (and various flavours of it)
>> do_gettimeofday
>> getnstimeofday
>> sched_clock
>>
>> Do we really need yet another one which will have to be multiplexed
>> amongst platforms, requiring scaling and so forth from whatever the
>> platform provides?
>>
>> Remember that ARM timers are virtually all MMIO mapped, which means
>> they don't work during early kernel bringup when the MMU mappings for
>> the hardware have not been setup. ?(That's the reason stuff like
>> sched_clock for printk doesn't work early.)
> Doesn't cortexA-8 (and A9 ?) have a cycle counter that can be read by
> coprocessor 15 ?
>
> Couldn't we use that counter for early stuff on those architectures ?

Yes we could, but we need to be careful that we use a 'time of day'
counter, not dependent on clock speed, CPU load and the like. See my
other email for what I see as the ideal timer. Obviously this will
have to be architecture-specific, but I hope for a simple fallback to
something available on all architectures, with perhaps the ability to
use better timers available on specific architectures which implement
them.

Regards,
Simon

>
>
> Matthieu
>
