From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Dec 2012 11:34:37 -0700
Subject: [PATCH 2/5] ARM: tegra20: clocks: add CPU low-power function
 into tegra_cpu_car_ops
In-Reply-To: <1354598707.30563.10.camel@jlo-ubuntu-64.nvidia.com>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-3-git-send-email-josephl@nvidia.com>
 <50BD8646.6070608@nvidia.com>
 <1354598707.30563.10.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <50BF93BD.9090808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 10:25 PM, Joseph Lo wrote:
> On Tue, 2012-12-04 at 13:12 +0800, Prashant Gaikwad wrote:
>> On Monday 03 December 2012 08:30 AM, Joseph Lo wrote:
>>> Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
>>> functions were used for CPU powered-down state maintenance.
>>>
>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>> ---
>>>   arch/arm/mach-tegra/tegra20_clocks.c |  102 ++++++++++++++++++++++++++++++++++
>>>   1 files changed, 102 insertions(+), 0 deletions(-)
>>
>> I have a concern here, I am working on removing these ops and replacing 
>> it with clock.
>> Adding suspend/resume to these will make it more difficult to remove.
>>
>> Any other way to implement this?
>>
> 
> Prashant,
> 
> Thanks for remind.
> Actually the "tegra_cpu_car_ops" is more like reset & suspend/resume
> handling, it's not really related to clock framework. So it's more like
> some functions for CPU power management control. Maybe I can move them
> (Tegra20 & Tegra30) to another pm related file later.
> 
> How do you think, Stephen?

Well, the CAR (Clock And Reset) HW module implements this functionality,
right? As such, the code should be part of the clock driver. The whole
reason we have the car_ops in the first place is so that only the clock
driver touches the clock HW module. I hope we'll eventually do the same
for all HW modules.
