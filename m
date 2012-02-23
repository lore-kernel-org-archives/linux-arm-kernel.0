From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 23 Feb 2012 08:51:47 +0800
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <87r4xmygb7.fsf@free.fr>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <201202221239.54321.arnd@arndb.de>
 <CAN1soZwgtxR7pNGBQuMHZS0URXM7U6ZABD4disNmvRarZnjwxA@mail.gmail.com>
 <201202221350.00100.arnd@arndb.de>
 <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
 <87r4xmygb7.fsf@free.fr>
Message-ID: <CAN1soZx84dmAVz-Kyv18+fjOJyzvun7fpbXA+rYb6xeEhQbXtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 12:38 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
>
>> I can remove the rtc-pxa support entirely. I still want to leave this
>> since this may be the only one choice in the future silicons.
>>
>> Since some boards with pxa27x/pxa3xx are accessing RCNR (the old rtc
>> wrapper) directly, I use rtc-sa1100 to keep consistently. In pxa95x,
>> nobody is using the old rtc wrapper directly. So I only use it in
>> pxa95x.
>
> No, I don't agree there.
>
> The PXA RTC silicon support 2 different set of registers to access time :
> ?- RCNR (rtc-sa1100)
> ?- RYCR/RDCR (rtc-pxa)
>
> The rtc-pxa driver was created to provide support for boards using the RYCR/RDCR
> rather than RCNR.
>
> Therefore I'm against removing rtc-pxa, unless there is a driver for pxa, which
> provides RTC using RYCR/RDCR registers.
>
> We had that discussion a long time ago, in [1].
>
Hi Robert,

rtc-sa1100 driver is the only one choice on sa1100/pxa25x/pxa910/mmp2.
And it's optional to pxa27x/pxa3xx/pxa95x.

Whatever we use RCNR or RDYR registers, they're in the same I/O range.
It's impossible to define same resource range for two rtc device. We
have to make a choice between rtc-sa1100 or rtc-pxa on
pxa27x/pxa3xx/pxa95x.

I hadn't any plan to remove rtc-pxa driver. I only disabled it for
pxa27x/pxa3xx. Please check the code of
arch/arm/mach-pxa/sharpsl_pm.c. If we only enable rtc-pxa on pxa27x,
we'll break the behavior on sharpsl since it's using rtc-sa1100. In
order to keep code consistently, I disable rtc-pxa on pxa27x/pxa3xx.
And use it on pxa95x since there's no legacy code issue.

Best Regards
Haojian
