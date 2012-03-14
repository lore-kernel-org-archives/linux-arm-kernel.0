From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Mar 2012 15:40:54 +0800
Subject: [PATCH] pxa/hx4700: Reduce sleep mode power consumption by 35%
In-Reply-To: <1331417108.99129.YahooMailClassic@web29004.mail.ird.yahoo.com>
References: <20120310182144.GA20013@n2100.arm.linux.org.uk>
 <1331417108.99129.YahooMailClassic@web29004.mail.ird.yahoo.com>
Message-ID: <CAN1soZy0nfSNA71a0SM1sfBMvzboOV+P4Ymd4YtsyphNCdiVbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 6:05 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> --- On Sat, 10/3/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> >? ??? /* BTUART */
>> >? ??? GPIO42_BTUART_RXD,
>> > -??? GPIO43_BTUART_TXD,
>> > +??? GPIO43_GPIO | MFP_AF2 |
>> MFP_LPM_DRIVE_LOW,
>>
>> I don't believe that's right.
>>
>> This expands to:
>>
>> ??? MFP_CFG_IN(GPIO43, AF0) | MFP_AF2 |
>> MFP_LPM_DRIVE_LOW
>>
>> and:
>>
>> ??? (MFP_CFG_DEFAULT & ~(MFP_AF_MASK |
>> MFP_DIR_MASK)) |
>> ??? (MFP_PIN(MFP_PIN_GPIO43) | MFP_AF0 |
>> MFP_DIR_IN)
>> ??? | MFP_AF2 | MFP_LPM_DRIVE_LOW
>>
>> Note the presence of both MFP_AF2 and MFP_AF0 in there.
>>
>> The default for GPIO43_BTUART_TXD is:
>>
>> ??? MFP_CFG_OUT(GPIO43, AF2, DRIVE_HIGH)
>>
>> and I'd suggest defining a new GPIO43_BTUART_TXD_LPM_LOW to
>> cover your
>> case.
>
> It wasn't right but it evaluated to the correct value because MFP_AF0 = 0.
> What I intended was: MFP_PIN_GPIO43 | MFP_AF2 | MFP_LPM_DRIVE_LOW
> But I'll add the new values to <mach/mfp-pxa27x.h> if that's preferable.
>
Yes, you can do it. It's prefer to append new values in <mfp-pxa27x.h>.
