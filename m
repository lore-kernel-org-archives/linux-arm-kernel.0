From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Sun, 6 Mar 2011 09:31:41 +0900
Subject: staging: iio: ak8975: make gpio platdata mandatory
In-Reply-To: <AANLkTinXLC+tb7AkVBm-_xKS4ukA6v_AHDKkHKWvP6i3@mail.gmail.com>
References: <AANLkTik1MSkfyb36AHUOG+OK=h=rt1D4sbpyUiYg07dT@mail.gmail.com>
	<AANLkTinXLC+tb7AkVBm-_xKS4ukA6v_AHDKkHKWvP6i3@mail.gmail.com>
Message-ID: <AANLkTikWcW4X2eHoYLk_Ctd0kG8uY8LE8g2HPJCki-N0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyungmin Park,

On 4 March 2011 14:51, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi,
>
> On Fri, Mar 4, 2011 at 2:34 PM, Naveen Krishna Ch
> <naveenkrishna.ch@gmail.com> wrote:
>> Issue:
>> For some architectures CONFIG_GENERIC_GPIO is defined,
>> leaving irq_to_gpio undefined. ?Causing build break.
>
> It's better to implement the irq_to_gpio. Since gpio_to_irq is already
> implemented. it's just vice versa.
Implementing such macros in machine header files leads to inclusion of
mach/gpio.h or irqs.h
Russel King, seems against to the same...

Any suggestions, please
>
> Thank you,
> Kyungmin Park
>>
>> Solution:
>> 1. Some architechtures define irq_to_gpio in machine specific code.
>> 2. Make GPIO in platdata mandatory.
>>
>> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
>> ---
>>
>> ?drivers/staging/iio/magnetometer/ak8975.c | ? ?8 ++++----
>> ?1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/magnetometer/ak8975.c
>> b/drivers/staging/iio/magnetometer/ak8975.c
>> index 80c0f41..8456d1f 100644
>> --- a/drivers/staging/iio/magnetometer/ak8975.c
>> +++ b/drivers/staging/iio/magnetometer/ak8975.c
>> @@ -98,7 +98,6 @@ struct ak8975_data {
>> ? ? ? ?unsigned long ? ? ? ? ? mode;
>> ? ? ? ?u8 ? ? ? ? ? ? ? ? ? ? ?reg_cache[AK8975_MAX_REGS];
>> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? eoc_gpio;
>> - ? ? ? int ? ? ? ? ? ? ? ? ? ? eoc_irq;
>> ?};
>>
>> ?/*
>> @@ -453,12 +452,13 @@ static int ak8975_probe(struct i2c_client *client,
>> ? ? ? ?mutex_init(&data->lock);
>>
>> ? ? ? ?/* Grab and set up the supplied GPIO. */
>> - ? ? ? data->eoc_irq = client->irq;
>> ? ? ? ?pdata = client->dev.platform_data;
>> ? ? ? ?if (pdata)
>> ? ? ? ? ? ? ? ?data->eoc_gpio = pdata->gpio;
>> - ? ? ? else
>> - ? ? ? ? ? ? ? data->eoc_gpio = irq_to_gpio(client->irq);
>> + ? ? ? else {
>> + ? ? ? else {
>> + ? ? ? ? ? ? ? dev_err(&client->dev, "failed, no platform GPIO specified\n");
>> + ? ? ? ? ? ? ? goto exit;
>> + ? ? ? }
>>
>> ? ? ? ?if (!data->eoc_gpio) {
>> ? ? ? ? ? ? ? ?dev_err(&client->dev, "failed, no valid GPIO\n");
>> --
>> 1.7.0.4
>>
>> --
>> Shine bright,
>> (: Nav :)
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>



-- 
Shine bright,
(: Nav :)
