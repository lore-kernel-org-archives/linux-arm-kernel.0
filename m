From: flatmax@flatmax.org (Matt Flax)
Date: Sat, 25 Feb 2017 13:38:03 +1100
Subject: [alsa-devel] [PATCH v8] ASoC: bcm2835: Add 8 channel (multitrack)
 capability
In-Reply-To: <27367161-11c6-2d62-cea0-f8936d8477e8@laposte.net>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487746600-11065-1-git-send-email-flatmax@flatmax.org>
 <20170224121832.GA19227@camel2.lan>
 <3b693ff9-b3a6-1c10-5b1a-78be04006113@flatmax.org>
 <20170224202553.GA28529@camel2.lan>
 <501e4af5-51b7-c124-4a29-ef5804d8a03c@flatmax.org>
 <20170224230159.GA30456@camel2.lan>
 <27367161-11c6-2d62-cea0-f8936d8477e8@laposte.net>
Message-ID: <1dd0f2a2-0927-f700-1c45-22538d7c9820@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/02/17 11:08, Emmanuel Fust? wrote:
> Le 25/02/2017 ? 00:02, Matthias Reichl a ?crit :
>> On Sat, Feb 25, 2017 at 08:30:03AM +1100, Matt Flax wrote:
>>>
>>> On 25/02/17 07:25, Matthias Reichl wrote:
>>>
>>>> I'd put it in another way: it seems to me that the bcm2835 I2S
>>>> won't reliably sync in DSP mode A.
>>>>
>>>>
>>> What you are explaining here is the nature of the BCM2835 responding 
>>> to a
>>> codec master. The hardware setup you are describing is elegantly 
>>> simple, but
>>> TOO simple.
>> Your patch only changes the CPU DAI driver. At this point it doesn't
>> matter if the codec or an external source is driving the clocks.
>>
>> If the clock timing adheres to DSP mode A timing and you add code
>> to the the CPU DAI driver so it can operate in DSP mode A then
>> that should also work. If not, it's broken.
>>
>> The (rather brief) publically available bcm2835 datasheet only
>> mentions I2S mode and my tests lead me to the conclusion that the
>> bcm2835 is actually expecting I2S timing, not DSP A - at least with
>> the current code.
> After reading this long thread and gluing all info together, my guess 
> is that the "real" thing he's trying to do is to introduce a new DPS 
> mode which is nothing more than a multichannel capable I2S mode or a 
> "DSP I" mode : DSP A with data_delay 1.
> As it is basically an I2S (2 channel) encapsulation of multichannel 
> stream, the real question is alsa plugin or new bastardized DSP mode ?
>

I am not sure if creating a new DSP mode is necesary ?

Having a conflict over DSP mode is a "red herring". Below we talk about 
clocking and timing mater, it is likely that that is where the real 
problem is.

>>
>>> Measurements on a system which uses a codec master don't represent a 
>>> robust
>>> implementation of multichannel with the BCM2835. My experiments (and 
>>> now
>>> yours) have shown that the system has a bit shift and an uncontrollable
>>> channel drift.
>>>
>>> Multichannel simply can't be done (on the BCM2835) without control 
>>> at the
>>> hardware level - this requires an intermediate master control chip.
>>>
>>> The Audio Injector Octo machine driver, sets both the codec and the 
>>> BCM2835
>>> as slaves - the FPGA is master because it has to control both the 
>>> BCM2835
>>> and the codec's systems to get reliability. You can see the machine 
>>> driver
>>> on github :
>>> https://github.com/flatmax/linux/blob/rpi-4.4.y/sound/soc/bcm/audioinjector-octo-soundcard.c 
>>>
>>>
>>> It has taken month to implement a robust solution to this problem 
>>> using an
>>> FPGA and the result is a fantastic (Audio Injector Octo) sound card. 
>>> I am
>>> almost certain this hardware technique can be used on all stereo I2S 
>>> SoC
>>> chips.
>> Can you please provide details about the timing / protocol you are
>> actually using?
> I suspect that the FPGA act as an I2S <=> DSP A translator, taking 
> care of data_delay difference translation relative to the falling edge 
> of LRCLK.
> It could translate the duration of the one BCLK duration of LRCLK DSP 
> A pulse to standard I2S LRCLK even if most codecs works with I2S fs 
> LRCLK timing as the sync point is the falling edge.
> As the FPGA has to deals with the clocks of the two sides, it's more 
> simple if it's the master.
> If I'm right, the real used mode from the soc point of view is I2S and 
> all of this is valid for all I2S IP, there is nothing BMC2835 specific 
> here. It is not the right place to do the mod.
>


That is right, the functionality doesn't exist in ALSA to have neither 
the codec nor the SoC as master.
  As I have mentioned before, this is really window dressing for the 
lack of functionality currently in ALSA.

Consider that the same problem exists for sample rate converter chips, 
it isn't only the Audio Injector Octo's use case.

I would like to change focus to the missing piece of the puzzle where an 
FPGA or ASIC is bit and frame master. For example a new definition :
#define SND_SOC_DAIFMT_ABM_AFM          (5 << 12) /* ASIC clk & FRM 
master */

Now with this new mode, it will force all codecs and SoC drivers to fail 
EINVAL unless they have been manually set up to handle an ASIC master.

This also solves the problem Mattias brought up where choosing DSP mode 
and codec master causes this terrible channel swapping and bit offset. 
Now we fail if in DSP mode with a codec master, or succeed in DSP mode 
with an ASIC master :

Example for the bcm2835_is2.c :

     /* In DSP mode, ensure that an ASIC is master */
     if ((dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK)
                                           == SND_SOC_DAIFMT_DSP_A)
         if ((dev->fmt & SND_SOC_DAIFMT_MASTER_MASK)
                                        != SND_SOC_DAIFMT_ABM_AFM )
             return -EINVAL;
         else
             return snd_pcm_hw_constraint_single(substream->runtime,
SNDRV_PCM_HW_PARAM_CHANNELS, 8);


Matt
