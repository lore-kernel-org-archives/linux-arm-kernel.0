From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 01 Sep 2009 21:25:20 -0500
Subject: Montreal Linux Power Management Mini-Summit, July 13, 2009 -
	Meeting Notes
In-Reply-To: <63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
Message-ID: <4A9DD790.50302@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> I've felt a need for clock notifiers and we've cheated by using
> CPUfreq because it so happens that the clocking in system-wide
> and whenever the CPU freq change so may the other clocks.
>
> But if I put code into a PrimeCell MMC/SPI/I2C driver or whatever and
> use CPUfreq that's very unelegant, and for other platforms where
> the CPU freq don't change when this particular device clk freq
> change plain misleading.
>
> A clk pre/postchange notifier pair would really help and would
> make for elegant drivers that can handle clock freq transitions.
>   

A lot of ARM chips have peripherals that are driven by PLLs that run 
quasi-independently of the CPU clock.

If I guess correctly at what is being described above, a notifier chain 
for the users of a clock would be a clean way for peripherals to deal 
with clock speed *and* CPU speed changes, indeed.  A clock source that 
was affected by cpufreq would place itself on the cpufreq notifier 
chain, and also provide a notifier chain for peripherals that are driven 
by that clock.  When a cpufreq notification arrived, if the clock 
couldn't adjust for the cpufreq change it would use its notifier chain 
to tell all downstream peripherals about it.

A lot of peripherals could then focus just on the clock notifier chain, 
and would no longer care about cpufreq.  I like it.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
