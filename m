From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 24 Aug 2015 11:17:43 +0200
Subject: [linux-sunxi] Re: [PATCH] net: sun4i-emac: Claim emac sram
In-Reply-To: <20150824074605.GF2413@lukather>
References: <1440354698-11144-1-git-send-email-hdegoede@redhat.com>
 <20150824074605.GF2413@lukather>
Message-ID: <55DAE137.4040306@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24-08-15 09:46, Maxime Ripard wrote:
> Hi Hans,
>
> On Sun, Aug 23, 2015 at 08:31:38PM +0200, Hans de Goede wrote:
>> Claim the emac sram ourselves, rather then relying on the bootloader
>> having mapped the sram to the emac controller during boot.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/net/ethernet/allwinner/sun4i-emac.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
>> index bab01c84..48ce83e 100644
>> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
>> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy.h>
>> +#include <linux/soc/sunxi/sunxi_sram.h>
>>
>>   #include "sun4i-emac.h"
>>
>> @@ -857,11 +858,17 @@ static int emac_probe(struct platform_device *pdev)
>>
>>   	clk_prepare_enable(db->clk);
>>
>> +	ret = sunxi_sram_claim(&pdev->dev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
>> +		goto out;
>
> Shouldn't you disable you clock too?

You're right, but that is a pre-existing problem, iow an unrelated issue.

I've put doing a follow-up patch for this on my todo list.

Regards,

Hans
