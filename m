From: eric@anholt.net (Eric Anholt)
Date: Mon, 14 Nov 2016 10:24:03 -0800
Subject: [PATCH 1/2] pinctrl: bcm2835: Fix ints for GPIOs 28-31 & 46-53
In-Reply-To: <427a3d44-16aa-258c-8722-48d9c7ffb593@i2se.com>
References: <1479126206-20482-1-git-send-email-linus.walleij@linaro.org>
 <427a3d44-16aa-258c-8722-48d9c7ffb593@i2se.com>
Message-ID: <877f85vs1o.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Linus,
>
> Am 14.11.2016 um 13:23 schrieb Linus Walleij:
>> From: Phil Elwell <phil@raspberrypi.org>
>>
>> Contrary to the documentation, the BCM2835 GPIO controller actually
>> has four interrupt lines - one each for the three IRQ groups and one
>> common. Confusingly, the GPIO interrupt groups don't correspond
>> directly with the GPIO control banks. Instead, GPIOs 0-27 generate IRQ
>> GPIO0, 28-45 IRQ GPIO1 and 46-53 IRQ GPIO2.
>>
>> Awkwardly, the GPIOs for IRQ GPIO1 straddle two 32-entry GPIO banks,
>> so split out a function to process the interrupts for a single GPIO
>> bank.
>>
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> I want to apply this to cater for my GPIOLIB_IRQCHIP
>> refactorings.
>> ---
>>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 51 ++++++++++++++++++++++++++---------
>>  1 file changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> index b2dd278f18b1..1d8fc104e26b 100644
>> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>>
> ...
>> @@ -1076,6 +1102,7 @@ static struct platform_driver bcm2835_pinctrl_driver = {
>>  	.remove = bcm2835_pinctrl_remove,
>>  	.driver = {
>>  		.name = MODULE_NAME,
>> +		.owner = THIS_MODULE,
>
> this is unnecessary. Please remove it.
>
> Thanks for submitting these patches

With that dropped,

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/2938bc95/attachment.sig>
