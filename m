From: kernel@martin.sperl.org (Martin Sperl)
Date: Sun, 10 Jan 2016 13:17:17 +0100
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <20160110115858.GV6588@sirena.org.uk>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
 <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
 <20160110115858.GV6588@sirena.org.uk>
Message-ID: <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.01.2016, at 12:58, Mark Brown <broonie@kernel.org> wrote:
> 
> On Sun, Jan 10, 2016 at 11:55:48AM +0100, Martin Sperl wrote:
> 
>> So if someone with a better idea how to keep those dt-binding includes
>> synchronized with the definitions used by the code step forward and
>> propose a better solution how to get that implemented?
> 
>> I guess there will be a few more occurrences of clocks that are
>> currently not defined, which will need to get introduced in the future
>> PWM and PCM were just the last in this series.
> 
> Presumably just making the code not rely on having a define for the
> number of clocks would deal with the problem (eg, using ARRAY_SIZE
> internally).
ARRAY_SIZE would work fine, but the code is: 

#include <dt-bindings/clock/bcm2835.h>
...
struct bcm2835_cprman {
	struct device *dev;
	void __iomem *regs;
	spinlock_t regs_lock;
	const char *osc_name;

	struct clk_onecell_data onecell;
	struct clk *clks[BCM2835_CLOCK_COUNT];
};
...
static int bcm2835_clk_probe(struct platform_device *pdev)
{
...
	clks[BCM2835_PLLA_CORE] =
		bcm2835_register_pll_divider(cprman, &bcm2835_plla_core_data);
...
        clks[BCM2835_CLOCK_PCM] =
                bcm2835_register_clock(cprman, &bcm2835_clock_pcm_data);
...
}

So the Array size is defined by the dt-bindings.

What you propose is a major change to the clock framework, so I would
hope that Eric (the original author of this clock-driver) would address
it.

Maybe someone has a better idea for a pattern to use to achieve 
the required while maintaining ?synchronization? between defines
inside the dt-binding and the driver.
