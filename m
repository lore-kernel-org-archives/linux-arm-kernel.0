From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Mar 2017 09:38:28 -0600
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
References: <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
 <20170227115108.GA6732@delle.lan>
 <20170228095929.GH2742@localhost.localdomain>
 <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
 <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
Message-ID: <1bec6abc-c296-eb93-a096-e4b8f1c7e1a4@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 06:04 AM, Matt Flax wrote:
>
>
> On 22/03/17 20:43, Charles Keepax wrote:
>> On Wed, Mar 22, 2017 at 10:29:33AM +1100, Matt Flax wrote:
>>> On 22/03/17 09:11, Matthias Reichl wrote:
>>>> On Tue, Mar 21, 2017 at 10:21:04PM +0100, Emmanuel Fust? wrote:
>>>>> Le 16/03/2017 ? 23:14, Matt Flax a ?crit :
>>>>>> On 17/03/17 08:27, Lars-Peter Clausen wrote:
>>>>>>> On 03/16/2017 09:51 PM, Matt Flax wrote:
>>>>>>>> On 16/03/17 06:01, Mark Brown wrote:
>>>>>>>>> On Tue, Feb 28, 2017 at 09:59:29AM +0000, Charles Keepax wrote:
>>>>>>>>>> On Mon, Feb 27, 2017 at 12:51:08PM +0100, Matthias Reichl wrote:
>>>>> Re-reading this document, the bcm2835 PCM IP block SHOULD support
>>>>> real DSP
>>>>> mode, with one BCLK pulsed LRCLK, zero BCLK delay etc...
>>>>> It just need to be properly setup.
>>>> I've re-read the document, too, last week and noticed the framesync
>>>> registers - sorry, I had completely forgotten about these. I guess it
>>>> should be possible to configure the bcm2835 to DSP mode but it'd
>>>> still be
>>>> limited to 2 channel setups - the hardware only has 2 channel position
>>>> registers for each direction.
>>>>
>>>>> According to the same document, you could program the bmc up to 16
>>>>> 32bits
>>>>> channels when in master mode, so I suspect that you could go up to
>>>>> this
>>>>> limit in slave mode.
>>>>> But as it is designed, it could only use up to two of any channels
>>>>> among the
>>>>> 16.
>>>> I'm not quite sure if I can follow you on this - how would you
>>>> configure 16 channels when there are only 2 channel position registers?
>>>>
>>>> With bclk ratio eg set to 16*32=512 BCM2835 will only transmit 2*32
>>>> bits of data (at configurable bit positions), the remaining 448
>>>> bits will be zero.
>>>>
>>> The document seems to stipulate that the PCM audio device is an AMBA
>>> device
>>> with 2 APB data channels. The first sync edge marks the beginning of
>>> the two
>>> data words. Their frame lengths can be up to 1024+32 bits in length !
>>>
>>> I think the point is that they intended their PCM audio interface to be
>>> configurable, they say in their document "It supports many classic PCM
>>> formats".
>>>
>>> The important point here is that in ALSA we can only have I2S or DSP
>>> modes -
>>> right ?
>>> Unless we want to create a new ALSA mode (which clearly worries
>>> people) then
>>> we need to support the versatility of the bcm2835 PCM hardware using
>>> either
>>> DSP or I2S modes. Now, we have already implemented the I2S mode, so
>>> logically the only available mode left is the DSP mode. Using this
>>> mode, we
>>> can implement more features of this device.
>>>
>>> People seem to want to reserve DSP and I2S modes for strictly I2S and
>>> DSP
>>> protocols. At the same time people don't want to allow a looser "APB"
>>> mode
>>> into ALSA. For that reason, we have a lack of functionality for
>>> perfectly
>>> versatile hardware - the bcm2835 hardware.
>>>
>> Apologies but I am still a little unclear as to what actually happens
>> on the bus here.
>>
>> Are we saying that what gets transmitted on the bus is neither valid
>> I2S or DSP mode data? But as you have your custom hardware block in
>> the middle it interprets this data correctly and converts it to a
>> regular bus format on the other side that goes to the CODEC?
>
> Yes, essentially there is translation between the two data word edge
> triggered ABP (the bcm2835's PCM block) and a Cirrus Logic TDM codec.

Are you really sure about this? I believe the BCM2835 I2S controller is 
a standard I2S controller.

Note that, as was pointed out earlier in this thread, "APB" has nothing 
to do with the audio side of the I2S controller's HW. Rather, the I2S 
controller connects to the SoC's APB bus so that the CPU can program the 
I2S controller's registers, and so that the CPU or DMA engine can 
read/write the audio data stream. The audio side of the I2S controller 
generates/consumes the standard I2S signals of clock, frame sync, data 
in, and data out. As such, I believe standard I2S and DSP modes are 
perfectly possible.

Now the BCM2835 I2S controller does appear to have a few features beyond 
plain I2S/DSP modes, that not all I2S controllers might have, such as:

- Frame length, FS length, channel position, and channel width are 
specified at bit resolution rather than byte/sample/...

- PDM mode (for digital mics).

- Sign extension of RX data.

So, the controller can generate/receive some formats beyond plain 
I2S/DSP, but to be honest I doubt that this level of detail needs to be 
exposed to the ALSA/ASoC core or user-space, nor is it required to 
interface to any typical HW, so it can be hidden in the driver's 
register programming implementation.
