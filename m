From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Nov 2010 16:39:05 +0100
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <20101124141623.GH24970@rakim.wolfsonmicro.main>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
	<20101124141623.GH24970@rakim.wolfsonmicro.main>
Message-ID: <4CED3199.2040700@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Wed, Nov 24, 2010 at 03:09:25PM +0100, Sebastian Andrzej Siewior wrote:
> 
>> I've been pointed out to this commit but I don't understand _why_.
>> The part I don't get is "so it can be used with cpufreq". Is it
>> refered to a driver or the subsystem as it?
> 
> We need the regulators for the CPU rails to start before the cpufreq
> driver starts so cpufreq can talk to them, and since the regulators may
> be SPI attached this means we also need the SPI controller to start
> before cpufreq.  cpufreq starts at vanilla init time.

After digging through the code I think I've found it. pxa_cpu_init()
registers a cpufreq client. cpufreq calls init and pxa then
regulator_get() to get the regulator and I guess this is the problem.
So I would suggest to defer pxa_cpu_init() via late_initcall().

The other way around will force you to hack the init code for various
drivers to make it work.

Sebastian
