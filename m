From: stefan@agner.ch (Stefan Agner)
Date: Thu, 13 Sep 2018 10:03:05 -0700
Subject: [PATCH v2 6/8] drm/imx: support handling bridge timings bus flags
In-Reply-To: <1536827930.3452.4.camel@pengutronix.de>
References: <20180912183222.25414-1-stefan@agner.ch>
 <20180912183222.25414-7-stefan@agner.ch>
 <1536827930.3452.4.camel@pengutronix.de>
Message-ID: <c0814f7187159956c4a495986bdba01c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.09.2018 01:38, Philipp Zabel wrote:
> On Wed, 2018-09-12 at 11:32 -0700, Stefan Agner wrote:
>> A bridge might require specific settings for the pixel data on
>> the bus.
> 
> On which bus? The bridge has input and output.
> 
>> Copy the bus flags from the bridge timings if a bridge
>> is in use.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
>> index aefd04e18f93..7798a0621df7 100644
>> --- a/drivers/gpu/drm/imx/parallel-display.c
>> +++ b/drivers/gpu/drm/imx/parallel-display.c
>> @@ -239,6 +239,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
>>  	if (ret && ret != -ENODEV)
>>  		return ret;
>>
>> +	if (imxpd->bridge && imxpd->bridge->timings)
>> +		imxpd->bus_flags = imxpd->bridge->timings->input_bus_flags;
> 
> Oh, ok. I'd also specify input bus in the commit message.
> 

Good point, will change in v3 to:

"A bridge might require specific settings for the pixel data on
its input bus. Those are specified through optional bus timings.
Copy the bridges input bus flags as to the imxpd bus flags."

--
Stefan

>> +
>>  	imxpd->dev = dev;
>>
>>  	ret = imx_pd_register(drm, imxpd);
> 
> regards
> Philipp
