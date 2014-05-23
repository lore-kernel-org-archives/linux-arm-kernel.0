From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 May 2014 11:54:31 +0200
Subject: [PATCH 1/2] doc: dt bindings: Document Odroid X2/U3 audio
 subsystem bindings
In-Reply-To: <20140522184656.GS12304@sirena.org.uk>
References: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
 <20140522184656.GS12304@sirena.org.uk>
Message-ID: <537F1AD7.1070808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/14 20:46, Mark Brown wrote:
> On Thu, May 22, 2014 at 01:55:07PM +0200, Sylwester Nawrocki wrote:
> 
>> +	sound {
>> +		compatible = "samsung,odroidx2-audio";
>> +		samsung,i2s-controller = <&i2s0>;
>> +		samsung,audio-codec = <&max98090>;
>> +	};
> 
> Can this not use simple-card?

I dug into that and it seems it almost could, but there is one
thing I'm not sure how to cover with the simple-card DT bindings
and the related driver.

There are these two calls:

+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
+					0, MOD_OPCLK_PCLK);


+	/* Set the cpu DAI configuration in order to use CDCLK */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
+					0, SND_SOC_CLOCK_OUT);

This changes clocks routing so that the CPU DAI in slave mode generates
master clock for the codec, on the SoC's CDCLK pin. Then this is
a reference clock for the codec's PLL, which is a source of the I2S
interface clocks.

It's done this way to avoid changing at runtime frequency of the EPLL
clock, which may be parent of other clocks than the sound subsystem,
e.g. MMC.

simple-card just calls set_sysclk once for the CPU DAI and CODEC with
the second and last argument set to 0.
I'll try and see again if there is some way to use simple-card.

-- 
Thanks,
Sylwester
