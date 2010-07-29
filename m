From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 29 Jul 2010 15:03:20 +0200
Subject: [PATCH v2] video/imxfb.c: allow usage
	without	BACKLIGHT_CLASS_DEVICE
In-Reply-To: <20100729124534.GB6268@pengutronix.de>
References: <20100729091138.GA6268@pengutronix.de>
	<1280396856-4884-1-git-send-email-eric@eukrea.com>
	<20100729124534.GB6268@pengutronix.de>
Message-ID: <4C517C18.50502@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/07/2010 14:45, Uwe Kleine-K?nig a ?crit :
> On Thu, Jul 29, 2010 at 11:47:36AM +0200, Eric B?nard wrote:
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>> ---
>> v2:	handle CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE
>>
>>   drivers/video/imxfb.c |   18 ++++++++++++++++--
>>   1 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
>> index 43f0639..a6f0d3f 100644
>> --- a/drivers/video/imxfb.c
>> +++ b/drivers/video/imxfb.c
>> @@ -175,7 +175,10 @@ struct imxfb_info {
>>
>>   	struct imx_fb_videomode *mode;
>>   	int			num_modes;
>> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
>> +	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
>>   	struct backlight_device *bl;
>> +#endif
> I suspect this fails to build with
> 	CONFIG_BACKLIGHT_CLASS_DEVICE=m
> 	CONFIG_FB_IMX=y
>
you're right, I tested both =y and both =m but not one =y one =m :-(

> Maybe do the following:
>
> #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> 	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) == defined(CONFIG_FB_IMX_MODULE))
> #define BACKLIGHT_AVAILABLE
> #endif
>
> and use #ifdef BACKLIGHT_AVAILABLE to guard the backlight code?
>
> I didn't test this though.
>
patch follows (compile tested with all cases, including this new one ;-).

Eric
