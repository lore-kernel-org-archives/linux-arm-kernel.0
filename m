From: zonque@gmail.com (Daniel Mack)
Date: Wed, 16 Nov 2011 15:06:46 +0100
Subject: [PATCH] ARM: pxa: add support for Raumfeld DDX
In-Reply-To: <20111116131910.GE29986@opensource.wolfsonmicro.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
 <20111115141348.GG3077@opensource.wolfsonmicro.com>
 <4EC3B30F.60403@gmail.com>
 <20111116131910.GE29986@opensource.wolfsonmicro.com>
Message-ID: <4EC3C376.3040007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2011 02:19 PM, Mark Brown wrote:
> On Wed, Nov 16, 2011 at 01:56:47PM +0100, Daniel Mack wrote:
>> On 11/15/2011 03:13 PM, Mark Brown wrote:
> 
>>> Is this really a single driver?  Looking at the code it looks like
>>> there's little if any code sharing between the different machines, it'd
>>> help with maintainability to have multiple simple drivers.
> 
>> Hmm. This new version of Raumfeld's hardware features a new ADC and DAC,
>> and the configuration to use is determined by looking at the system
>> revision. If this would be split into multiple smaller drivers, there
>> would be need for a 'master' to dispatch the possible options. I think
> 
> No, not really.
> 
>> I'll do that once the next generation is about to land, and leave it as
>> it is for now. Ok for you?
> 
> What I'd expect here is that the arch/arm code would register a
> different platform device depending on which board it's running on
> (though actually controlling I2C device registration is enough as ASoC
> won't probe the sound driver until the components appear).

Ok, I can do this. However, the two driver will share some logic wrt
GPIO lines that put the codecs into reset. But ok, we can live with that
I guess, as it in fact makes the driver smaller and easier to read.

>>>> +	fmt = SND_SOC_DAIFMT_I2S |
>>>> +	      SND_SOC_DAIFMT_NB_NF |
>>>> +	      SND_SOC_DAIFMT_CBS_CFS;
> 
>>> Set this using dai_fmt in hte machine driver.
> 
>> Can you elaborate on this one? I couldn't find an example for this, sorry.
> 
> Look at the snd_soc_dai_link definition, and things like speyside.

Sorry, I still don't get it. All implementations I can find call
snd_soc_dai_set_fmt() for the cpu and codec dais from the
.ops->hw_params function they reference from their snd_soc_dai_links.
Just like this new code does as well. What am I missing?


Thanks for your review,

Daniel
