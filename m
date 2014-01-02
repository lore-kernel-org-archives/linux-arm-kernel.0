From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 2 Jan 2014 12:43:52 -0800
Subject: v3.13-rc6+ regression (ARM board)
In-Reply-To: <52C5CC54.4050602@linaro.org>
References: <m3mwjhux0e.fsf@t19.piap.pl> <20131231104511.GA9688@1wt.eu>
 <m3txdmu2ez.fsf@t19.piap.pl>
 <20140102101455.GG10158@pengutronix.de>
 <m3ppoatwn1.fsf@t19.piap.pl>
 <CA+55aFyZ0EXYkHd-BhQo6K++qKJVPdGeDbFTVTs3pAPCHFUpOA@mail.gmail.com>
 <52C5C5F6.70803@linaro.org> <52C5CC54.4050602@linaro.org>
Message-ID: <CA+55aFz2dKw5HXy7DV1Aymoscg0MW7Zz28apan8dugUeqTd1QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 12:30 PM, John Stultz <john.stultz@linaro.org> wrote:
>
> So something else may be at play. Even with Linus' patch I reproduced a
> similar hang here.
>
> Still chasing it down, but it looks like a seqlock deadlock where we're
> calling read while holding the lock.

Hmm. Only with lockdep, right?

Does lockdep perhaps read the scheduler clock? Afaik, we have
lockstat_clock(), which uses local_clock(), which in turn translates
to sched_clock_cpu(smp_processor_id())..

So if that code now tries to read the scheduler clock when
update_sched_clock() is doing a update and has done a
write_seqcount_begin()...

    Linus
