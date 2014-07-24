From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 24 Jul 2014 11:56:32 +0200
Subject: [PATCH] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <1406195275.4590.18.camel@weser.hi.pengutronix.de>
References: <1406193474-13695-1-git-send-email-shawn.guo@freescale.com>
 <1406195275.4590.18.camel@weser.hi.pengutronix.de>
Message-ID: <53D0D850.8050201@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2014 11:47 AM, Lucas Stach wrote:
> Am Donnerstag, den 24.07.2014, 17:17 +0800 schrieb Shawn Guo:
>> HDMI currently stops working after a system suspend/resume cycle.  It
>> turns out that the cause is the imx-hdmi encoder .dpms hook doesn't get
>> called from anywhere across suspend/resume cycle.
>>
>> The patch follows what exynos drm driver does to walk the list of
>> connectors and call their .dpms function from suspend/resume hook.  And
>> the connectors' .dpms function will in turn filter down to the .dpms
>> hooks of encoders and CRTCs.
>>
>> With this change, HDMI can continue working after a suspend/resume
>> cycle.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>> ---
>> Tested with HDMI and LVDS.  It'd be great if someone can help test TVE
>> to ensure the patch doesn't break anything.
>>
>>  drivers/staging/imx-drm/imx-drm-core.c | 39 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
>> index def8280d7ee6..b0ea1f0ed32f 100644
>> --- a/drivers/staging/imx-drm/imx-drm-core.c
>> +++ b/drivers/staging/imx-drm/imx-drm-core.c
>> @@ -696,6 +696,44 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +#if CONFIG_PM_SLEEP
> 
> use #ifdef

...or remove #if/#ifdef and mark as __maybe_unused

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/453066e7/attachment.sig>
