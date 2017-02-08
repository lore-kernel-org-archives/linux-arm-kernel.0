From: flatmax@flatmax.org (Matt Flax)
Date: Thu, 9 Feb 2017 08:14:21 +1100
Subject: [alsa-devel] [PATCH] ASoC: bcm2835: Add 8 channel (multitrack)
 capability
In-Reply-To: <21a531f2-4efb-fd92-b709-90f97ec73a92@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
 <21a531f2-4efb-fd92-b709-90f97ec73a92@flatmax.org>
Message-ID: <3dffc66f-deee-3417-03b2-509755e9cab9@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/02/17 07:41, Matt Flax wrote:
>
> On 09/02/17 05:28, Mark Brown wrote:
>> On Tue, Feb 07, 2017 at 10:09:36AM +1100, Matt Flax wrote:
>>
>>>       case SND_SOC_DAIFMT_CBS_CFM:
>>>           clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
>>> +    case SND_SOC_DAIFMT_CBM_CFS:
>> Is this fall through deliberate?
>>
>>> +    /* Default data delay to 1 bit.
>>> +       In I2S mode, we must have 2 channels */
>>>       switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>>>       case SND_SOC_DAIFMT_I2S:
>>> +        if (params_channels(params) != 2)
>>> +            return -EINVAL;
>>> +    case SND_SOC_DAIFMT_DSP_A:
>>> +    case SND_SOC_DAIFMT_DSP_B:
>>>           data_delay = 1;
>>>           break;
>>>       default:
>> Same here.  This is also buggy in that it treats DSP A and DSP B
>> identically, they are different so the configuration must be incorrect
>> for one of them.  I suspect this is configuring for DSP A.
> I can remove DSP_B. In actual fact this isn't the real problem.
>> You should also really have a setup() function that imposes a channel
>> constraint when in I2S mode, wm8988 is one example here.
>>
> I had a look at wm8988.c and couldn't see this channel constraint 
> linking to I2S. Can you point me to it ?
Hang on, I have got it. It is the patch I sent in previously for the 
wm8580.c codec !

Matt
