From: yrdreddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Thu, 24 Dec 2015 11:03:50 +0530
Subject: [PATCH] pinctrl: nsp-gpio: fix type of iterator
In-Reply-To: <567B21CD.9090900@broadcom.com>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
 <1450867041-729-2-git-send-email-a.hajda@samsung.com>
 <567B21CD.9090900@broadcom.com>
Message-ID: <567B83BE.5090800@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/24/2015 4:05 AM, Ray Jui wrote:
> + Reddy
>
> On 12/23/2015 2:37 AM, Andrzej Hajda wrote:
>> Iterator i declared as unsigned is always non-negative so the
>> loop will never end.
>>
>> The problem has been detected using proposed semantic patch
>> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>>
>> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>   drivers/pinctrl/bcm/pinctrl-nsp-gpio.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
>> index 34648f6..ad5b04c 100644
>> --- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
>> +++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
>> @@ -439,7 +439,8 @@ static int nsp_gpio_set_strength(struct nsp_gpio *chip, unsigned gpio,
>>   static int nsp_gpio_get_strength(struct nsp_gpio *chip, unsigned gpio,
>>   				 u16 *strength)
>>   {
>> -	unsigned int i, offset, shift;
>> +	unsigned int offset, shift;
>> +	int i;
>>   	u32 val;
>>   	unsigned long flags;
>>
>>
> The fix is a valid fix. And at the same time it exposes other potential 
> issues in the driver. I just found the loop used in _set_strength and 
> _get_strength is inconsistent:
>
> In _set_strength:
>
> 427         for (i = GPIO_DRV_STRENGTH_BITS; i > 0; i--) {
>
> For i to start at GPIO_DRV_STRENGTH_BITS, it seems to be wrong.
>
> 428                 val = readl(chip->io_ctrl + offset);
> 429                 val &= ~BIT(shift);
> 430                 val |= ((strength >> (i-1)) & 0x1) << shift;
> 431                 writel(val, chip->io_ctrl + offset);
> 432                 offset += 4;
> 433         }
>
> In _get_strength:
>
> 451         for (i = (GPIO_DRV_STRENGTH_BITS - 1); i >= 0; i--) {
> 452                 val = readl(chip->io_ctrl + offset) & BIT(shift);
> 453                 val >>= shift;
> 454                 *strength += (val << i);
> 455                 offset += 4;
> 456         }
>
> Reddy, could you please review and comment?

Hi Ray,

             The logic is correct. The drive strength has three bits distributed in three registers. In one case the "-1" is in for loop initialization and the other case it is in the for loop body. The fix looks good.

Thanks
Dhananjay

> Thanks,
>
> Ray
>
>
