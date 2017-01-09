From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Jan 2017 10:59:46 +0100
Subject: [linux-sunxi] [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
In-Reply-To: <0985b1ec-ba95-1505-cc59-adec4b88238f@megous.com>
References: <20161125002852.18097-1-megous@megous.com>
 <0985b1ec-ba95-1505-cc59-adec4b88238f@megous.com>
Message-ID: <20170109095946.6esbfx6pafega5cd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 04:49:18PM +0100, Ond?ej Jirman wrote:
> Maxime,
> 
> Dne 25.11.2016 v 01:28 megous at megous.com napsal(a):
> > From: Ondrej Jirman <megous@megous.com>
> > 
> > When adjusting PLL_CPUX on H3, the PLL is temporarily driven
> > too high, and the system becomes unstable (oopses or hangs).
> > 
> > Add a notifier to avoid this situation by temporarily switching
> > to a known stable 24 MHz oscillator.
> 
> I have done more thorough testing on H3 and this approach with switching
> to 24MHz oscillator does not work. Motivation being that my Orange Pi
> One still gets lockups even with this patch under certain circumstances.
> 
> So I have created a small test program for CPUS (additional OpenRISC CPU
> on the SoC) which randomly changes PLL_CPUX settings while main CPU is
> running a loop that sends messages to CPUS via msgbox.
> 
> Assumption being that while CPUS is successfully receiving messages via
> msgbox, the main CPU didn't lock up, yet.
> 
> With this I am able to quickly and thoroughly test various PLL_CPUX
> change and factor selection algorithms.
> 
> Results are that bypassing CPUX clock by switching to 24 MHz oscillator
> does not work at all. Main CPU locks up in about 1 second into the test.
> Don't ask me why.

You mean that you are changing the frequency behind Linux' back? That
won't work. There's more to cpufreq than just changing the frequency,
but also adusting the number of loops per jiffy for the new frequency
for example. I don't really expect that setup to work even on a
perfectly stable system. CPUFreq *has* to be involved, otherwise, that
alone might introduce bugs, and you cannot draw any conclusions
anymore.

> What works is selecting NKMP factors so that M is always 1 and P is
> anything other than /1 only for frequencies under 288MHz. As mandated by
> the H3 datasheet. Mainline ccu_nkmp_find_best doesn't respect these
> conditions. With that I can change CPUX frequencies randomly 20x a
> second so far indefinitely without the main CPU ever locking up.
> 
> Please drop or revert this patch. It is not a correct approach to the
> problem. I'd suggest dropping the entire clock notifier mechanism, too,
> unless it can be proven to work reliably.

It has been proven to work reliably on a number of other SoCs.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170109/e1fe005b/attachment.sig>
