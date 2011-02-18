From: swetland@google.com (Brian Swetland)
Date: Fri, 18 Feb 2011 08:04:34 -0800
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
	<AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
	<AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
	<AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com>
Message-ID: <AANLkTin7UaKPgvmPC0+cJf5nBWuUmuUreAjDZxQGNB2j@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 5:03 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/2/17 Brian Swetland <swetland@google.com>:
>> On Wed, Feb 16, 2011 at 1:01 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> 2011/2/16 David Brown <davidb@codeaurora.org>:
>
>>>> The SDCC block is shared between
>>>> the modem processor and the processor running Linux. ?If the driver
>>>> doesn't go through the DMA engine, which coordinates this, the registers
>>>> will be stomped on by the other CPU whenever it decides to access it's
>>>> parts of the flash device.
>>> (...)
>>>
>>> At the same time what you're saying sounds very weird:
>>> the ios handler in mmc_sdcc does not request any DMA
>>> channel before messing with the hardware, it simply just write
>>> into registers very much in the style of mmci.c. Wouldn't that
>>> disturb any simultaneous access to the MMC from another
>>> CPU?
>>
>> (...)
>> The way register access for the SDCC is synchronized between these two
>> cores is by using a locking primitive built into the MSM DMA
>> controller. ?If you don't use this indirect access model (via DMA
>> transactions to the registers), you end up tripping over the baseband
>> or the other way 'round. ?It's not fun.
>
> Wherever is that synchronized in the DMA controller?
> I don't get it because the code is so very similar.
>
> When the ios does this:
> msmsdcc_writel(host, clk, MMCICLOCK);

Sorry, I'm wrong.  I was thinking of the MSM NAND driver which does
have a funky DMA interlock access control scheme where the DMA engine
is use to arbitrate register access between the apps and modem cores.
You are correct -- there's no special magic in the SDCC driver.

If this can be handled by a common driver with a quirks flag for
msm-specific oddities, that sounds quite sane to me.

Brian
