From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 19 May 2010 09:34:37 +1200
Subject: [RFC PATCH 1/3] ep93xx i2s driver
In-Reply-To: <0D753D10438DA54287A00B0270842697636F14EB75@AUSP01VMBX24.collaborationhost.net>
References: <4BF21B67.8090404@bluewatersys.com>
	<4BF21D48.3020005@bluewatersys.com>
	<0D753D10438DA54287A00B0270842697636F14EB75@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4BF307ED.2060701@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Monday, May 17, 2010 9:53 PM, Ryan Mallon wrote:
>> Add ep93xx i2s audio driver
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---
>>

>> +config SND_EP93XX_SOC_SNAPPERCL15
>> +        tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
>> +        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15
>> +        select SND_EP93XX_SOC_I2S
>> +        select SND_SOC_TLV320AIC23
> 
> Missing help text?

Thanks. Fixed.

>> +     struct ep93xx_pcm_dma_params    *dma_params[2];
>> +     struct resource                 *mem;
>> +     void __iomem                    *regs;
>> +};
> 
> Also, I saw Chase Douglas' comment on this struct and the defines.
> 
> If they are "only" used in this source file please leave them here.  If there
> is not a reason to expose the information globally, keep it private to the
> driver.

Yes, I'm also inclined to leave this all here since it keeps the file
self contained.

>> +static inline void ep93xx_i2s_enable_fifos(struct ep93xx_i2s_info *info,
>> +                                        int enable)
> 
> Not sure if this should be 'inline'

Removed.

>> +
>> +     ep93xx_syscon_swlocked_write(val, EP93XX_SYSCON_I2SCLKDIV);
>> +     return 0;
>> +}
> 
> As you noted, this is a bit ugly.
> 
> If you create two pseudo clocks in clock.c for the sclk and lrclk this can
> all be changed to:

I'm going to try and rework this a little. I think the pseudo clock
approach is the way to go. As Mark pointed out, the clkdiv function can
probably be removed and the sdiv/lrdiv calculation done as part of
ep93xx_i2s_hw_params.

>> diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
>> new file mode 100644
>> index 0000000..c071b5c
>> --- /dev/null
>> +++ b/sound/soc/ep93xx/ep93xx-pcm.c
> 
> Is this pcm driver generic enough to work with an AC97 driver?  Looking at
> some of the other soc drivers it appears there are different pcm drivers for
> different codec interfaces.  If it's not completely generic please rename this
> file as appropriate.

I don't actually know, I think it is. The PCM driver is originally
written by Lennert and the only changes I have really made are to update
it for the alsa soc interface. IIRC, Lennert was using it with an ac97
driver.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
