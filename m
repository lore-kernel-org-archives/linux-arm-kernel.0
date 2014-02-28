From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 28 Feb 2014 13:30:48 +0800
Subject: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
In-Reply-To: <CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
 <lel46f$q2d$1@ger.gmane.org>
 <CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
 <CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
 <CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
Message-ID: <CAGsJ_4z=udVOMzFK0TrpFHKHZFOPvYYs0DVrT_1j3KUVsOdspw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-28 11:01 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> 2014-02-27 18:51 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
>> 2014-02-27 3:49 GMT+01:00 Barry Song <21cnbao@gmail.com>:
>>> Hello Romain,
>>>
>>> 2014-02-27 0:19 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
>>>>
>>>> Describing the clocks this way seems limiting to me.
>>>>
>>>> Each output of the PWM controller on SiRFatlasVI and SiRFprimaII can
>>>> independently use one clock among many for signal generation, with
>>>> three PLLs and two external clock inputs available.
>>>
>>> yes, that is the hardware spec. and i feel so happy you have read it.
>>> now i get one more sirfsoc friend.
>>>
>>> 32K of RTC is too small to generate a normal PWM signal, PLLs in the
>>> design can change for DVFS.
>>> so that means a notifier callback is needed if PLL is changed for
>>> CPUFreq, this makes SW buggy and complex.
>>>
>> Well, my specific concern was the use of the bypass mode on the 32kHz
>> clock. As the PWM driver is also the interface for external clock distribution,
>> and 32 kHz is a common requirement for external devices, I wish to avoid
>> compounding error rates. I will get a less precise clock if I divide the 26 MHz
>> instead.
>
> Hi Romain,
>
> do you have a real user scenarios for this 32KHz? as the 1st step, i
> want a clean and general enough pwm driver, if there is any special
> requirement, i want to execute a "demanding page" when the "page
> fault" happened as this will make the whole flow more smooth. that
> means we make it lazy by incremental patches. but if you do want to
> use it for the moment, it is a "page fault" now. so we can have it
> immediately and it is better you can help to double-test :-)

Huayi told me bluetooth/wifi is using 32768. if we bypass rtc
directly, it is better.
currently the 26MHz can be divided to 32K, but i agree with you that
bypassing rtc is better.

-barry
