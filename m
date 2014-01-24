From: jsarha@ti.com (Jyri Sarha)
Date: Fri, 24 Jan 2014 15:01:20 +0200
Subject: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI audio support
 for TDA998x trough McASP I2S bus
In-Reply-To: <20140121191547.GX17314@sirena.org.uk>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk> <52D67099.1040904@ti.com>
 <20140121191547.GX17314@sirena.org.uk>
Message-ID: <52E26420.6070901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 09:15 PM, Mark Brown wrote:
> On Wed, Jan 15, 2014 at 01:27:21PM +0200, Jyri Sarha wrote:
>> On 12/31/2013 03:25 PM, Mark Brown wrote:
>
>>>> support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
>>>> The 8 least significant bits are ignored.
>
>>> Where does this constraint come from?
>
>>  From driver/gpu/drm/i2c/tda998x_drv.c. The driver configures CTS_N
>> register statically to a value that works only with 4 byte samples.
>> According to my tests it is possible to support 3 and 2 byte samples
>> too by changing the CTS_N register value, but I am not sure if the
>> configuration can be changed on the fly. My data sheet of the nxp
>> chip is very vague about the register definitions, but I suppose the
>> register configures some clock divider on the chip. HDMI supports
>> only upto 24bit audio and the data sheet states that any extraneous
>> least significant bits are ignored.
>
> Hrm.  This sounds like it ought to be presenting as an ASoC CODEC
> driver.
>

I do not disagree. I just do no not have a clear understanding how 
something like that should be done. Either the tda998x_drv it self 
should provide the ASoC codec driver or there should be some kind of API 
that could be accessed by some driver under sound/soc/codecs. Anyway it 
sound like Jean-Francois Moine is already doing that. I'll take his 
driver into use as soon as his code is merged.

However, for now a simple implementation that I have does not really 
need any interaction with the HDMI encoder and thus no codec driver either.

>>>> +	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
>>>> +				     2, 2);
>
>>> Why not just set all this statically when registering the DAI?
>
>> Because there is no relevant DAI to where to put these limitations.
>> I did not want to add yet another dummy codec driver, but decided to
>> use the already existing ASoC HDMI codec. By default the driver
>> support all audio params supported by HDMI. The limitations are
>> coming from NXP chip, the NXP driver, and because the chip is used
>> in i2s mode. In other words the limitation is coming from machine
>> setup, not from the DAIs.
>
> OK, but it sounds like it's got register configuration as well?  That
> really does sound like a device that ought to have a driver...
>

Sure, but it would not save form making runtime constraints. The usage 
of i2s mode, which limits the number of channels, is selected by dai_fmt 
call after dai registering.

Best regards,
Jyri
