From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Nov 2014 15:56:30 +0100
Subject: [RFC PATCH] clk: mvebu: armada-xp: Support for MSYS SoC
In-Reply-To: <1416459679-30944-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1416459679-30944-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <20141120155630.743ee6de@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chris Packham,

On Thu, 20 Nov 2014 18:01:19 +1300, Chris Packham wrote:
> The MSYS SoCs are a range of packet processors with integrated CPUs based
> on armada-xp. One difference is that the TCLK frequency is fixed at 200MHz
> as opposed to the fixed 250MHz used on armada-xp. The clock-gating options
> are a subset of what's available on the armada-xp so this code should be
> compatible.

Well, if you have only a subset of what's available, then I would also
suggest to introduce a separate compatible string for the gatable
clocks.

> This patch is enough to get the uart clock dividers correct so I get some
> output. As far as I've been able to tell there is no way of dynamically
> detecting the TCLK frequency.
> 
> The core clock frequency and ratio calculations are probably not correct but
> for these CPU inside a packet processor systems I'm not sure how much that
> actually matter since these systems aren't likely to do any kind of dynamic
> frequency scaling.

Knowing the frequency is not only about dynamic frequency scaling. Some
drivers (i2c, spi, probably sdio) use the input clock frequency, look
at the requested output frequency, and calculate some dividers to reach
the desired output frequency from the input frequency. If your input
frequency is wrong, then your divider calculation will be wrong, and
therefore your output frequency will be wrong. This could lead to
having an incorrect I2C or SPI bus frequency, for example. As you can
see, nothing to do with dynamic frequency scaling.

But indeed, those concerns are more around peripheral clocks, which
normally derive from tclk. Still, it'd be better to not have the core
clocks defined at all rather than having incorrect core clock
frequencies.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
