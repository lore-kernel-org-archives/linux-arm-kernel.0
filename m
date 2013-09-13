From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 21:53:58 +0530
Subject: [PATCH 195/228] cpufreq: kirkwood: remove calls to
 cpufreq_notify_transition()
In-Reply-To: <20130913161820.GM19363@lunn.ch>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <0a512914fd48b2d6db685446f88b9a096eff79a1.1379063063.git.viresh.kumar@linaro.org>
 <20130913161820.GM19363@lunn.ch>
Message-ID: <CAKohpo=7FbGkq=vQLjoha3yxvKZomsgLdvf+SMYnPt4jsSk67Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2013 21:48, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Sep 13, 2013 at 06:32:21PM +0530, Viresh Kumar wrote:
>
>> -     if (freqs.old != freqs.new) {
>> -             local_irq_disable();
>> -
>> -             /* Disable interrupts to the CPU */
>> -             reg = readl_relaxed(priv.base);
>> -             reg |= CPU_SW_INT_BLK;
>> -             writel_relaxed(reg, priv.base);
>> -
>> -             switch (state) {
>> -             case STATE_CPU_FREQ:
>> -                     clk_disable(priv.powersave_clk);
>> -                     break;
>> -             case STATE_DDR_FREQ:
>> -                     clk_enable(priv.powersave_clk);
>> -                     break;
>> -             }
>
> Hi Viresh
>
> I see you removed the test that the old and the new frequency are
> different. Is this guaranteed by the core? Because if not, you can
> lockup the CPU. The call to cpu_do_idle() will never return.

Yes, that's guaranteed by core: patch 181..
