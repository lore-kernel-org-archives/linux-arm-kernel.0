From: romain.perier@collabora.com (Romain Perier)
Date: Wed, 5 Jul 2017 12:14:57 +0200
Subject: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
In-Reply-To: <20170703065221.imbpbybsrd3of4ec@pengutronix.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-4-romain.perier@collabora.com>
 <20170630141329.6144cddd@karo-electronics.de>
 <20170703065221.imbpbybsrd3of4ec@pengutronix.de>
Message-ID: <91cc9a48-58e9-98a9-58aa-1a949b9b5552@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


Le 03/07/2017 ? 08:52, Uwe Kleine-K?nig a ?crit :
> On Fri, Jun 30, 2017 at 02:13:29PM +0200, Lothar Wa?mann wrote:
>> Hi,
>>
>> On Fri, 30 Jun 2017 14:04:42 +0200 Romain Perier wrote:
>>> From: Nandor Han <nandor.han@ge.com>
>>>
>>> Initialize both dma_is_{rx|tx}ing variables when DMA is enabled to avoid
>>> checking uninitialized variables if port shutdown is requested before
>>> DMA channels get a chance to start.
>>>
>>> Signed-off-by: Nandor Han <nandor.han@ge.com>
>>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>>> ---
>>>  drivers/tty/serial/imx.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index 188063d..81fb413 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -1225,6 +1225,9 @@ static void imx_enable_dma(struct imx_port *sport)
>>>  
>>>  	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
>>>  
>>> +	sport->dma_is_rxing = 0;
>>> +	sport->dma_is_txing = 0;
>>> +
>>>  	sport->dma_is_enabled = 1;
>>>  }
>>>  
>> sport is devm_kzalloc()ed, so the variables are initialized to 0 anyway.
> I'd agree to Lothar's statement. Did you find this issue by inspection,
> or does it fix a compiler warning? Do you think there is an actual
> problem?
>
> Best regards
> Uwe
>
What does happen if the UART port is shutdown and then re-enabled ? I
don't think that kzalloc will work in this case

Regards,
Romain
