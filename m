From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 02 Aug 2013 14:32:17 -0600
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
 <51F6F209.2090309@wwwdotorg.org>
 <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51FC1751.9010401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 02:09 AM, Joseph Lo wrote:
> On Tue, 2013-07-30 at 06:51 +0800, Stephen Warren wrote:
>> On 07/26/2013 03:15 AM, Joseph Lo wrote:
>>> When the system suspends to LP1, the clock of the CPU would be switched to
>>> CLK_M (12MHz Oscillator) during suspend/resume flow. The clock driver
>>> needs to restore the clock of CPU after LP1 resume.
>>
>> It's unclear to me how the code change implements "restore the clock of
>> the CPU". A register name of CCLKG_BURST_POLICY doesn't sound like it's
>> anything to do with enabled/disabling the CPU clock, nor configuring its
>> rate. What exactly does this register do, and hence what does this new
>> code actually restore?
>>
> When system suspend to LP1, most of the PLLs was clock gated. Because we
> didn't cut off the core power, the settings of PLL still keep there. But
> we switch the clock source of CPU to CLK_M before shut off PLLs by
> CCLKG_BURSY_POLICY register. So we need to resume it back to original
> clock source by CCLKG_BURST_POLICY register. Or it would be keep in low
> rate (CLK_M) after resume.

OK, I guess the register name was badly chosen by HW. I'd like to see
part of your description above in the patch description. How about
replacing the patch description with:

----------
When the system suspends to LP1, the CPU clock source is switched to
CLK_M (12MHz Oscillator) during suspend/resume flow[1]. The CPU clock
source is controlled by the CCLKG_BURST_POLICY register, and hence this
register must be restored during LP1 resume.
----------

[1] Question: where does this happen? This patch doesn't make that
change. I wonder why the suspend path can't save this register, rather
than implementing a separate suspend syscore op in the clock driver.
Does the HW auto-switch the value in the register itself?

>> Why don't Tegra20/30 need a similar change?
>
> For Tegra20/30, the same code had been implemented in the suspend/resume
> function of tegra_cpu_car_ops. It restores the CPU clock ASAP when CPU
> resume from a suspend state to get quick performance I believe.
> 
> For Tegra114, the resume performance is cool (although we can't see it
> in upstream kernel now, it still need some other functions.). We can
> implement all the clock related suspend/resume function in the clock
> driver.

OK, I do see something similar in tegra20/30_cpu_clock_suspend/resume.
Why can't this new code be part of the equivalent functions; does the
Tegra114 suspend/resume code in mach-tegra/ not call
tegra_cpu_car_ops.suspend/resume() in the same way it does on Tegra20/30?
