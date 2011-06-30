From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jun 2011 15:57:12 +0200
Subject: [PATCH 1/5] ASoC: wm8731: rework power management
In-Reply-To: <20110629171148.GB10798@opensource.wolfsonmicro.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
	<ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<20110629171148.GB10798@opensource.wolfsonmicro.com>
Message-ID: <4E0C80B8.7030006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/06/2011 19:11, Mark Brown :
> On Wed, Jun 29, 2011 at 08:00:15PM +0200, Nicolas Ferre wrote:
> 
> Don't mix multiple changes into a single patch!  There's no perceptible
> code overlap between these so I don't understand why you've merged them,
> it just makes review harder and the changelog less descriptive.

Ok.

>> - preserve crystal oscillator across suspend/resume sequence:
>>   enabled by default, it should be kept enabled on resume.
> 
> This isn't what your code does...
> 
>>  		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
>> -		snd_soc_write(codec, WM8731_PWR, 0xffff);
>> +		/* standby: keep crystal oscillator enabled */
>> +		snd_soc_write(codec, WM8731_PWR, 0x00df);
> 
> This doesn't keep the crystal oscillator enabled, this forces it on in
> suspend (and without looking at the datasheet it also changes way more
> than the one register bit I'd expect to be changed).  If the system
> isn't using the oscillator then that's not good.
> 
> I'd expect to see a change to using snd_soc_update_bits() based on your
> description, or more likely something more involved.

First of all, I experienced issues while not having OSC enabled during suspend/resume cycle. Am I right supposing that, if using oscillator to clock the codec, I have to keep it running during a suspend/resume cycle?

Is something like this sounds like an acceptable option or we need something more sophisticated?

@@ -481,7 +481,10 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
                break;
        case SND_SOC_BIAS_OFF:
                snd_soc_write(codec, WM8731_ACTIVE, 0x0);
-               snd_soc_write(codec, WM8731_PWR, 0xffff);
+               reg = 0xdf;
+               if (wm8731->sysclk_type == WM8731_SYSCLK_XTAL)
+                               reg |= 1 << 0x5;
+               snd_soc_update_bits(codec, WM8731_PWR, 0x00ff, reg);
                regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
                                       wm8731->supplies);
                break;

And, yes, there is only 8 bits dedicated to power down control in this register.

Best regards,
-- 
Nicolas Ferre
