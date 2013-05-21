From: jgchunter@gmail.com (Jon Hunter)
Date: Tue, 21 May 2013 20:37:16 +0100
Subject: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
In-Reply-To: <20130521173936.GE31836@blackmetal.musicnaut.iki.fi>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com>
 <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
 <20130516214430.GN5600@atomide.com> <20130520174621.GI10378@atomide.com>
 <20130521173936.GE31836@blackmetal.musicnaut.iki.fi>
Message-ID: <519BCCEC.8010303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 21/05/13 18:39, Aaro Koskinen wrote:
> On Mon, May 20, 2013 at 10:46:21AM -0700, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [130516 14:50]:
>>> * Aaro Koskinen <aaro.koskinen@iki.fi> [130516 14:05]:
>>>> On Thu, May 16, 2013 at 11:09:34AM -0700, Tony Lindgren wrote:
>>>>> * Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
>>>>>> I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
>>>>>>
>>>>>> [    2.264221] retu-mfd 2-0001: Retu v3.2 found
>>>>>> [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
>>>>>> [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
>>>>>>
>>>>>> The error is coming from regmap code. According to git bisect, it is
>>>>>> caused by:
>>>>>>
>>>>>> 	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
>>>>>> 	Author: Jon Hunter <jon-hunter@ti.com>
>>>>>> 	Date:   Fri Mar 1 11:22:47 2013 -0600
>>>>>>
>>>>>> 	    gpio/omap: convert gpio irq domain to linear mapping
>>>>>>
>>>>>> The commit does not anymore revert cleanly, and I haven't yet tried
>>>>>> crafting a manual revert, so any fix proposals/ideas are welcome...
>>>>>
>>>>> Hmm this might be a bit trickier to fix. Obviously the real solution
>>>>> is to convert omap1 to SPARSE_IRQ like we did for omap2+.
>>>>>
>>>>> For the -rc cycle, it might be possible to fix this by adding a
>>>>> different irq_to_gpio() and gpio_to_irq() functions for omap1.
>>>>
>>>> The commit reverts cleanly if we also revert
>>>> 3513cdeccc647d41c4a9ff923af17deaaac04a66 (gpio/omap: optimise interrupt
>>>> service routine), which seems to be just some minor optimization. The
>>>> result is below, and with it 770 works again.
>>>
>>> Hmm in this case it seems that we should just fix it rather than go back
>>> to the old code, so let's take a look at that first.
>>
>> Does the following fix it for you or do we need to fix something else
>> there too?
> 
> Thanks, that fixes Retu probe on 770.

Sorry for not responding sooner, but I have been moving. 

>From looking at the code it appears that the regmap_add_irq_chip()
is failing in the retu driver. I am not sure if this will work, 
but have you tried making the following change to the retu driver 
so that it also uses irq_domain_add_linear() as well? Just a thought ...

Cheers
Jon

diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index a183098..7ad8cd4 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -267,7 +267,7 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
        if (ret < 0)
                return ret;
 
-       ret = regmap_add_irq_chip(rdev->regmap, i2c->irq, IRQF_ONESHOT, -1,
+       ret = regmap_add_irq_chip(rdev->regmap, i2c->irq, IRQF_ONESHOT, 0,
                                  rdat->irq_chip, &rdev->irq_data);
        if (ret < 0)
                return ret;
