From: sjg@chromium.org (Simon Glass)
Date: Sat, 24 Sep 2011 07:06:47 -0700
Subject: [RFC PATCH 0/3] Add accurate boot timing to a Linux system
In-Reply-To: <20110924083203.GZ17169@n2100.arm.linux.org.uk>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
	<20110924083203.GZ17169@n2100.arm.linux.org.uk>
Message-ID: <CAPnjgZ0yt2VGUHB+deb4BQ_dto8Jd+W8mxw7PjNYO9oiqEObuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Sep 24, 2011 at 1:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 23, 2011 at 04:03:15PM -0700, Simon Glass wrote:
>> An accurate timer is required to make the numbers meaningful. Many
>> modern platforms have a microsecond timer. This patch set uses a
>> function called timer_get_us() to read the timer.
>
> Not another 'get a time value' function. ?Why do we need soo many?
> We have - at least:
>
> ktime_get (and various flavours of it)
> do_gettimeofday
> getnstimeofday
> sched_clock
>
> Do we really need yet another one which will have to be multiplexed
> amongst platforms, requiring scaling and so forth from whatever the
> platform provides?

No we don't need another! It is just a convenience for this RFC since
the actual timer mechanism is not clear and not important for this
RFC. Insert your favourite timer mechanism instead.

>
> Remember that ARM timers are virtually all MMIO mapped, which means
> they don't work during early kernel bringup when the MMU mappings for
> the hardware have not been setup. ?(That's the reason stuff like
> sched_clock for printk doesn't work early.) ?That can't be solved by
> creating yet another per-platform method to get microseconds.
>

While it would be useful to measure early things like kernel
decompression, it's hard to make that work cross-platform and there
are other problems like you raise, and where to store timing info.
