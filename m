From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 22 Oct 2010 16:41:29 +0800
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <201010220222.36285.marek.vasut@gmail.com>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<201010220222.36285.marek.vasut@gmail.com>
Message-ID: <AANLkTim0yMQbMkP7eke3A18TqwuyFz2DvaYoO8bN7o-9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 22, 2010 at 8:22 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne Po 18. ??jna 2010 19:38:49 Michael Cashwell napsal(a):
>> Greetings,
>>
>> I've been fighting inexplicable hangs on two different PXA270 designs
>> running various kernels since early 2.6.28.x. The first board was custom
>> (and of dubious integrity) but I'm currently seeing it on Gumstix Verdex
>> PROs running 2.6.35.7.
>>
>> At first I thought it was a problem with CPU-freq code itself hitting some
>> unaddressed errata but I've eliminated that possibility. The hangs occur
>> even if CPU-freq is disabled in the kernel config. All that's required in
>> that case is for u-boot to run the kernel at a core frequency of 312MHz or
>> lower. If it runs at 416MHz or higher no hangs occur. (With CPU-freq
>> enabled the hangs only occur if speeds at or below 312MHz are allowed.
>> With those commented out, no hangs.)
>>
>> At low core frequencies I can trigger the hang every time by copying a
>> several-MB file to a uSD card via the MMC interface. The copy command
>> completes but a few seconds later (while the background processes write to
>> the card) the CPU hangs.** However, the issue is not specific to uSD/MMC.
>> Another developer told me he has seen hangs while receiving data through a
>> UART connected via I2C.
>>
>> The hangs are hard (rendering JTAG inoperable) and since I have no hardware
>> with the Embedded Trace Module exposed I have no way to gather a trace of
>> execution up to the freeze.
>>
>> I'd like to solve the problem since the lower speeds are more power
>> efficient but I'm somewhat stuck regarding how to debug it. I'd like to
>> know if it's something I'm doing wrong so my first step is to ask the
>> ARM-Linux community if anyone else has run recent kernels on a PXA270
>> system at core clock rates of 312MHz or less. (That's also a not so veiled
>> plea for someone to perhaps do so if they have the hardware and a few
>> spare cycles.)
>
> Could it be memory-related ? Like, RAM crashes because of refresh speed or
> something?
>
> Cheers
>>
>> Thanks for any information.
>> -Mike
>>
>> **: Here's a hang where I'd just started top while background threads were
>> writing to the uSD card. top did its first pass and then everything froze.
>> (Is the high rate of context switches and interrupts normal?)
>>
>> last pid: ? 389; ?load avg: ?0.13, ?0.05, ?0.01; ?up 0+00:28:15
>> 12:40:22 27 processes: 1 running, 24 sleeping, 2 uninterruptable
>> CPU states: ?0.0% user, ?0.0% nice, 31.1% system, 13.6% idle, 55.3% iowait
>> Kernel: 30832 ctxsw, 16262 intr
>> Memory: 32M used, 92M free, 244K buffers, 27M cached
>> Swap:
>> ?This terminal can only display 16 processes
>> ? PID USERNAME ?THR PRI NICE ?SIZE ? RES ? SHR STATE ? TIME ? ?CPU COMMAND
>> ? 236 root ? ? ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K disk ? ?0:00 28.43% mmcqd
>> ? 389 root ? ? ? ?1 ?20 ? ?0 2696K ?804K ?648K run ? ? 0:00 ?3.92% top
>> ? 378 root ? ? ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K disk ? ?0:00 ?1.96%
>> flush-179:0 1 root ? ? ? ?1 ?20 ? ?0 2784K ?672K ?588K sleep ? 0:00 ?0.00%
>> init 119 root ? ? ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K sleep ? 0:00 ?0.00%
>> rpciod/0 371 root ? ? ? ?1 ?20 ? ?0 4208K 1592K 1340K sleep ? 0:00 ?0.00%
>> sshd 369 root ? ? ? ?1 ?20 ? ?0 2788K ?716K ?632K sleep ? 0:00 ?0.00% ash
>> 4 root ? ? ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K sleep ? 0:00 ?0.00% events/0
>> 128 root ? ? ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K sleep ? 0:00 ?0.00% nfsiod
>> 251 root ? ? ? ?1 ?20 ? ?0 2784K ?460K ?380K sleep ? 0:00 ?0.00% klogd 249
>> root ? ? ? ?1 ?20 ? ?0 2784K ?464K ?396K sleep ? 0:00 ?0.00% syslogd 5
>> root ? ? ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K sleep ? 0:00 ?0.00% khelper 370
>> root ? ? ? ?1 ?20 ? ?0 2784K ?440K ?376K sleep ? 0:00 ?0.00% busybox 103
>> root ? ? ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K sleep ? 0:00 ?0.00% kmmcd 2 root
>> ? ? ? 1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K sleep ? 0:00 ?0.00% kthreadd 3 root
>> ? ?1 ?20 ? ?0 ? ?0K ? ?0K ? ?0K sleep ? 0:00 ?0.00% ksoftirqd/0
>>
>>

Suggest to check errata first. Maybe we need some special code sequence.
