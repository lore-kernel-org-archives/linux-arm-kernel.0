From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 10:36:56 +0000
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <CAKohpo=90YH3TLfnMro0AQOM6_uMB_SPS9Q3j6Myz4RqqBdVHg@mail.gmail.com>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
 <20150305091948.GH11010@pengutronix.de>
 <CALx668X2m0hMVQumGQmhhrKnv4h1hiYp20Q4FcKuECK3mhoJiA@mail.gmail.com>
 <20150305105104.GJ11010@pengutronix.de>
 <CAKohpo=90YH3TLfnMro0AQOM6_uMB_SPS9Q3j6Myz4RqqBdVHg@mail.gmail.com>
Message-ID: <20150312103655.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 04:32:06PM +0530, Viresh Kumar wrote:
> On 5 March 2015 at 16:21, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Given the variance of different SoCs I don't think it makes sense
> > to try to handle all these cases. Instead the cpufreq-dt driver
> > should just call clk_set_rate() on the CPU clock with the desired
> > target frequency. Everything else should be handled in the clock
> > driver which has intimate knowledge about the SoC anyway.
> 
> I agree..
> 
> @Russell: I wanted to ask you this since sometime..

Remember that I've been "away" from mail for several days last week, as
I had widely published on google+ and on the lists.

> On CPU-freq changes we fire PRE/POST notifiers and they are
> used for updating loops_per_jiffies which then controls delays.

Their main purpose is to allow drivers to shut down their peripherals
before the change and bring them back up after the change on SoCs where
the peripherals are clocked off the CPU clock or a derivative of it.

For example, SA11x0 SoCs were never actually designed for CPU frequency
scaling, but we made it work - and in doing so, you have to reprogram a
bunch of peripherals such as PCMCIA timings, LCD controller, and SDRAM
controller - and because of the need to quiesce the SDRAM controller
over the transition, we need to shut down anything which may cause RAM
to be accessed (such as DMA.)

> Now, it is fine to do that for normal frequencies, but what should be
> the approach for intermediate frequencies ?

I don't think so - calling the notifiers can be expensive where peripheral
drivers are involved - peripherals may need to wait for the hardware to
quiesce before they can allow the notifier to continue.  You could make
it a different reason code (so that drivers such as the SA11x0 stuff can
ignore these intermediate steps.)

> The *wild* thought I earlier had was to fire these notifiers for even
> these intermediate frequencies, otherwise some of the delays will end
> before they should have and that *might* cause other problems.

The real answer is not to use the software delay at all when cpufreq is
enabled, and use a timer based delay which is then independent of the
CPU clock rate.

The only case where a software delay is acceptable is as a last resort
fallback if the platform has no other option, or the CPU clock is
stable.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
