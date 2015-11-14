From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat, 14 Nov 2015 11:03:25 +0100
Subject: [PATCH v3 7/7] spi: imx: defer spi initialization, if DMA engine
 is pending
In-Reply-To: <563B8157.9030104@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-8-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151105085926.GK8526@pengutronix.de> <563B8157.9030104@gmail.com>
Message-ID: <564706ED.70102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05.11.2015 17:18, Anton Bondarenko wrote:
> On 05.11.2015 09:59, Sascha Hauer wrote:
>> On Sun, Nov 01, 2015 at 03:41:41PM +0100, Anton Bondarenko wrote:
>>> From: Anton Bondarenko <anton_bondarenko@mentor.com>
>>>
>>> If SPI device supports DMA mode, but DMA controller is not yet
>>> available due to e.g. a delay in the corresponding kernel module
>>> initialization, retry to initialize SPI driver later on instead of
>>> falling back into PIO only mode.
>>>
>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
>>
>> Ok, so 6/7 is only part of the deferral story. Maybe squash the two
>> patches into one?
>>
>> Sascha
>
> I would like to keep these two changes separately since I have a small
> concern about this exact change.
>
> Let's assume such scenario:
> - ECSPI configured to use DMA in device tree and DMA controller
> description specified. But there is no driver for this controller in
> kernel.
> In this case dmaengine will always return -EDEFER and driver postpone
> spi-imx initialization. So finally there will be no SPI support even in
> PIO mode.
> Or for example spi-imx will be compiled into kernel, but DMA controller
> driver will be on SPI-NOR based rootfs.
>
> So the question is "Should we allow user to use incorrect combination of
> kernel configuration and DTS and work at least with some limitation?" Or
> should we try to guarantee device tree file requirement to use DMA.
>
> Any thoughts?
>
> Regards, Anton

Does anyone has other comments regarding this commit?

Regards, Anton
