From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Thu, 20 Jan 2011 21:25:36 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <20110120193013.GL6335@n2100.arm.linux.org.uk>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<201101201800.04289.marek.vasut@gmail.com>
	<20110120175551.GG6335@n2100.arm.linux.org.uk>
	<AANLkTin8UR_1kU=+Dw-O9zHahquGJvBC560nByO=F6YV@mail.gmail.com>
	<20110120193013.GL6335@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikawLY2QcoUdcrF-SmmAbGM1MhzWLZogKb=5VAV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/20 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Jan 20, 2011 at 08:18:10PM +0100, Bj?rn Forsman wrote:
>> [ ? 11.425363] cpufreq-core: saving 518144 as reference value for
>> loops_per_jiffy; freq is 312000 kHz
>> [ ? 11.425523] cpufreq-core: scaling loops_per_jiffy to 1036288 for
>> frequency 624000 kHz
>
> So despite scaling lpj by a factor of two for the doubling in clock
> frequency, we see a 30% error in it?

No. udelay() is ~30 % of what it should be. My gpio + oscilloscope
test showed that udelay(50) => 16 us in real time with cpufreq
enabled. This gives 16/50 = 0.32.

> Is it possible to boot at 624MHz and report the resulting lpj?

I think I need some help doing that. I found some clock setup in
<u-boot-pxa>/arch/arm/cpu/pxa/start.S (OpenPXA tree) but I'm not
familiar with it.

> Alternatively, call calibrate_delay() after the cpufreq switch to
> 624MHz, disabling the 'printed' stuff and see what it reports.

First attempts at moving calibrate_delay() after freq switch failed. I
will try more. Just had to send this so stop the misunderstanding
about how much udelay() is off...

What do you mean by disabling the 'printed' stuff? The cpufreq debug stuff?

Best regards,
Bj?rn Forsman

> I wonder if this is a case where it scales according to
>
> ? ? ? ?new_lpj = ref_lpj * (new_freq / ref_freq) + some_offset
>
> rather than just
>
> ? ? ? ?new_lpj = ref_lpj * (new_freq / ref_freq)
