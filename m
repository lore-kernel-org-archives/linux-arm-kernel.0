From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 16 Dec 2016 15:39:26 -0800
Subject: [PATCH v6 1/5] [media] davinci: VPIF: fix module loading,
 init errors
In-Reply-To: <19dc6321-1433-e089-f753-e5f736e26073@xs4all.nl> (Hans Verkuil's
 message of "Fri, 16 Dec 2016 10:44:20 +0100")
References: <20161207183025.20684-1-khilman@baylibre.com>
 <20161207183025.20684-2-khilman@baylibre.com>
 <19dc6321-1433-e089-f753-e5f736e26073@xs4all.nl>
Message-ID: <m2r357e95d.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hans Verkuil <hverkuil@xs4all.nl> writes:

> On 07/12/16 19:30, Kevin Hilman wrote:
>> Fix problems with automatic module loading by adding MODULE_ALIAS.  Also
>> fix various load-time errors cause by incorrect or not present
>> platform_data.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  drivers/media/platform/davinci/vpif.c         |  5 ++++-
>>  drivers/media/platform/davinci/vpif_capture.c | 15 ++++++++++++++-
>>  drivers/media/platform/davinci/vpif_display.c |  6 ++++++
>>  3 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
>> index 0380cf2e5775..f50148dcba64 100644
>> --- a/drivers/media/platform/davinci/vpif.c
>> +++ b/drivers/media/platform/davinci/vpif.c
>> @@ -32,6 +32,9 @@
>>  MODULE_DESCRIPTION("TI DaVinci Video Port Interface driver");
>>  MODULE_LICENSE("GPL");
>>
>> +#define VPIF_DRIVER_NAME	"vpif"
>> +MODULE_ALIAS("platform:" VPIF_DRIVER_NAME);
>> +
>>  #define VPIF_CH0_MAX_MODES	22
>>  #define VPIF_CH1_MAX_MODES	2
>>  #define VPIF_CH2_MAX_MODES	15
>> @@ -466,7 +469,7 @@ static const struct dev_pm_ops vpif_pm = {
>>
>>  static struct platform_driver vpif_driver = {
>>  	.driver = {
>> -		.name	= "vpif",
>> +		.name	= VPIF_DRIVER_NAME,
>>  		.pm	= vpif_pm_ops,
>>  	},
>>  	.remove = vpif_remove,
>> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
>> index 5104cc0ee40e..20c4344ed118 100644
>> --- a/drivers/media/platform/davinci/vpif_capture.c
>> +++ b/drivers/media/platform/davinci/vpif_capture.c
>> @@ -45,6 +45,7 @@ module_param(debug, int, 0644);
>>  MODULE_PARM_DESC(debug, "Debug level 0-1");
>>
>>  #define VPIF_DRIVER_NAME	"vpif_capture"
>> +MODULE_ALIAS("platform:" VPIF_DRIVER_NAME);
>>
>>  /* global variables */
>>  static struct vpif_device vpif_obj = { {NULL} };
>> @@ -647,6 +648,10 @@ static int vpif_input_to_subdev(
>>
>>  	vpif_dbg(2, debug, "vpif_input_to_subdev\n");
>>
>> +	if (!chan_cfg)
>> +		return -1;
>> +	if (input_index >= chan_cfg->input_count)
>> +		return -1;
>>  	subdev_name = chan_cfg->inputs[input_index].subdev_name;
>>  	if (subdev_name == NULL)
>>  		return -1;
>> @@ -654,7 +659,7 @@ static int vpif_input_to_subdev(
>>  	/* loop through the sub device list to get the sub device info */
>>  	for (i = 0; i < vpif_cfg->subdev_count; i++) {
>>  		subdev_info = &vpif_cfg->subdev_info[i];
>> -		if (!strcmp(subdev_info->name, subdev_name))
>> +		if (subdev_info && !strcmp(subdev_info->name, subdev_name))
>
> Why this change? subdev_info can never be NULL.

A debugging leftover I guess.  Will remove and resend.

Thanks for the review,

Kevin
