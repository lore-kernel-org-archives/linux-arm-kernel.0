From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 14:58:29 +0000
Subject: [PATCH 4/4] ARM: S3C64XX: Add s3c64xx support to touchscreen
	driver
In-Reply-To: <873a1uzdp1.fsf@lechat.rtp-net.org>
References: <b2e8f9f71001221447u550c9713l9f04aeec030c86db@mail.gmail.com>
	<87aaw2zfd9.fsf@lechat.rtp-net.org> <4B5D682F.2020000@gmail.com>
	<873a1uzdp1.fsf@lechat.rtp-net.org>
Message-ID: <20100126145829.GF9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 11:22:34AM +0100, Arnaud Patard wrote:
> Maurus Cuelenaere <mcuelenaere@gmail.com> writes:
> 
> [...]
> 
> >>> @@ -40,7 +40,9 @@
> >>>   #include<plat/regs-adc.h>
> >>>   #include<plat/ts.h>
> >>>
> >>> +#ifdef PLAT_S3C24XX
> >>>   #include<mach/regs-gpio.h>
> >>> +#endif
> >>>
> >>>   #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
> >>>
> >>> @@ -88,6 +90,12 @@ struct s3c2410ts {
> >>>
> >>>   static struct s3c2410ts ts;
> >>>
> >>> +enum s3c_cpu_type {
> >>> +	TYPE_S3C2410,
> >>> +	TYPE_S3C2440,
> >>> +	TYPE_S3C64XX,
> >>> +};
> >>> +
> >>>   /**
> >>>    * s3c2410_ts_connect - configure gpio for s3c2410 systems
> >>>    *
> >>> @@ -95,6 +103,7 @@ static struct s3c2410ts ts;
> >>>    * connected to the device (later systems such as the S3C2440 integrate
> >>>    * these into the device).
> >>>   */
> >>> +#ifdef PLAT_S3C24XX
> >>>   static inline void s3c2410_ts_connect(void)
> >>>   {
> >>>   	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
> >>> @@ -102,6 +111,7 @@ static inline void s3c2410_ts_connect(void)
> >>>   	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
> >>>   	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
> >>>   }
> >>> +#endif
> >>>      
> >> Please, remove all theses #ifdef. I don't see the point of them as it's
> >> only few lines of C code and they don't get executed when running on
> >> other platforms than 2410.
> >>
> >> Arnaud
> >>    
> >
> > The problem is that s3c2410_gpio_cfgpin() and S3C2410_* isn't defined
> > on S3C64XX builds so this gives implicit declaration errors.
> 
> hmm... I didn't look in details but I thought such kind of issues was
> going to be fixed thanks to the changes in Ben's -next-* branches.

there's nothing currently in here to deal with this.

The thing is that will configuring the GPIOs to their special function
before the driver is loaded do any damage to the SoC? If not then it
may be worth moving the s3c2410 case into the machines that need it (iirc,
about two so far) and simply remove it from the driver and thus avoid the
need for S3C2410/S3C2440 detection. Input welcome.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
