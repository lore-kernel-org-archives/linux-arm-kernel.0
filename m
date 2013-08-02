From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 2 Aug 2013 16:09:45 +0800
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <51F6F209.2090309@wwwdotorg.org>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
 <51F6F209.2090309@wwwdotorg.org>
Message-ID: <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-30 at 06:51 +0800, Stephen Warren wrote:
> On 07/26/2013 03:15 AM, Joseph Lo wrote:
> > When the system suspends to LP1, the clock of the CPU would be switched to
> > CLK_M (12MHz Oscillator) during suspend/resume flow. The clock driver
> > needs to restore the clock of CPU after LP1 resume.
> 
> It's unclear to me how the code change implements "restore the clock of
> the CPU". A register name of CCLKG_BURST_POLICY doesn't sound like it's
> anything to do with enabled/disabling the CPU clock, nor configuring its
> rate. What exactly does this register do, and hence what does this new
> code actually restore?
> 
When system suspend to LP1, most of the PLLs was clock gated. Because we
didn't cut off the core power, the settings of PLL still keep there. But
we switch the clock source of CPU to CLK_M before shut off PLLs by
CCLKG_BURSY_POLICY register. So we need to resume it back to original
clock source by CCLKG_BURST_POLICY register. Or it would be keep in low
rate (CLK_M) after resume.

> Why don't Tegra20/30 need a similar change?
For Tegra20/30, the same code had been implemented in the suspend/resume
function of tegra_cpu_car_ops. It restores the CPU clock ASAP when CPU
resume from a suspend state to get quick performance I believe.

For Tegra114, the resume performance is cool (although we can't see it
in upstream kernel now, it still need some other functions.). We can
implement all the clock related suspend/resume function in the clock
driver.
