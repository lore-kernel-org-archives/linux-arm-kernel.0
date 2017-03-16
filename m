From: flatmax@flatmax.org (Matt Flax)
Date: Fri, 17 Mar 2017 07:51:49 +1100
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
References: <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
 <20170226221648.GA10974@camel2.lan>
 <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
 <20170227080433.GA2718@delle.lan>
 <170950f7-354f-e6a9-cefb-834a00fadd1b@flatmax.org>
 <20170227103024.GF2718@delle.lan>
 <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
 <20170227115108.GA6732@delle.lan>
 <20170228095929.GH2742@localhost.localdomain>
 <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
Message-ID: <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/03/17 06:01, Mark Brown wrote:
> On Tue, Feb 28, 2017 at 09:59:29AM +0000, Charles Keepax wrote:
>> On Mon, Feb 27, 2017 at 12:51:08PM +0100, Matthias Reichl wrote:
>>>> I have a bcm2835 (Pi 2 and 3) SoC here. It is producing multichannel (8 out,
>>>> 6 in) audio. In ALSA we call that DSP mode - right ?!
>>> No. DSP modes are protocol/timing specifications as I2S, PDP, S/PDIF, ...
>>> You can look these up in datasheets and if a chip implements such a
>>> protocol you can be sure that it adheres to that standard - i.e. it
>>> will sync the frames to the pulses on LRclk.
>> I agree with the thoughts in this thread really if the AP doesn't
>> actually support DSP A mode we shouldn't add DSP A mode.
> The trouble here is that this isn't 100% clear, the specifications of
> the DSP modes are such that only one edge in the LRCLK matters and so
> providing you're doing mono or have exact clocking they interoperate
> perfectly well.  We already frequently do similar things the other way,
> most of the programmable serial ports can't actually do I2S modes
> properly and rely on exact clocking to get things right when operating
> as I2S since they only sync on one edge (though they can generally
> generate the clocks correctly when operating as master, they just don't
> pay attention to the left/right switch edge).
>
> That said unless we're doing something with the data layout or similar
> configuration there's a fairly strong case for putting the mangling for
> this in the core, something like just falling back to I2S mode if we set
> DSP A and so on.  Which would be a lot nicer if we actually got round to
> putting mode capability information in the drivers.

I agree, the data layout is already configurable in the bcm2835_i2s.c 
platform driver. We can already use the "snd_soc_dai_set_bclk_ratio" 
function to manage word offsets in our machine drivers.

There is nothing which says that the bcm2835 SoC is I2S restricted in 
any way. In fact, the reference document says quite the opposite.

In the reference "BCM2835 ARM Peripherals" pdf, they call the audio 
system an "APB peripheral". They are saying that it is reconfigurable 
and part of the AMBA family of interconnect schemes.

As far as the bcm2835_i2s platform driver goes, it has implemented an 
AMBA protocol, where audio words are counted from the LR clock onset - 
for some reason people are insisting this is an I2S bus. Really our 
implementation is not I2S at all, because word onsets are programmable 
and flexible in the bcm2835_i2s.c driver.

What I have been trying to make happen over the past few months is to 
enable a different capability of the AMBA audio core on the bcm2835. Can 
you suggest a realistic approach to realising this which is acceptable 
to the ALSA code base ?

Do you suggest I go back to the approach of implementing the DSP mode 
for this platform driver ?

thanks
Matt
