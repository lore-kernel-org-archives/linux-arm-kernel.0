From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 24 Jun 2015 14:26:58 +0530
Subject: [PATCH 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <CALx668UUUCzswiXyM9e4v9fhu6PTXq5DLu_O3swTPhJUjJPBFg@mail.gmail.com>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
 <1433766561-1330-3-git-send-email-pi-cheng.chen@linaro.org>
 <20150622114511.GA28340@linux>
 <CALx668VmT+90y712QO4JQCh-nTCxStWYY+ygJ_1KiVN7VnmmpQ@mail.gmail.com>
 <20150624005759.GA6424@linux>
 <CALx668UUUCzswiXyM9e4v9fhu6PTXq5DLu_O3swTPhJUjJPBFg@mail.gmail.com>
Message-ID: <20150624085658.GF27188@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-06-15, 16:44, Pi-Cheng Chen wrote:
> One reason to put those initialization and resource allocation in probe is
> that it's easier to handle the return value -PROBE_DEFER from clock
> and regulator framework when trying to get clocks and regulators
> consumed by cpufreq driver.

This is the sequence of events if you move these things to ->init().

- your driver's probe()
  -> cpufreq_register_driver()
    -> init()
      -> clk/reg get, failed, return -EPROBE_DEFER

And the failure here will be propagated to probe(). So, it should
work IMHO.

> The other reason is when the whole system is resuming from suspend,
> the other subsystem e.g. i2c on which cpufreq driver depends might not
> ready yet during cpufreq driver initialization. In this case, the cpufreq
> driver will be blocked when trying to get resources e.g. regulator on i2c
> bus, and the whole system will stuck for seconds.

That's something else you must investigate on. This dependency should
be resolved in some other way, I thought DT might have taken care of
such dependencies.

-- 
viresh
