From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jan 2014 13:12:58 +0000
Subject: New randconfig build failure: rx51 asoc / gpiolib
Message-ID: <20140117131257.GB15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last night's omap randconfig found this.  This has only appeared in the
builds in the last few days, so it's a new regression for the changes
queued up for merge window:

sound/soc/omap/rx51.c:220:33: error: array type has incomplete element type
sound/soc/omap/rx51.c:222:3: error: field name not in record or union initializer
sound/soc/omap/rx51.c:222:3: error: (near initialization for 'rx51_av_jack_gpios')
sound/soc/omap/rx51.c:223:3: error: field name not in record or union initializer
sound/soc/omap/rx51.c:223:3: error: (near initialization for 'rx51_av_jack_gpios')
sound/soc/omap/rx51.c:224:3: error: field name not in record or union initializer
...
sound/soc/omap/rx51.c: In function 'rx51_aic34_init':
sound/soc/omap/rx51.c:325:2: error: implicit declaration of function 'snd_soc_jack_add_gpios'
sound/soc/omap/rx51.c:326:89: error: type defaults to 'int' in type name
sound/soc/omap/rx51.c:326:89: error: type defaults to 'int' in type name
sound/soc/omap/rx51.c:326:89: error: negative width in bit-field '<anonymous>'
sound/soc/omap/rx51.c: In function 'rx51_soc_exit':
sound/soc/omap/rx51.c:437:2: error: implicit declaration of function 'snd_soc_jack_free_gpios'
sound/soc/omap/rx51.c:437:120: error: type defaults to 'int' in type name
sound/soc/omap/rx51.c:437:120: error: type defaults to 'int' in type name
sound/soc/omap/rx51.c:437:120: error: negative width in bit-field '<anonymous>'

which is caused by "struct snd_soc_jack_gpio" not being defined.  For
some reason, this structure is defined in sound/soc.h, but is
conditionalised upon CONFIG_GPIOLIB.

This means either the dependencies on SND_OMAP_SOC_RX51 are incorrect
(they don't include a dependency on GPIOLIB) or ASoC is wrong to make
the definitions conditional upon GPIOLIB.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
