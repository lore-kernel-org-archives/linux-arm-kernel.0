From: flatmax@flatmax.org (Matt Flax)
Date: Thu, 9 Feb 2017 08:13:05 +1100
Subject: [alsa-devel] [PATCH] ASoC: bcm2835: Add 8 channel (multitrack)
 capability
In-Reply-To: <20170208185359.GA11314@camel2.lan>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
 <20170208185359.GA11314@camel2.lan>
Message-ID: <0f96dd5e-f35b-26f5-fead-98796d11ba89@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/02/17 05:54, Matthias Reichl wrote:
> On Wed, Feb 08, 2017 at 06:28:35PM +0000, Mark Brown wrote:
>> On Tue, Feb 07, 2017 at 10:09:36AM +1100, Matt Flax wrote:
>>
>>>   	case SND_SOC_DAIFMT_CBS_CFM:
>>>   		clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
>>> +	case SND_SOC_DAIFMT_CBM_CFS:
>> Is this fall through deliberate?
>>
>>> +	/* Default data delay to 1 bit.
>>> +	   In I2S mode, we must have 2 channels */
>>>   	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>>>   	case SND_SOC_DAIFMT_I2S:
>>> +		if (params_channels(params) != 2)
>>> +			return -EINVAL;
>>> +	case SND_SOC_DAIFMT_DSP_A:
>>> +	case SND_SOC_DAIFMT_DSP_B:
>>>   		data_delay = 1;
>>>   		break;
>>>   	default:
> Matt, could you please include linux-rpi-kernel at lists.infradead.org
> in your emails?
I have joined that list now. It was included originally, but wasn't 
accepting my posts.
> I fail to see the part where DSP modes are actually set up in
> the hardware. bcm2835 still seems to be operating in 2-channel
> stereo I2S mode, i.e. no real frame sync information at the
> hardware level.
 From the SoC's perspective I agree with you. There is frame 
synchronisation at the hardware level, implemented in an master FPGA. 
This starts to hit at a lack of functionality in ALSA ... I will discuss 
more below.
> If all you do is adding code to pretend the bcm2835 could do
> multichannel modes wouldn't it be easier to implement that as
> a userspace alsa plugin?
>
>
I am not familiar with how to implement all of this with a plugin ? 
Could you give me a little hand in describing that further ? That would 
mean that an asoundrc needs to be used to defined to make the system 
usable ? Is it something which does the unpacking for us in user space ? 
If this happens in user space is there extra cost/latency ?

I would like to bring up another topic here.

In my opinion some of these changes we are making in this general thread 
are only really window dressing.

We have 4 ways of setting up master, however all of them assume that 
either the codec or the SoC is master. None of them allow for 
intermediate digital logic between the two.

In this case there is a FPGA which is matching the system differences 
between the Codec and the SoC. In actual fact, the FPGA needs to be 
master - a fifth mode.

A similar problem exists when you are using a sample rate converter 
chip. For example, the DAC and ADC are running at different sample 
rates. In this case ALSA can't represent both of the sample rates. For 
that reason, the ADCs and the DACs have to be hard coded - it is nasty.

The only solution for me is to use snd_soc_dai_set_fmt in the machine 
driver to instruct both to enter slave mode. For what it is worth, I can 
also

In my opinion there is nothing wrong with making hardware level 
introductions, such as an ASIC/FPGA to implement the hardware. I accept 
the inflexibility of ALSA w.r.t. this type of situation, however the 
real fix is to adjust the core of ALSA. Hardware ASICS and FPGAs which 
are intermediatries between codecs and SoCs exist and are used in industry.

This happens to be one of those cases.

thanks
Matt
