From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Mar 2015 16:34:34 +0530
Subject: [PATCH 1/2] cpufreq: hisilicon: add acpu driver
In-Reply-To: <20150302105025.GA8702@leoy-linaro>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
 <1424956899-8891-2-git-send-email-leo.yan@linaro.org>
 <CAKohpokN3Ljuufv5i+TsoJRanGBVZoqEqF1wmUmCzfGbcPbUZQ@mail.gmail.com>
 <20150302105025.GA8702@leoy-linaro>
Message-ID: <CAKohpok62tCenCwSRxACeWZGwotsm5sm4nTX74Bq6sAXJfZX0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 March 2015 at 16:20, Leo Yan <leo.yan@linaro.org> wrote:
> i'm glad to use more general method, let me give more input so that we
> can see if can figure out a better way. ;)

And I am glad to hear that :)

> 1. From hardware design, during the initialization phase, it will
> bind every opps with its corresponding voltage, and pass these related
> info to power controller. So later, in kernel the cpufreq driver don't
> need manually change the voltage, it will only change the cpu clock
> frequency and power controller will automatically handle voltage
> related operations. This is similar with TC's SPC implementation.
>
> So looks likely the cpufreq-dt driver's voltage related ops are
> redundant for this case.

Its okay, they wouldn't harm. You don't have to specify any regulator
in CPUs DT node and the code will not try any fancy stuff :)

> 2. For hi6220, it has two clusters but w/t coupled clock domain; after
> discussion, the later series SoC will have two clusters with
> dedicated clock domain, so we need support these two cases;

Its okay..

> if support two clusters, arm_big_little.c is also good option; but it
> cannot support coupled clock domain for two clusters; furthermore, the
> cpufreq driver also need enable cooling cell so that it can support
> thermal framework with cpu cooling device.
>
> Do u think it's reasonable to apply upper changes to arm_big_little.c?

Yes it is, but I want you to use cpufreq-dt instead. It supports multi
clusters as well now.

> 3. for the file hisi-acpu-cpufreq.c, actually it's common enough; all
> register's related operations have been encapsulated in clk driver;
> Especially thinking about now have many SoCs have multi-clusters and
> only need change the frequency from clk APIs, do u think it's a good
> idea to change this driver to be a common driver?

Just use cpufreq-dt and you wouldn't be required to make any changes at all..
