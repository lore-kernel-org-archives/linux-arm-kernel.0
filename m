From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 21 Apr 2010 13:14:51 +0530
Subject: [PATCH] PL061 GPIO: Changing *_irq_chip_data with *_irq_data
	for real irqs.
In-Reply-To: <20100421073728.GA6345@jasper.tkos.co.il>
References: <1271833201-4482-1-git-send-email-viresh.kumar@st.com>
	<20100421073728.GA6345@jasper.tkos.co.il>
Message-ID: <4BCEACF3.3060101@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2010 1:07 PM, Baruch Siach wrote:
> Hi Viresh,
> 
> On Wed, Apr 21, 2010 at 12:30:01PM +0530, Viresh KUMAR wrote:
>> PL061 driver is using set_irq_chip_data and get_irq_chip_data for real irq
>> lines. It must be using *_irq_data functions instead. As chip_data is used by
>> interrupt controllers also, which makes vic write at incorrect addresses.
>>
>> Also, pl061_direction_output doesn't set value of gpio to value passed to 
>> it.  Adding code to set value of GPIO pin to requrested value.
> 
> Please split this patch into two separate patches. The two fixes are unrelated 
> to each other.

OK.

> 
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
>>  drivers/gpio/pl061.c |    8 ++++----
>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
>> index 3ad1eeb..0a30124 100644
>> --- a/drivers/gpio/pl061.c
>> +++ b/drivers/gpio/pl061.c
>> @@ -86,10 +86,10 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
>>  		return -EINVAL;
>>  
>>  	spin_lock_irqsave(&chip->lock, flags);
>> -	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
> 
> I'm still for keeping this line.

I will do that, but i am still not sure why should we keep it.
Changing value before changing direction will have no effect.
And if in future releases of pl061 IP, this bug is resolved then also the
changing value after direction will be fine.
Is this fine?
