From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 09:16:56 -0600
Subject: [PATCH v3 1/3] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
In-Reply-To: <504F2789.1070006@nvidia.com>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-2-git-send-email-shawn.guo@linaro.org>
 <5049252D.9000802@wwwdotorg.org>
 <20120907025847.GI26709@S2101-09.ap.freescale.net>
 <504A26E4.4070600@wwwdotorg.org>
 <20120910011741.GP26709@S2101-09.ap.freescale.net>
 <504E20BE.8050107@wwwdotorg.org> <504F2789.1070006@nvidia.com>
Message-ID: <504F55E8.3000803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 05:59 AM, Prashant Gaikwad wrote:
> On Monday 10 September 2012 10:47 PM, Stephen Warren wrote:
>> On 09/09/2012 07:17 PM, Shawn Guo wrote:
>>> On Fri, Sep 07, 2012 at 10:55:00AM -0600, Stephen Warren wrote:
>>>> Yes, that does solve the problem (well, with
>>>> s/late_init/late_initcall/).
>>>>
>>>> As you imply, that change wouldn't help if cpu-tegra.c was built as a
>>>> module.
>>> I doubt that.  Have you confirmed it with testing?  When you install
>>> module cpu-tegra, the pcie initialization has been done, right?
>> Never mind, the code can't be built as a module anyway.
>>
>> Aside from that, I misinterpreted your test patch, and thought that it
>> was moving the Tegra cpufreq driver initialization earlier, but it's
>> actually moving it later, and in fact by chance after PCIe
>> initialization, which explains why it solves the issue.
>>
>> I think the root of the problem is that cpufreq is lowering the CPU
>> frequency, yet the patch which converted Tegra to the common clock
>> framework removed the code that actually changes the CPU clock rate. So,
>> cpufreq thinks the CPU is running at e.g. 216MHz, but it's actually
>> still running at 1.0GHz, and hence re-calculating the delay loops breaks
>> things, since delays aren't as long as the system thinks they are. The
>> variability is due to whether lowering the CPU frequency just happens to
>> occur before or after the PCIe controller is initialized.
>>
>> Prashant, are you able to fix the clock driver deficiency within the
>> next 2-3 days or so (so I can include the fix in the pull requests I
>> send for 3.7, which need to be sent before the end of the week)? Or, do
>> we need to disable cpufreq for Tegra because of this?
> 
> Your fix looks good to me except the concern I have mentioned in reply
> to that patch.

Well, the cpufreq driver will need explicit knowledge of
Tega20-vs-Tegra30 anyway, due to e.g. differing CPU clock names,
probable different latencies, etc.
