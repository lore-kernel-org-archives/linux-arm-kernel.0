From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 17 Feb 2016 16:33:47 +0100
Subject: [PATCH] i.MX SPI DMA cleanup
In-Reply-To: <20160217145944.GB3939@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <56C478C9.6050706@de.bosch.com> <20160217135441.GA3939@pengutronix.de>
 <56C47F64.1080706@de.bosch.com> <20160217145944.GB3939@pengutronix.de>
Message-ID: <56C492DB.6000405@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2016 15:59, Sascha Hauer wrote:
> On Wed, Feb 17, 2016 at 03:10:44PM +0100, Dirk Behme wrote:
>> On 17.02.2016 14:54, Sascha Hauer wrote:
>>> Hi Dirk,
>>>
>>> On Wed, Feb 17, 2016 at 02:42:33PM +0100, Dirk Behme wrote:
>>>> Hi Sascha,
>>>>
>>>> On 17.02.2016 14:28, Sascha Hauer wrote:
>>>>> This picks up a series sent by Anton Bondarenko last year. It
>>>>> contains the remaining not yet upstreamed patches from Antons series
>>>>> plus some more DMA related cleanup patches.
>>>>>
>>>>> My mission was to hunt a bug in the DMA code path sometimes causing
>>>>> an additional word in the RX FIFO which locked up the driver in the
>>>>> next transfer. It turned out that this was no bug in the driver but
>>>>> instead in the device tree: We used the wrong SDMA script for i.MX6.
>>>>> The ECSPI cores are connected through the SPBA, so according to the
>>>>> reference manual we need the shp/mcu scripts rather than the app/mcu
>>>>> scripts.
>>>>
>>>>
>>>> Are you talking about what is known as "TKT238285 hardware issue"
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c8022
>>>
>>> I am aware of this issue, but I have no idea if this is the same or
>>> another issue. It says:
>>>
>>>> For TKT238285 hardware issue which may cause txfifo store data twice can only
>>>> be caught on i.mx6dl, we use pio mode instead of DMA mode on i.mx6dl.
>>>
>>> What I saw here is that there was one word more than expected in the RX
>>> FIFO. Since both RX and TX FIFO act synchronously it could be that the
>>> additional word in the RX FIFO was caused by an additional word in the
>>> TX FIFO as described above.
>>
>>
>> The question behind all this is if we could drop
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c8022
>>
>> ?
>
> It seems on the i.MX6DL we (additionally) have another issue. I just
> tested here on a i.MX6DL board with a NOR Flash connected. I saw the
> same issue as I saw on the i.MX6Q, but on the i.MX6DL it cannot be fixed
> by using the shp/mcu SDMA scripts.


To my understanding this might depend on the SDMA firmware itself, as in

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.14.38_6qp_ga&id=321beb210ffb382b8b5378cbf4467f8986efd52f

Freescale patches/changes the firmware, too.


> Funny enough on the i.MX6DL the RXFIFO issue happens much more
> frequently than on the i.MX6Q.


To my understanding, the TKT238285 hardware issue exists on both i.MX6Q 
and i.MX6DL. Even though the commit message in

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c802

states it differently. Maybe due to timing issues it happens less often 
on i.MX6Q and therefore wasn't in the focus there, yet.

Best regards

Dirk
