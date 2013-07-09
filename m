From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Jul 2013 08:27:00 -0600
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <20130709070541.GQ516@pengutronix.de>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>
 <20130709070541.GQ516@pengutronix.de>
Message-ID: <51DC1DB4.3050802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 01:05 AM, Sascha Hauer wrote:
> On Fri, Jul 05, 2013 at 04:43:38PM +0800, Huang Shijie wrote:
>> If we set the uart compatible in the dts file like this:
>>    ------------------------------------------------------
>>     compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
>>    ------------------------------------------------------
>>
>> and we set the uart compatible in the uart driver like this:
>>    ------------------------------------------------------
>> 	{ .compatible = "fsl,imx1-uart", ... },
>> 	{ .compatible = "fsl,imx21-uart", ... },
>> 	{ .compatible = "fsl,imx6q-uart", ... },
>> 	{ /* sentinel */ }
>>    ------------------------------------------------------
>>
>> the current code will match the "fsl,imx21-uart" in the end.
>>
>> Of course, this is not what we want. We want it to match the "fsl,imx6q-uart".
>>
>> This patch rewrites the match code, and make it to check the compatible
>> in the order set by the DTS file.
> 
> Why don't you set the matching order in the driver the way you want it
> to be, i.e.:
> 
> 	{ .compatible = "fsl,imx6q-uart", ... },
> 	{ .compatible = "fsl,imx21-uart", ... },
> 	{ .compatible = "fsl,imx1-uart", ... },

DT semantics are that earlier entries in the compatible property are
supposed to be matched first, irrespective of how the driver is constructed.
