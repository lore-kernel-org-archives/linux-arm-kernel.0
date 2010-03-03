From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 03 Mar 2010 23:47:10 +0100
Subject: +
	mx3fb-introduce-waveform-configuration-for-pixel-clock-signal.patch
	added to -mm tree
In-Reply-To: <1267626205.2776.67.camel@realization>
References: <201003022230.o22MUGIs000990@imap1.linux-foundation.org>
	<1267571785.2670.10.camel@realization>
	<Pine.LNX.4.64.1003030951360.6770@axis700.grange>
	<1267626205.2776.67.camel@realization>
Message-ID: <1267656430.29404.0.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forwarded to the linux-arm-kernel mailinglist

On Wed, 3 Mar 2010, Alberto Panizzo wrote:

> On mer, 2010-03-03 at 10:58 +0100, Guennadi Liakhovetski wrote:
> > On Wed, 3 Mar 2010, Alberto Panizzo wrote:

...

> > > > @@ -514,11 +520,18 @@ static int sdc_init_panel(struct mx3fb_d
> > > >  	spin_lock_irqsave(&mx3fb->lock, lock_flags);
> > > >  
> > > >  	/*
> > > > -	 * DISP3_IF_CLK_DOWN_WR is half the divider value and 2 fraction bits
> > > > -	 * fewer. Subtract 1 extra from DISP3_IF_CLK_DOWN_WR based on timing
> > > > -	 * debug. DISP3_IF_CLK_UP_WR is 0
> > > > +	 * Building DI_DISP3_TIME_CONF:
> > > > +	 * DISP3_IF_CLK_PER_WR  = div; (4 fractional digits)
> > > > +	 * DISP3_IF_CLK_UP_WR   [0:(DOWN_WR - 0.5)]  (2 fractional digits)
> > > > +	 * DISP3_IF_CLK_DOWN_WR [(UP_WR + 0.5):PER_WR] (2 fractional digits)
> > > > +	 * using old_conf as buffer.
> > > >  	 */
> > > > -	mx3fb_write_reg(mx3fb, (((div / 8) - 1) << 22) | div, DI_DISP3_TIME_CONF);
> > > > +	old_conf = div;
> > > > +	old_conf |= (((div * mx3fb_pdata->pix_clk_start) / 16) >> 2) << 12;
> > > > +	old_conf |= (((div * (mx3fb_pdata->pix_clk_start +
> > > > +		              mx3fb_pdata->pix_clk_width)) / 16) >> 2) << 22;
> > 
> > On the style side - I think, the compiler should be smart enough to 
> > optimise this, but I just don't see the point in writing
> > 
> > 	s = x;
> > 	s |= y;
> > 	s |= z;
> > 
> > instead of just
> > 
> > 	s = x |
> > 	    y |
> > 	    z;
> 
> Yes, this can be done, mine was only a way to get a more readable code
> but I didn't thought at this version, that will be better.
> 
> > 
> > As to the maths: previously we had the clock down time in the register
> > 
> > 	div / 8 - 1
> > 
> > Now we have for the default start + width = 7
> > 
> > 	div * 7 / 16 / 4
> > 
> > Which is necessarily the same. I would feel myself more comfortable, if 
> > you kept the formula. Why don't you set default clk_width to 8 and do as 
> > up to now
> > 
> > 	(div * (mx3fb_pdata->pix_clk_start +
> > 		mx3fb_pdata->pix_clk_width) / 64 - 1) << 22
> > 
> > for the falling edge location? Would you be able to find parameter values, 
> > suitable for your configuration, using these two formalae?
> 
> The maths that you propose insert a constant error in the real waveform.
> Yes, for me it would be possible to find a combination of parameters
> that works, but the meaning of those parameters will be broken..
> 
> I think that the meaning of the parameters is much important, because 
> the resulting pixel_clock waveform will perform as commanded.
> The default configuration provided perform a waveform a lot similar
> (if not matched exactly) than the older one: rising front at the 
> beginning and falling front a little bit the half of the period.
> 
> The code I propose would be as general as possible, as the video
> output can be connected to different kind of video users (directly
> to the panel, or different kind of Analogue to Digital Video Converters
> with different specs of clock timings).
> 
> Do you agree with me?
> 
> Problems came for div < 0x4 because the truncation is too important,
> but since div is greater or equal to 0x40 the maths works fine no?

I tested your patch on pcm037 with a qvga Sharp display, pixclock=185925 
(5378kHz). Currently the display clock period is 94 HSP ticks, of which 
the high part is 46 ticks. With your patch the high part becomes 41 ticks. 
It still works, but I have no idea whether this will also work for all 
other boards and configurations, using this driver. The comment "Subtract 
1 extra from DISP3_IF_CLK_DOWN_WR based on timing debug." comes from the 
original driver (from Freescale, I think), and I have no idea what exactly 
they have debugged. So, personally, I would sacrifice mathematic 
correctness to non-regression guarantee, but I'm not the maintainer. And I 
have no knowledge of display interfaces to judge, how critical such a 
change can be for them. So, I would either get all maintainers of current 
mx3fb users:

arch/arm/mach-mx3/armadillo5x0.c
arch/arm/mach-mx3/pcm043.c
arch/arm/mach-mx3/mx31lilly-db.c
arch/arm/mach-mx3/pcm037.c

to test and ack your patch, or at least calculate current 
DI_DISP3_TIME_CONF values for all of them and compare them with those 
after your patch, and get arch maintainer's (Sascha?) ack for this... Or 
just preserve the current behaviour, adding the flexibility, you require.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
