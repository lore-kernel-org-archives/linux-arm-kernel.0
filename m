From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jan 2016 12:32:26 +0000
Subject: [Question] cacheline sharing problem on DMA for custom outer-cache
In-Reply-To: <CAK7LNAQBJbjx4koGjkKHo1Xe9NKC-dCj_0TP6AiT=3eaPTYdoQ@mail.gmail.com>
References: <CAK7LNASC2kkgQvxetrRA=guvKTAnxGm3xeMbtV0hXgubR0tEwQ@mail.gmail.com>
 <134552368.ft0oU8iHdY@wuerfel>
 <CAK7LNAQBJbjx4koGjkKHo1Xe9NKC-dCj_0TP6AiT=3eaPTYdoQ@mail.gmail.com>
Message-ID: <20160118123226.GF19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 09:05:15PM +0900, Masahiro Yamada wrote:
> L1_CACHE_BYTES is not a configuration.  It is a hardware property.
> 
> Actually, Tegra is the only hardware that has L1 cache with 64byte line-size.

We have a load of paltforms which select ARM_L1_CACHE_SHIFT_6, plus
Cortex-A8 and Cortex-A15 both have 64-byte L1 line size.

It's all in the git history, please research.

$ git log -p -- arch/arm/Kconfig arch/arm/mm/Kconfig

and search for "ARM_L1_CACHE_SHIFT_6".

> The other SoCs in multi_v7_defconfig run software configured for
> 64byte line-size on CPUs with 32byte line-size.  Weird.

Nothing weird here.  A kernel configured for a 64 byte cache line size
can be run on a system with a 32 byte cache line size, but not vice
versa.

> And, deciding the DMA aligment only with L1 line-size does not seem nice.
> I admit the outer-cache on my SoC is odd, though.

Currently, the L1 defines the biggest restriction on DMA cache line
alignment that we have.  However, you should be wary of changing
only the DMA cache alignment - I think you'll find a lot of things
assume that aligning to L1_CACHE_BYTES will be DMA safe.

> If we could parse "line-size" DT-property in the early stage
> and change the DMA alignment run-time, it would avoid degrading
> performance on other SoCs.

You can't realign data structures in the kernel image at runtime.

L1_CACHE_BYTES is used as a constant in several places for this
purpose.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
