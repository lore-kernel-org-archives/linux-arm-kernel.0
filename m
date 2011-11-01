From: alan@linux.intel.com (Alan Cox)
Date: Tue, 1 Nov 2011 12:18:51 +0000
Subject: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
In-Reply-To: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
References: <samsung_rs485>
	<1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
Message-ID: <20111101121851.7d393277@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +config SAMSUNG_HAS_RS485
> +	bool "Enable RS485 support for Samsung"
> +	depends on SERIAL_SAMSUNG && (MACH_CONDOR2440 ||
> MACH_CONDOR2416 || MACH_MINI2440)
> +	default y if (MACH_CONDOR2440 || MACH_CONDOR2416)
> +	default n if (MACH_MINI2440)

There really needs to be more ARM thinking about doing this sort of
stuff at runtime. If you can detect the board type at runtime then you
need to be moving towards kicking board specifics out of the depends,
and treating it as an "include support for this, if the board has it"
so you can move towards less build time only configuration.

> +/* FIXME */
> +	#if 0
> +	if (last_state != en) {
> +

So this doesn't look ready to submit either...


> +		if ((utrstat & S3C2410_UTRSTAT_TXE) ? 1 : 0) {
> +			if (cfg->gpio_transmit_en > -1) {
> +
> gpio_set_value(cfg->gpio_transmit_en, 0);
> +			}

Lots of excess brackets (see CodingStyle) - removing a few of the
excess ones would make it easier to read later.

The later bits become a real mess of ifdefs - much not your fault, the
combination of your ifdefs and existing lack of design push it beyond
ugly and really want addressing.
