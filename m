From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Mon, 9 Jan 2017 15:50:42 +0100
Subject: [linux-sunxi] [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
In-Reply-To: <20170109095946.6esbfx6pafega5cd@lukather>
References: <20161125002852.18097-1-megous@megous.com>
 <0985b1ec-ba95-1505-cc59-adec4b88238f@megous.com>
 <20170109095946.6esbfx6pafega5cd@lukather>
Message-ID: <557330d0-2dcd-2211-8538-51c4d6b68834@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Dne 9.1.2017 v 10:59 Maxime Ripard napsal(a):
> On Sat, Jan 07, 2017 at 04:49:18PM +0100, Ond?ej Jirman wrote:
>> Maxime,
>>
>> Dne 25.11.2016 v 01:28 megous at megous.com napsal(a):
>>> From: Ondrej Jirman <megous@megous.com>
>>>
>>> When adjusting PLL_CPUX on H3, the PLL is temporarily driven
>>> too high, and the system becomes unstable (oopses or hangs).
>>>
>>> Add a notifier to avoid this situation by temporarily switching
>>> to a known stable 24 MHz oscillator.
>>
>> I have done more thorough testing on H3 and this approach with switching
>> to 24MHz oscillator does not work. Motivation being that my Orange Pi
>> One still gets lockups even with this patch under certain circumstances.
>>
>> So I have created a small test program for CPUS (additional OpenRISC CPU
>> on the SoC) which randomly changes PLL_CPUX settings while main CPU is
>> running a loop that sends messages to CPUS via msgbox.
>>
>> Assumption being that while CPUS is successfully receiving messages via
>> msgbox, the main CPU didn't lock up, yet.
>>
>> With this I am able to quickly and thoroughly test various PLL_CPUX
>> change and factor selection algorithms.
>>
>> Results are that bypassing CPUX clock by switching to 24 MHz oscillator
>> does not work at all. Main CPU locks up in about 1 second into the test.
>> Don't ask me why.
> 
> You mean that you are changing the frequency behind Linux' back? That
> won't work. There's more to cpufreq than just changing the frequency,
> but also adusting the number of loops per jiffy for the new frequency
> for example. I don't really expect that setup to work even on a
> perfectly stable system. CPUFreq *has* to be involved, otherwise, that
> alone might introduce bugs, and you cannot draw any conclusions
> anymore.

No, this has nothing to do with linux. I'm not running linux for this
test. I'm running a small program on CPUS (Open RISC CPU) on the SoC
loaded using FEL from USB.

The main cpu is just pushing messages into msgbox in a loop, so that
CPUS can determine that the main CPU is still running ok and give
feedback to me over UART. Not even DRAM is involved. The programs are
running from SRAM.

This is the most direct test of PLL change stability that can be done on
this SoC regardless of the OS. Not even CPU voltage switching is
involved. I just set the maximum voltage and fiddle with CPU_PLL
frequencies randomly, while waiting for the main CPU to lock up.

It does lock up quickly with mainline ccu_nkmp_find_best algorithm for
finding factors.

Even with linux kernel, it breaks. It's just more difficult to hit the
right conditions. I got oops only right after boot when running cpuburn
to trigger thermal_zone issued OPP change, if I first run some cpupower
commands. That's why I wrote this program to stress test various CPU_PLL
change/factor selection algorithms independently of everything else, to
get more predictable and quicker testing results.

>> What works is selecting NKMP factors so that M is always 1 and P is
>> anything other than /1 only for frequencies under 288MHz. As mandated by
>> the H3 datasheet. Mainline ccu_nkmp_find_best doesn't respect these
>> conditions. With that I can change CPUX frequencies randomly 20x a
>> second so far indefinitely without the main CPU ever locking up.
>>
>> Please drop or revert this patch. It is not a correct approach to the
>> problem. I'd suggest dropping the entire clock notifier mechanism, too,
>> unless it can be proven to work reliably.
> 
> It has been proven to work reliably on a number of other SoCs.

Unless it was stress tested like this with randomy changed settings, I
doubt you can call it reliable. It may just be very hard to hit the
issue on linux with particular OPP/thermal zone configuration. That's
because the issue is dependent on before and after NKMP values. People
may have just been lucky so far.

regards,
  o.

> Thanks!
> Maxime
> 
