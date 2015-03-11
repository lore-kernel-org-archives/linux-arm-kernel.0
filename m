From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 10 Mar 2015 17:13:28 -0700
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
Message-ID: <20150311001328.14952.56422@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2015-03-05 03:02:06)
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
> 
> On CPU-freq changes we fire PRE/POST notifiers and they are
> used for updating loops_per_jiffies which then controls delays.
> 
> Now, it is fine to do that for normal frequencies, but what should be
> the approach for intermediate frequencies ?
> 
> Intermediate freqs: On some platforms changing PLL's straight away
> isn't considered safe and so we switch parent to another stable clock,
> change PLL rate and switch back.
> 
> The *wild* thought I earlier had was to fire these notifiers for even these
> intermediate frequencies, otherwise some of the delays will end before
> they should have and that *might* cause other problems.
> 
> I wanted to know what do you (and other champs) think about this..
> 
> Thanks in advance for your advice.

Sorry, I am not who you asked for advice but I will chime in anyways ;-)

I really hate this intermediate frequency stuff in cpufreq. As we
discussed over lunch in Hong Kong, it does not scale. What if there two
intermediate frequencies? What if a processor steps frequency up in 5KHz
increments (albeit very quickly) until it converges to the target rate?

Or what if we have more complex levels of intermediate frequencies?
Stealing Sascha's excellent ascii art:

            ---
CPU_PLL ---|   |
           |   |
           |   |----- CPU
           |   |
IM_PLL ----|   |
            ---

Where the sequence is as follows:

1) set IM_PLL to a new freq
2) reparent CPU to IM_PLL
3) configure CPU_PLL
4) reparent CPU to CPU_PLL
5) restore IM_PLL to original frequency

Steps #1 and #5 are new in this example.

I don't see how the concept of an intermediate frequency in the cpufreq
core could ever scale gracefully to handle corner cases. They may be
hypothetical now but I'd rather see us dodge this mistake.

Furthermore any intermediate-frequency property in a Devicetree binding
would suffer the same fate. Trying to neatly encode some weird sequence
into this generic thing will get very ugly very fast.

For proof please look at clk-divider.c, clk-gate.c, clk-mux.c or
clk-composite.c and you'll see the result of the slow accumulation of
lots and lots of hardware corner cases onto generic code. If I had known
then what I know now I would not have created those generic clock types
and I would have tried for an abstraction layer between generic stuff
(e.g. find the best divider) and the real hardware stuff (write to the
register). Instead I kept all of it together and now things are super
ugly.

Regards,
Mike
