From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 Jan 2018 11:58:41 +0100
Subject: [PATCH v3 02/12] clk: sunxi-ng: Change formula for NKMP PLLs
In-Reply-To: <20180117201421.25954-3-jernej.skrabec@siol.net>
References: <20180117201421.25954-1-jernej.skrabec@siol.net>
 <20180117201421.25954-3-jernej.skrabec@siol.net>
Message-ID: <20180118105841.73rwj3he2exd7pno@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 17, 2018 at 09:14:11PM +0100, Jernej Skrabec wrote:
> This commit changes formula from this:
> 
> Freq = (parent_freq * N * K) / (M * P)
> 
> to this:
> 
> Freq = (parent_freq / M) * N * K / P
> 
> This improves situation when N is in the range 1-255. PLL parent clock
> is almost always 24 MHz, which means that for N >= 180 original formula
> overflows and result becomes useless. Situation can be improved if M is
> used as predivider as it can be seen in the second formula. That way at
> least M > 1 is considered, but it still leaves small gap for wrong result
> when M = 1 and N >= 180.
> 
> Using M as predivider shouldn't cause any issue, because it is in range
> 1-4 at most, so there is no or only minimal rounding error.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

I'd really prefer to stick to the formula documented and that we've
used so far. NKMP clocks are most notably used for the CPU PLLs and
I've debugged way too many cpufreq bugs already :)

What about using long long types for the parent * n * k result?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/42be1c02/attachment.sig>
