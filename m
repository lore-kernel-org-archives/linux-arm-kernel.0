From: mboards@prograde.net (Michael Cashwell)
Date: Wed, 30 Mar 2011 07:45:28 -0400
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <201103042051.47553.anarsoul@gmail.com>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<201103041816.08109.anarsoul@gmail.com>
	<8C145DA2-AEF8-42AC-A4FB-C93003808D8C@prograde.net>
	<201103042051.47553.anarsoul@gmail.com>
Message-ID: <4AF41E5C-4F6C-4B60-9CAC-59A10AF0B63C@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 4, 2011, at 1:51 PM, Vasily Khoruzhick wrote:

> Can you check if lower freqs work for you with fastbit not set?
> 
>> I've still not been able to identify why this happens (largely since JTAG becomes unresponsive) or find any published errata that I'm not accounting for.
> 
> Maybe this errata is not documented yet? :)

Hi Vasily,

Sorry this took so long. Swamped on another project...

With my local fix for an errata regarding changing memclk during a frequency change (I actually have a lot of local patches to this file) I've found the following table works correctly:

static pxa_freqs_t pxa27x_freqs[] = {
       /* CPU   MEMCLK  CCCR        A   L N2  DIV2         B HT  T     uVmin    uVmax */
       {104000,  52000, PXA27x_CCCR(1,  8, 2), 0, CCLKCFG2(0, 0, 1), 1000000, 1705000 },
       {156000,  52000, PXA27x_CCCR(1,  8, 3), 0, CCLKCFG2(0, 0, 1), 1000000, 1705000 },
       {208000, 104000, PXA27x_CCCR(1, 16, 2), 0, CCLKCFG2(0, 0, 1), 1180000, 1705000 },
       {312000, 104000, PXA27x_CCCR(1, 16, 3), 0, CCLKCFG2(0, 0, 1), 1250000, 1705000 },
       {416000, 208000, PXA27x_CCCR(1, 16, 4), 1, CCLKCFG2(1, 0, 1), 1350000, 1705000 },
       {520000, 208000, PXA27x_CCCR(1, 16, 5), 1, CCLKCFG2(1, 0, 1), 1450000, 1705000 },
       {624000, 208000, PXA27x_CCCR(1, 16, 6), 1, CCLKCFG2(1, 0, 1), 1550000, 1705000 }
};

The 52MHz memclk points aren't listed in the PXA dev manual but I've never been clear if that table is a complete list of all valid points or just a partial listing. At any rate, lowering the SDRAM clock in the low-speed case is certainly within the SDRAM specs, so I went with it.

I've run days of tests and found no more hangs. And when idle at 104MHz instead of the previous stable minimum of 416MHz I'm seeing about a 7% power savings. Everyone was very happy about this.

You could try my data table above or perhaps I need to clean up and actually submit all of my changes in this file as a proper patch.

To that end, I think I've read in Marvel docs that HT should never be used while performing a freq. change. That agrees with the table above since HT is never set. I also note that the Turbo mode (T) is always set as is A (which makes the memclk the same as sysbus).

Is there any point in cluttering the code with options that are not used? If I did submit a real patch wouldn't removing all the T, HT, and A stuff make sense? Just an idea.

-Mike
