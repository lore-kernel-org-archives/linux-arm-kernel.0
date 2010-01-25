From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 25 Jan 2010 11:32:56 +0100
Subject: [PATCH 4/4] ARM: S3C64XX: Add s3c64xx support to touchscreen
	driver
In-Reply-To: <873a1uzdp1.fsf@lechat.rtp-net.org>
References: <b2e8f9f71001221447u550c9713l9f04aeec030c86db@mail.gmail.com>	<87aaw2zfd9.fsf@lechat.rtp-net.org>
	<4B5D682F.2020000@gmail.com> <873a1uzdp1.fsf@lechat.rtp-net.org>
Message-ID: <4B5D7358.3010609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 25-01-10 11:22, Arnaud Patard (Rtp) schreef:
> Maurus Cuelenaere<mcuelenaere@gmail.com>  writes:
>
> [...]
>
>    
>>>> @@ -40,7 +40,9 @@
>>>>    #include<plat/regs-adc.h>
>>>>    #include<plat/ts.h>
>>>>
>>>> +#ifdef PLAT_S3C24XX
>>>>    #include<mach/regs-gpio.h>
>>>> +#endif
>>>>
>>>>    #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
>>>>
>>>> @@ -88,6 +90,12 @@ struct s3c2410ts {
>>>>
>>>>    static struct s3c2410ts ts;
>>>>
>>>> +enum s3c_cpu_type {
>>>> +	TYPE_S3C2410,
>>>> +	TYPE_S3C2440,
>>>> +	TYPE_S3C64XX,
>>>> +};
>>>> +
>>>>    /**
>>>>     * s3c2410_ts_connect - configure gpio for s3c2410 systems
>>>>     *
>>>> @@ -95,6 +103,7 @@ static struct s3c2410ts ts;
>>>>     * connected to the device (later systems such as the S3C2440 integrate
>>>>     * these into the device).
>>>>    */
>>>> +#ifdef PLAT_S3C24XX
>>>>    static inline void s3c2410_ts_connect(void)
>>>>    {
>>>>    	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
>>>> @@ -102,6 +111,7 @@ static inline void s3c2410_ts_connect(void)
>>>>    	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
>>>>    	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
>>>>    }
>>>> +#endif
>>>>
>>>>          
>>> Please, remove all theses #ifdef. I don't see the point of them as it's
>>> only few lines of C code and they don't get executed when running on
>>> other platforms than 2410.
>>>        
>> The problem is that s3c2410_gpio_cfgpin() and S3C2410_* isn't defined
>> on S3C64XX builds so this gives implicit declaration errors.
>>      
> hmm... I didn't look in details but I thought such kind of issues was
> going to be fixed thanks to the changes in Ben's -next-* branches.
>    

Hmm I checked next-samsung but didn't see anything relevant..
Normally I check Ben's tree pretty regularly (this diff was based on an 
older next-samsung), so if he changes something I should pickup.

I can remove one pair of #ifdef's though, if I move the first one inside 
s3c2410_ts_connect() there's no need for the second one.

Regards,
Maurus Cuelenaere
