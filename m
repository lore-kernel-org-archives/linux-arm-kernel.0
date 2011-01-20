From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jan 2011 19:30:13 +0000
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <AANLkTin8UR_1kU=+Dw-O9zHahquGJvBC560nByO=F6YV@mail.gmail.com>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<201101201800.04289.marek.vasut@gmail.com>
	<20110120175551.GG6335@n2100.arm.linux.org.uk>
	<AANLkTin8UR_1kU=+Dw-O9zHahquGJvBC560nByO=F6YV@mail.gmail.com>
Message-ID: <20110120193013.GL6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 08:18:10PM +0100, Bj?rn Forsman wrote:
> [   11.425363] cpufreq-core: saving 518144 as reference value for
> loops_per_jiffy; freq is 312000 kHz
> [   11.425523] cpufreq-core: scaling loops_per_jiffy to 1036288 for
> frequency 624000 kHz

So despite scaling lpj by a factor of two for the doubling in clock
frequency, we see a 30% error in it?

Is it possible to boot at 624MHz and report the resulting lpj?
Alternatively, call calibrate_delay() after the cpufreq switch to
624MHz, disabling the 'printed' stuff and see what it reports.

I wonder if this is a case where it scales according to

	new_lpj = ref_lpj * (new_freq / ref_freq) + some_offset

rather than just

	new_lpj = ref_lpj * (new_freq / ref_freq)
