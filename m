From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 10 May 2016 21:40:01 +0200
Subject: [BISECTED] Regression v4.6-rc1 : nanosleep doesn't return on
 AT91SAM9
In-Reply-To: <5731FBE1.2090202@atmel.com>
References: <CACQ1gAg6cKqjaqcV70m2VS5R4_kZEgWTiqzSqDxSjvfrYYxbzg@mail.gmail.com>
 <CACQ1gAipruXcO=xpooYDOdqZbtESD35wxDf7xNrg4zuuRv1wew@mail.gmail.com>
 <20160510164712.56261bb4@bbrezillon>
 <CACQ1gAj4xD1httj=gMKFCfeOnVjSKk+J-y_yZpCkTSiLeTAA4A@mail.gmail.com>
 <5731FBE1.2090202@atmel.com>
Message-ID: <CACQ1gAguZSbqnHQyWHSGSO5tc0zgEPq7QRD8ibgaGU60c4CRMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-05-10 17:18 GMT+02:00 Nicolas Ferre <nicolas.ferre@atmel.com>:
> Le 10/05/2016 16:59, Richard Genoud a ?crit :
>> 2016-05-10 16:47 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
>>> Hi Richard,
>>>
>>> On Tue, 10 May 2016 16:25:25 +0200
>>> Richard Genoud <richard.genoud@gmail.com> wrote:
>>>
>>>> 2016-05-10 15:58 GMT+02:00 Richard Genoud <richard.genoud@gmail.com>:
>>>>> Hi,
>>>>>
>>>>> Starting with 4.6-rc1, a sleep 1 doesn't return :
>>>>>
>>>>> execve("/bin/sleep", ["sleep", "1"], ["USER=root", "SHLVL=1",
>>>>> "OLDPWD=/var", "HOME=/", "TERM=vt102",
>>>>> "PATH=/sbin:/usr/sbin:/bin:/usr/bin", "SHELL=/bin/sh", "PWD=/"]) = 0
>>>>> uname({sysname="Linux", nodename="LNS",
>>>>> release="4.5.0-09406-g46e595a17dcf", version="#72 Tue May 10 15:41:34
>>>>> CEST 2016", machine="armv5tejl", domainname="(none)"}) = 0
>>>>> brk(0)                                  = 0x153000
>>>>> brk(0x153d20)                           = 0x153d20
>>>>> set_tls(0x1534c0, 0x14d1e4, 0, 0x153d20, 0x14e368) = 0
>>>>> readlink("/proc/self/exe", "/bin/busybox", 4096) = 12
>>>>> brk(0x174d20)                           = 0x174d20
>>>>> brk(0x175000)                           = 0x175000
>>>>> getuid32()                              = 0
>>>>> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
>>>>> rt_sigaction(SIGCHLD, NULL, {SIG_DFL, [], 0}, 8) = 0
>>>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>>>> nanosleep({1, 0},
>>>>>
>>>>> And the heartbeat led doesn't blink anymore (full on), as if the
>>>>> timers never fire.
>>>>>
>>>>> The platform is an AT91SAM9G35-CM.
>>>>>
>>>>> git bisect gives a merge as the 1st bad commit :(
>>>>> first bad commit: [46e595a17dcf11404f713845ecb5b06b92a94e43] Merge tag
>>>>> 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>>
>>>>
>>>> I went a little further in tracking that down, starting from the merge
>>>> (1st bad commit) and reverting some commits.
>>>> It seems that the culprit is :
>>>> commit 863a81c3be1d931bdae6426e231add9334311f13
>>>> Author: Boris Brezillon <boris.brezillon@free-electrons.com>
>>>> Date:   Fri Sep 5 09:54:13 2014 +0200
>>>>     clk: at91: make use of syscon to share PMC registers in several drivers
>>>>
>>>> Here are the commits I've reverted :
>>>>
>>>> git log --oneline --decorate -20
>>>> 849cdaa0cf04 (HEAD, tag: good) Revert "clk: at91: make use of syscon
>>>> to share PMC registers in several drivers"
>>>> 4bd6dde95321 (tag: last_bad) Revert "clk: at91: make use of
>>>> syscon/regmap internally"
>>>> a56dacaa24c4 (tag: always_bad) Revert "clk: at91: remove IRQ handling
>>>> and use polling"
>>>> 33edfe7a2de6 Revert "clk: at91: pmc: merge at91_pmc_init in atmel_pmc_probe"
>>>> 0b22bb649eae Revert "clk: at91: pmc: move pmc structures to C file"
>>>> 14994fdff366 Revert "ARM: at91: pm: simply call at91_pm_init"
>>>> 6f0821175327 (tag: still_bad) Revert "ARM: at91: pm: find and remap the pmc"
>>>> b52bbf7fad1b Revert "ARM: at91: pm: move idle functions to pm.c"
>>>> dffb1a5f68b9 Revert "ARM: at91: remove useless includes and function prototypes"
>>>> db352691dcc1 Revert "usb: gadget: atmel: access the PMC using regmap"
>>>> f7b5433dbbc8 Revert "clk: at91: pmc: drop at91_pmc_base"
>>>> 6e6dfc0d91c0 Revert "clk: at91: pmc: remove useless capacities handling"
>>>> ceddd3f88ada Revert "clk: at91: remove useless includes"
>>>> 46e595a17dcf (tag: bad) Merge tag 'armsoc-drivers' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>> e3b1f64e04f5 Merge tag 'armsoc-defconfig' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>> 915c56bc01d6 Merge tag 'armsoc-dt64' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>> 5a6b7e53d035 Merge tag 'armsoc-dt' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>> 8c6d4082fc6a Merge tag 'armsoc-arm64' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>> 33b3d2e88c9e Merge tag 'armsoc-soc' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>> e88fa1b8b00a Merge tag 'armsoc-cleanup' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>>
>>> Thanks for the detailed report.
>>>
>>> Can you try again after applying this patch [1]?
>>>
>>> Regards,
>>>
>>> Boris
>>>
>>> [1]http://code.bulix.org/dx1c0t-98377
>>
>> Yes, it works.
>> Big thumbs up, that was fast !
>>
>> Less than 1 hour between the report and the patch ! :)
>
> Yes, absolutely terrific! Thanks Boris.
>
> I'd like you to test with this instead as it's the real range of the IP:
> + reg = <0xfffffc00 0x110>;
>
> Even I'm pretty confident ;-) Can you please do this for us ?
Unfortunately, I can't test it until Thursday morning.

>> This is clearly 4.6 material (as it's a regression from 4.5), but it's
>> maybe a little late.
>> Anrd, Nicolas, what do you think ?
>
> I sent a PR this morning to Arnd with a "fix"... I hope that he won't be
> annoyed if I send him another one this evening...  But clearly, it's a
> regression and a pretty bad one :-\
>
> Thanks a lot for this report Richard,
