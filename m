From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Apr 2013 12:27:29 +0200
Subject: [PATCH 2/4] arm64: Initial defconfig for APM X-Gene SOC family
In-Reply-To: <CAPrCYkcc8owdKPUth2uDwugfjKV3i2MY9XHwbqCvn8UOL5s+6Q@mail.gmail.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <2165570.9Zy5vrhoIa@wuerfel>
 <CAPrCYkcc8owdKPUth2uDwugfjKV3i2MY9XHwbqCvn8UOL5s+6Q@mail.gmail.com>
Message-ID: <201304201227.29341.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 April 2013, Vinayak Kale wrote:

> Okay. What would be the good place to change CONFIG_NR_CPUS - a)
> defcofig or b) arch/arch64/Kconfig?
> Currently default value 4 is defined in Kconfig. I reckon this would
> eventually be set to a highest number of CPUs implemented by a soc
> among all the socs.

I think Kconfig would be best. Since this is a setting that is fundamentally
tied to the largest system you want to run on, you can do it like this:

config NR_CPUS
        int "Maximum number of CPUs (2-256)"
        range 2 256
        depends on SMP
	# These have to remain sorted largest to smallest
	default "64" if XGENE
	default "16" if FOO
        default "4"

If you enable XGENE in defconfig, it will automatically get the appropriate
default here, and someone who does not care about XGENE will ge the next
smaller number he or she is building for.

	Arnd
