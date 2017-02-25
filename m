From: flatmax@flatmax.org (Matt Flax)
Date: Sun, 26 Feb 2017 09:13:09 +1100
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <20170225133952.GA28091@camel2.lan>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
Message-ID: <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 26/02/17 00:39, Matthias Reichl wrote:
> On Sat, Feb 25, 2017 at 04:03:11PM +1100, Matt Flax wrote:
>> This patch set lets the ASoC system specify that an IC between the SoC and codec
>> is master. This is intended to put both the SoC and Codec into slave modes.
>>
>> By default un-patched SoC and Codec drivers will return -EINVAL if they aren't
>> enabled and tested for this mode.
>>
>> soc-dia.h has the new SND_SOC_DAIFMT_IBM_IFM definition set as :
>> #define SND_SOC_DAIFMT_IBM_IFM		(5 << 12) /* IC clk & FRM master */
>>
>> The cs42xx8 codec driver is enabled for this mode and so too is the BCM2835
>> SoC driver. This forms a chain : bcm2835<=>IC<=>cs42xx8
>> where the IC is bit and frame master.
> Model your IC as a codec. No need to add patches to random drivers
> and add a flag with the rather meaningless semantics "someone else is
> automagically setting up clocks for me".
>
>

My last patch, used the two codec approach, however it was pointed out 
that the
bcm2835 was run in DSP mode with a codec master (rather then IC master) 
and that
the patch doesn't work. Which is clearly true and a problem, it can only 
work with an
intermediate non-codec master.

I think you summed it up well with your statement :

On 25/02/17 Matthias Reichl wrote:
If the clock timing adheres to DSP mode A timing and you add code
to the the CPU DAI driver so it can operate in DSP mode A then
that should also work. If not, it's broken.


This patch set fixes the problem of a daisy chain of three possible masters
(CPU <=> IC <=> codec) where only the IC can be master. In fact, when retro
fitting DSP mode to old silicon, the CPU can specify which of the three 
can be masters
and there is no chance that someone can fire the system up with the 
wrong master
(which we know produces bit offset and random channel swapping when a 
codec is
master).

thanks
Matt
