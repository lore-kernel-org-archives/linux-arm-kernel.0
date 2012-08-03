From: minggr@gmail.com (Lin Ming)
Date: Fri, 3 Aug 2012 09:23:30 +0800
Subject: How to debug hard lockup issue
In-Reply-To: <CAJe_ZhezzWUOUNXx=nUx8BqTwcyy6C0Cq7FcNcSg-i0Q9otOKA@mail.gmail.com>
References: <CAF1ivSY=HsqrRypru55cYMBoyY75umkwrjbz5U0F85nL5mh3tw@mail.gmail.com>
 <20120802071530.GG10670@pengutronix.de>
 <CAF1ivSZ=mHqPOks9vdWhb--gKduWpM6UM77-mMj=1gAf8P6MUA@mail.gmail.com>
 <20120802083413.GH10670@pengutronix.de>
 <CAF1ivSbbPtr0F3dWPXZMcWrzubGCg4mudcLQ1DKHe_HX5HqQbg@mail.gmail.com>
 <CAJe_ZhezzWUOUNXx=nUx8BqTwcyy6C0Cq7FcNcSg-i0Q9otOKA@mail.gmail.com>
Message-ID: <CAF1ivSbEqrgJPFt-9d+hAnfVW3tjG1PC92H-qcGYnJA2wN7d9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 2, 2012 at 5:40 PM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 2 August 2012 15:00, Lin Ming <minggr@gmail.com> wrote:
>> On Thu, Aug 2, 2012 at 4:34 PM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>>> On Thu, Aug 02, 2012 at 03:59:36PM +0800, Lin Ming wrote:
>>>> On Thu, Aug 2, 2012 at 3:15 PM, Uwe Kleine-K?nig
>>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>> > Hello,
>>>> >
>>>> > On Thu, Aug 02, 2012 at 11:03:31AM +0800, Lin Ming wrote:
>>>> >> I encountered a hard lockup on a armv5 board with 2.6.32 kernel.
>>>> >> There is no any message output since it is hard lockup.
>>>> >>
>>>> >> I tried watchdog, but watchdog can only reset the board. I still can't
>>>> >> get any info.
>>>> >>
>>>> >> The hard lockup is possibly because kernel blocked/looped with
>>>> >> interrupts disabled.
>>>> >>
>>>> >> Is there any non-maskable interrupt I can use to dump the kernel stack?
>>>> >> Or any other hint?
>>>> > Try enabling various debug options. The following come to (my) mind:
>>>> >
>>>> > CONFIG_DETECT_HUNG_TASK
>>>> > CONFIG_PROVE_LOCKING
>>>> > CONFIG_DEBUG_ATOMIC_SLEEP
>>>> > CONFIG_MAGIC_SYSRQ
>>>>
>>>> These debug options are already enabled.
>>>> But it doesn't help.
>>> then if you don't have a hardware debugger handy you can try
>>>
>>>         https://lkml.org/lkml/2012/5/26/83
>>
>> Will try pstore and PostMortem.
>>
> If the hang is after bootup, pstore is a better option. If the hang is
> consistent and during boot, dumping __log_buf is the only option.

It's after bootup.

After running about 1 day, the system is hard lockup.
That's possibly because kernel blocked/looped with interrupts
disabled(local_irq_disable).

So soft lockup detector won't help because timer interrupt(and all
other maskable interrupts) was disabled.
And unfortunately, armv5 seems don't support hard lockup detector.
Hard lockup detector needs non-maskable interrupt.

I'm going to try pstore to get the last function call when hard lockup happens.

Thanks,
Lin Ming
