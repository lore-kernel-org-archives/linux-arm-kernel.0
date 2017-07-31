From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 31 Jul 2017 11:15:57 +0200
Subject: [PATCH] ASoC: improve RT5514 dependencies
In-Reply-To: <20170731083217.4142512-1-arnd@arndb.de>
References: <20170731083217.4142512-1-arnd@arndb.de>
Message-ID: <s5hh8xt0xwy.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Jul 2017 10:30:55 +0200,
Arnd Bergmann wrote:
> 
> With SND_SOC_RT5514_SPI=m and SND_SOC_RT5514=y, we get this link error:
> 
> sound/soc/codecs/rt5514.o: In function `rt5514_dsp_voice_wake_up_put':
> rt5514.c:(.text+0x2068): undefined reference to `rt5514_spi_burst_write'
> rt5514.c:(.text+0x20c8): undefined reference to `rt5514_spi_burst_write'
> 
> This adds another Kconfig symbol to work around the link error, forcing
> the main driver to be a loadable module as well if some other driver
> selects the I2C side to be built-in.
> 
> Fixes: 2a18483a7fb4 ("ASoC: Intel: Add Kabylake machine driver for RT5514, RT5663 and MAX98927")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This can now lead to a configuration with
> SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=y and SND_SOC_RT5514=m. I
> don't know if that is a problem or not.
> 
> An alternative approach would be to flip the dependency between
> rt5514_spi.ko and rt5514.ko and avoid having the rt5514_spi_burst_write
> symbol exported.

The current usage of 
  #if defined(CONFIG_SND_SOC_RT5514_SPI)
in rt5514_dsp_voice_wake_up_put() is already broken.  We need the fix
in anyway.

IMO, flipping the dependency looks saner to me.  The SPI function call
is a kind of add-on, after all.


thanks,

Takashi
