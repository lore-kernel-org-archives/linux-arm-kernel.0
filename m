From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 24 Sep 2009 20:36:42 +0100
Subject: platform data for the s3c-adc or hardcoded delay?
In-Reply-To: <2accc2ff0909230336m173f0b0fqc1e1c08be448b648@mail.gmail.com>
References: <2accc2ff0909230332y6bf565e0kc33a0ef8d8072451@mail.gmail.com>
	<2accc2ff0909230336m173f0b0fqc1e1c08be448b648@mail.gmail.com>
Message-ID: <20090924193642.GH31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2009 at 05:36:33AM -0500, Nelson Castillo wrote:
> (Ben, sorry for sending 2 copies. I used the old list address... I'd
> better go to sleep now.).
> 
> 
> We had this for the touchscreen but it doesn't make sense now that the
> driver has been converted to use the s3c-adc API.
> 
> const static struct s3c_ts_platdata gta02_ts_cfg = {
> ? ? ? .delay = 10000,
> ? ? ? .presc = 0xff, /* Slow as we can go. */
> };
> 
> Without this delay the TS doesn't work for us:
> 
> Now I see two options:
> 
> 1) Hardcode the delay in plat-s3c24xx/adc.c (As it's done in [1]).
> 2) Submit patches adding s3c_adc_platdata.

The pre-scaler value is probably something we should be passing to the
ADC core driver via platform data, I think that the rate that the conversions
are run at is a property of the board itself and not just the client. This
is mostly due to (I think) the ADC drawing more power the faster it runs
and the board may have only been designed to supply a certain amount of
power to the ADC.

The delay value is probably something that the client structure should
contain and the ADC driver set the delay value when the client is first
selected to start a conversion. 
 
> What do I do?
> 
> I also would like to know if we rule out the possibility of
> delay/presc depending on the current s3c_adc_client.
> 
> [1] http://lists.openmoko.org/pipermail/openmoko-kernel/2009-September/010550.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
