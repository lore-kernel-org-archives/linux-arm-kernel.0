From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 10 Feb 2015 14:05:16 +0100
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
Message-ID: <54DA020C.6030703@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am 10.02.2015 um 13:52 schrieb Fabio Estevam:
> Hi Stefan,
>
> On Fri, Jan 30, 2015 at 5:20 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> According to i.MX23 and i.MX28 reference manual [1],[2] the fractional
>> clock control register is 32-bit wide, but is separated in 4 parts.
>> So write instructions must not apply to more than 1 part at once.
>>
>> The clk init for the i.MX28 violates this restriction and all the other
>> accesses on that register suggest that there isn't such a restriction.
>>
>> This patch restricts the access to this register to byte instructions and
>> extends the comment in the init functions.
>>
>> Btw the imx23 init now uses a R-M-W sequence just like imx28 init
>> to avoid any clock glitches.
>>
>> The changes has been tested with a i.MX23 and a i.MX28 board.
>>
>> [1] - http://cache.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
>> [2] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>> ---
>>
>> Changes in V2:
>> - use relaxed access operations in clk-ref
> With this patch applied mx28evk cannot probe SPI NOR flash:
>
> m25p80 spi1.0: unrecognized JEDEC id bytes: bf, 24, 40
>
> Reverting it from linux-next, then the SPI NOR probe correctly.
>
> m25p80 spi1.0: sst25vf016b (2048 Kbytes)
>
> Any ideas?

sorry no. But i will try to get a mx28evk to reproduce the problem and
narrow down which part of the patch causes this problem.

Did you see any problem with the clock control register settings?

Stefan

>
> Thanks for the suggestion, Marek!
>
> Regards,
>
> Fabio Estevam
