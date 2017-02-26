From: emmanuel.fuste@laposte.net (=?UTF-8?Q?Emmanuel_Fust=c3=a9?=)
Date: Sun, 26 Feb 2017 21:41:11 +0100
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <20170226144958.GA5543@camel2.lan>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
Message-ID: <141ed0ce-2801-1ace-84b5-c2881ad8921d@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/02/2017 ? 15:49, Matthias Reichl a ?crit :
> On Sun, Feb 26, 2017 at 09:13:09AM +1100, Matt Flax wrote:
>> On 26/02/17 00:39, Matthias Reichl wrote:
>>> On Sat, Feb 25, 2017 at 04:03:11PM +1100, Matt Flax wrote:
>>>> This patch set lets the ASoC system specify that an IC between the SoC and codec
>>>> is master. This is intended to put both the SoC and Codec into slave modes.
>>>>
>>>> By default un-patched SoC and Codec drivers will return -EINVAL if they aren't
>>>> enabled and tested for this mode.
>>>>
>>>> soc-dia.h has the new SND_SOC_DAIFMT_IBM_IFM definition set as :
>>>> #define SND_SOC_DAIFMT_IBM_IFM		(5 << 12) /* IC clk & FRM master */
>>>>
>>>> The cs42xx8 codec driver is enabled for this mode and so too is the BCM2835
>>>> SoC driver. This forms a chain : bcm2835<=>IC<=>cs42xx8
>>>> where the IC is bit and frame master.
>>> Model your IC as a codec. No need to add patches to random drivers
>>> and add a flag with the rather meaningless semantics "someone else is
>>> automagically setting up clocks for me".
>>>
>>>
>> My last patch, used the two codec approach, however it was pointed out that
>> the
>> bcm2835 was run in DSP mode with a codec master (rather then IC master) and
>> that
>> the patch doesn't work. Which is clearly true and a problem, it can only
>> work with an
>> intermediate non-codec master.
>>
>> I think you summed it up well with your statement :
>>
>> On 25/02/17 Matthias Reichl wrote:
>> If the clock timing adheres to DSP mode A timing and you add code
>> to the the CPU DAI driver so it can operate in DSP mode A then
>> that should also work. If not, it's broken.
> Your bcm2835 patch doesn't configure the bcm2835 to DSP mode A,
> it's still setup for I2S (slave) mode. You are just adding code
> to pretend it's running in DSP mode A. Don't do that, it's wrong.
>
>> This patch set fixes the problem of a daisy chain of three possible masters
>> (CPU <=> IC <=> codec) where only the IC can be master. In fact, when retro
>> fitting DSP mode to old silicon, the CPU can specify which of the three can
>> be masters
>> and there is no chance that someone can fire the system up with the wrong
>> master
>> (which we know produces bit offset and random channel swapping when a codec
>> is
>> master).
> Please follow the advice I gave you about 3 weeks ago and model your
> setup properly.
>
> | So you have bcm2835 I2S <-> FPGA <-> codec - IOW a standard codec<->codec
> | link.
> |
> | What you seem to be missing is just a method to transfer your 8-channel
> | data via a 2-channel link - userspace want's to see an 8-channel PCM,
> | but the hardware link (bcm2835-i2s) is only 2-channel.
> |
> | And that's where IMO as userspace plugin looks like a very good solution.
> | It's basically the counterpart of your FPGA and contains the code that's
> | neccessary to encapsulate/pack/whatever the 8-channel data into a 2-channel
> | stream so it can then be unpacked to 8-channel by the FPGA.
> |
> | If you go this route your hardware and machine driver will work with
> | other I2S codecs as well, and IMO that's a far better solution than
> | adding very ugly hacks to a single I2S driver.
>
> If you add an active hardware component (your "IC"/FPGA) you also
> have to model that in software.
>
> If that component is acting as a clock master it probably has some
> method to setup clocks. Even if you don't have that, eg if you
> are running at some fixed rate you'll have to store that information
> somewhere.
>
> The place to do that is in a codec driver. In your setup it'll look
> like this:
>
> That "IC" codec has 2 DAIs and operates as a clock master on both.
> You link one DAI in I2S mode to the bcm2835 and the other DAI
> in DSP (or whatever mode you are using) to the cs42xx8.
>
> If you model it this way you no longer work against ALSA and
> you can stop adding hacks to existing drivers.
>
 From the beginning, I completely agree with you when you take the two 
problems apart:
- for the timing problem : model properly the converter as a codec
- for the encapsulation problem : do the encapsulation / packing with a 
userspace plugin

But when you take the whole together, the plugin part seems completely 
overcomplicated.
As the whole is properly modeled, if we could have a simple solution to 
relax the channel numbers constraint on the I2S on the higher part of 
the stack all will "magically" work with little effort/complexity.

Otherwise, the user-space packer would have to do a lot of more than 
packing :  interact with private machine driver controls to manage all 
the channels and the machine driver will need to forward /translate some 
parts to directly drive the final (cs42xx8) codec. An potentially if 
such hardware continue to pop-up, each machine driver will need it's own 
user-space counterpart.

Packing DSD in PCM (DoP) require zero kernel knowledge and could be 
fully implemented in user-space as we don't change the number of channel 
assumption of the data part of the format. But here, we simply want the 
DSP A data semantic with the I2S hardware bus timing.

I'm a complete newbie to ASoC  but I take part to this tread to learn as 
I hate to see how badly all diy and amateur audio hw are integrated with 
Alsa/ASoC/Linux and so never go upstream. On a professional/commercial 
dev, you would never take this ... convoluted I2S multi channel path.

Emmanuel.
