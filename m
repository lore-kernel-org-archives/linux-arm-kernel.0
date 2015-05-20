From: slash.tmp@free.fr (Mason)
Date: Wed, 20 May 2015 21:34:16 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <12867692.bB1EJHiPzq@wuerfel>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150518115452.GV2067@n2100.arm.linux.org.uk> <555CB499.7060600@free.fr>
 <12867692.bB1EJHiPzq@wuerfel>
Message-ID: <555CE1B8.70205@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/2015 20:50, Arnd Bergmann wrote:

> On Wednesday 20 May 2015 18:21:45 Mason wrote:
>>
>> On 18/05/2015 13:54, Russell King - ARM Linux wrote:
>>
>>> For a SoC where WFI is not programmed to cause anything other than
>>> the architecture specified dormant behaviour, WFI will not cause the
>>> TWD to stop.
>>
>> According to the hardware engineers, my SoC does not support any
>> low-power modes.
>>
>> But I didn't see the "clean" way to make the kernel aware of this.
>> Is this an acceptable patch? (I have my doubts.)
> 
> No, this is clearly broken.

I don't see it. Could you be more explicit?

>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 6591e26..300f13a 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -295,6 +295,10 @@ static void twd_timer_setup(void)
>>         clk->name = "local_timer";
>>         clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>>                         CLOCK_EVT_FEAT_C3STOP;
>> +#ifdef CONFIG_TANGOX
>> +       /*** Tango does not implement low power modes ***/
>> +       clk->features &= ~CLOCK_EVT_FEAT_C3STOP;
>> +#endif
>>         clk->rating = 350;
>>         clk->set_mode = twd_set_mode;
>>         clk->set_next_event = twd_set_next_event;
> 
> This will disable the feature on all machines that are configured 
> in the kernel.

What do you mean, "disable the feature"?

My proposed patch doesn't change the default, which is to set
CLOCK_EVT_FEAT_C3STOP unconditionally for all machines.

And then only for some platforms (in this case only TANGOX)
CLOCK_EVT_FEAT_C3STOP is *removed* from the features list.

Regards.
