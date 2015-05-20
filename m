From: slash.tmp@free.fr (Mason)
Date: Wed, 20 May 2015 22:41:33 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150520201438.GW2067@n2100.arm.linux.org.uk>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150518115452.GV2067@n2100.arm.linux.org.uk> <555CB499.7060600@free.fr>
 <12867692.bB1EJHiPzq@wuerfel> <555CE1B8.70205@free.fr>
 <20150520201438.GW2067@n2100.arm.linux.org.uk>
Message-ID: <555CF17D.4060500@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/2015 22:14, Russell King - ARM Linux wrote:
> On Wed, May 20, 2015 at 09:34:16PM +0200, Mason wrote:
>> On 20/05/2015 20:50, Arnd Bergmann wrote:
>>>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>>>> index 6591e26..300f13a 100644
>>>> --- a/arch/arm/kernel/smp_twd.c
>>>> +++ b/arch/arm/kernel/smp_twd.c
>>>> @@ -295,6 +295,10 @@ static void twd_timer_setup(void)
>>>>         clk->name = "local_timer";
>>>>         clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>>>>                         CLOCK_EVT_FEAT_C3STOP;
>>>> +#ifdef CONFIG_TANGOX
>>>> +       /*** Tango does not implement low power modes ***/
>>>> +       clk->features &= ~CLOCK_EVT_FEAT_C3STOP;
>>>> +#endif
>>>>         clk->rating = 350;
>>>>         clk->set_mode = twd_set_mode;
>>>>         clk->set_next_event = twd_set_next_event;
>>>
>>> This will disable the feature on all machines that are configured 
>>> in the kernel.
>>
>> What do you mean, "disable the feature"?
>>
>> My proposed patch doesn't change the default, which is to set
>> CLOCK_EVT_FEAT_C3STOP unconditionally for all machines.
>>
>> And then only for some platforms (in this case only TANGOX)
>> CLOCK_EVT_FEAT_C3STOP is *removed* from the features list.
> 
> So we build a kernel containing both tangox and OMAP together, and
> OMAP starts misbehaving because CLOCK_EVT_FEAT_C3STOP is no longer
> set.  That's a regression caused by your change, even if you didn't
> intend for anyone else to enable your option.

Oh... I didn't even think it made sense (and was supported)
to select more than one machine...

Is this related to CONFIG_ARCH_MULTIPLATFORM?

Regards.
