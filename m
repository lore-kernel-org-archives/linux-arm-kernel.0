From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 17 Feb 2016 15:10:44 +0100
Subject: [PATCH] i.MX SPI DMA cleanup
In-Reply-To: <20160217135441.GA3939@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <56C478C9.6050706@de.bosch.com> <20160217135441.GA3939@pengutronix.de>
Message-ID: <56C47F64.1080706@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2016 14:54, Sascha Hauer wrote:
> Hi Dirk,
>
> On Wed, Feb 17, 2016 at 02:42:33PM +0100, Dirk Behme wrote:
>> Hi Sascha,
>>
>> On 17.02.2016 14:28, Sascha Hauer wrote:
>>> This picks up a series sent by Anton Bondarenko last year. It
>>> contains the remaining not yet upstreamed patches from Antons series
>>> plus some more DMA related cleanup patches.
>>>
>>> My mission was to hunt a bug in the DMA code path sometimes causing
>>> an additional word in the RX FIFO which locked up the driver in the
>>> next transfer. It turned out that this was no bug in the driver but
>>> instead in the device tree: We used the wrong SDMA script for i.MX6.
>>> The ECSPI cores are connected through the SPBA, so according to the
>>> reference manual we need the shp/mcu scripts rather than the app/mcu
>>> scripts.
>>
>>
>> Are you talking about what is known as "TKT238285 hardware issue"
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c8022
>
> I am aware of this issue, but I have no idea if this is the same or
> another issue. It says:
>
>> For TKT238285 hardware issue which may cause txfifo store data twice can only
>> be caught on i.mx6dl, we use pio mode instead of DMA mode on i.mx6dl.
>
> What I saw here is that there was one word more than expected in the RX
> FIFO. Since both RX and TX FIFO act synchronously it could be that the
> additional word in the RX FIFO was caused by an additional word in the
> TX FIFO as described above.


The question behind all this is if we could drop

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c8022

?

And/Or if/how we like to import the FSL workaround for TKT238285

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.14.38_6qp_ga&id=646a751a4d1d0e227a762b461d9b8f92605c26b1

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.14.38_6qp_ga&id=01f180af19a7d5c6f5abc51218be93ea4b5d68ff

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.14.38_6qp_ga&id=321beb210ffb382b8b5378cbf4467f8986efd52f

?

Best regards

Dirk
