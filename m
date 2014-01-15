From: anssi.hannula@iki.fi (Anssi Hannula)
Date: Wed, 15 Jan 2014 15:48:29 +0200
Subject: [alsa-devel] [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
In-Reply-To: <52D67099.1040904@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk> <52D67099.1040904@ti.com>
Message-ID: <52D691AD.3010206@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

15.01.2014 13:27, Jyri Sarha kirjoitti:
> On 12/31/2013 03:25 PM, Mark Brown wrote:
>> On Fri, Dec 20, 2013 at 12:39:38PM +0200, Jyri Sarha wrote:
>>> support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
>>> The 8 least significant bits are ignored.
>>
>> Where does this constraint come from?
>>
> 
>  From driver/gpu/drm/i2c/tda998x_drv.c. The driver configures CTS_N 
> register statically to a value that works only with 4 byte samples. 
> According to my tests it is possible to support 3 and 2 byte samples too 
> by changing the CTS_N register value, but I am not sure if the 
> configuration can be changed on the fly. My data sheet of the nxp chip 
> is very vague about the register definitions, but I suppose the register 
> configures some clock divider on the chip. HDMI supports only upto 24bit 
> audio and the data sheet states that any extraneous least significant 
> bits are ignored.

That sounds strange, CTS/N values only depend on audio sample rate and
TMDS/video clock, not on the audio format or the size of samples (HDMI
spec sec 7.2 - Audio Sample Clock Capture and Regeneration).

Sure there isn't anything more going on (like the used HDMI sink being
more tolerant to wrong CTS/N with 4-byte samples, or more likely
something else I can't immediately think of)?


BTW, radeon driver has some code that calculates static CTS/N values
since the hw autogeneration is not reliable there:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/radeon/r600_hdmi.c
Not that it directly helps now, but just for the record...

-- 
Anssi Hannula
