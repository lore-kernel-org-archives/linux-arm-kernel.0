From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 24 Aug 2011 09:42:38 +0800
Subject: [PATCH v2 1/4] ARM: CSR: add rtc i/o bridge interface for
	SiRFprimaII
In-Reply-To: <201108231801.20595.arnd@arndb.de>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-2-git-send-email-Baohua.Song@csr.com>
	<201108231801.20595.arnd@arndb.de>
Message-ID: <CAGsJ_4xos1wVtpBVEtSA3biMqXc=KAiviN7RaL5jP+qF_f5p8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/24 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 23 August 2011, Barry Song wrote:
>> From: Zhiwu Song <zhiwu.song@csr.com>
>>
>> The module is a bridge between the RTC clock domain and the CPU interface
>> clock domain. ARM access the register of SYSRTC, GPSRTC and PWRC through
>> this module.
>>
>> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks basically good now. Aside from the trivial things that Jamie
> already pointed out, there is one more that I noticed:
>
>> +
>> +void __iomem *sirfsoc_rtciobrg_base;
>> +static DEFINE_SPINLOCK(rtciobrg_lock);
>
> sirfsoc_rtciobrg_base should be static as well. No other code can
> properly access it anyway since the lock is static, too.

sirfsoc_rtciobrg_base is accessed by sleep.S too after DRAM enter
self-refresh and deepsleep is executed in cache.

        @ write SLEEPFORCE through rtc iobridge

        str     r1, [r7]
        @ wait rtc io bridge sync


>
> ? ? ? ?Arnd
