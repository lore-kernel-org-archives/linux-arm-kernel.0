From: eranian@googlemail.com (stephane eranian)
Date: Mon, 30 Jan 2012 18:45:19 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120130172438.GC17814@mudshark.cambridge.arm.com>
References: <20120127171009.GL2347@mudshark.cambridge.arm.com>
 <CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
 <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
 <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
 <CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
 <CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
 <CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
 <CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
 <yw1xsjixgolb.fsf@unicorn.mansr.com>
 <CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
 <20120130172438.GC17814@mudshark.cambridge.arm.com>
Message-ID: <CAMsRxfLc-wxx9pELJSdV2DmzGHpVmWOg7SAs=jm-s=5jaNh4HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

There you go, no attachment, not sure the omap list
supports this.

There is something quite interesting to observe.

While I run perf record -e cycles -F 100 noploop 10, I watch
/proc/interrupts. The number of interrupts is way lower than
expected. Therefore the number of samples is way too low:

$ perf record -e cycles -F 100 noploop 10
$ perf report -D | tail -20
cycles stats:
           TOTAL events:        535
            MMAP events:         11
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        520

The delta in /proc/interrupts on CPU1 is 520 interrupts.

So looks like the frequency adjustment which is hooked off of the
timer tick is either not called at each timer tick, the timer ticks are
not at regular interval, or the math is wrong.

If I go with the fixed period mode:
$ perf stat -e cycles noploop 10
noploop for 10 seconds
 Performance counter stats for 'noploop 10':
       10079156960 cycles                    #    0.000 GHz
      10.004547117 seconds time elapsed

That means, if I want 100 samples/sec: = 10079156960/(10*100)=10079157
$ perf record -e cycles -c 10079157 noploop 10
$ perf report -D | tail -20
cycles stats:
           TOTAL events:       1003
            MMAP events:         11
            COMM events:          2
            EXIT events:          2
        THROTTLE events:          1
      UNTHROTTLE events:          1
          SAMPLE events:        986

Now, we're getting the right answer!

So with the right sampling period, everything works fine.
We need to elucidate what's going on in perf_event_task_tick().
I have tried with my throttling fix and it did not help. We are
not subject to throttling with such a low rate.

noploop.c:

#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <inttypes.h>
#include <unistd.h>

void handler(int sig)
{
	exit(0);
}

void
noploop(void)
{
	for(;;);
}

int
main(int argc, char **argv)
{
	unsigned int delay;
	delay = argc > 1 ? atoi(argv[1]) : 1;
	signal(SIGALRM, handler);
	printf("noploop for %d seconds\n", delay);
	alarm(delay);
	noploop();
	return 0;
}

On Mon, Jan 30, 2012 at 6:24 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jan 30, 2012 at 05:15:53PM +0000, stephane eranian wrote:
>> Still need to investigate why the frequency mode does
>> not yield the correct number of samples even with low frequency.
>>
>>
>> $ taskset -c 1 perf record -e cycles -F 100 noploop 10
>> $ perf report -D | tail -20
>> Aggregated stats:
>> ? ? ? ? ? ?TOTAL events: ? ? ? ?475
>> ? ? ? ? ? ? MMAP events: ? ? ? ? 11
>> ? ? ? ? ? ? COMM events: ? ? ? ? ?2
>> ? ? ? ? ? ? EXIT events: ? ? ? ? ?2
>> ? ? ? ? ? SAMPLE events: ? ? ? ?460
>> cycles stats:
>> ? ? ? ? ? ?TOTAL events: ? ? ? ?475
>> ? ? ? ? ? ? MMAP events: ? ? ? ? 11
>> ? ? ? ? ? ? COMM events: ? ? ? ? ?2
>> ? ? ? ? ? ? EXIT events: ? ? ? ? ?2
>> ? ? ? ? ? SAMPLE events: ? ? ? ?460
>>
>> 460 samples is way too low. Should be 100x10 = 1000 samples or close to it.
>
> Can you stick noploop.c somewhere (I'm lazy :) and I'll try it on one of my
> A9 boards?
>
> Thanks,
>
> Will
