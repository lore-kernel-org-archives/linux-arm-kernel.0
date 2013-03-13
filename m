From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 13 Mar 2013 14:04:04 +0800
Subject: [PATCH V2 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <513F82EB.1030407@wwwdotorg.org>
References: <1363060916-8897-1-git-send-email-josephl@nvidia.com>
 <513F82EB.1030407@wwwdotorg.org>
Message-ID: <1363154644.3998.140.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 03:32 +0800, Stephen Warren wrote:
> On 03/11/2013 10:01 PM, Joseph Lo wrote:
> > This series introduces a basic functionality for Tegra to support the
> > platform suspend and resume.
> > 
> > Note: This series only adds the support for Tegra20 and Tegra30. The
> > Tegra114 will be supported later.
> 
> Aside from the few issues that have already been pointed out, this looks
> OK now. I have a couple questions:
> 
> 1) Please remind me if this series depends on anything. If not, I hope
> to apply it mostly directly on top of 3.9-rc1 or so.
> 
There is a patch that you just re-post to linux-mmc tree (mmc: tegra:
use mmc_of_parse to get the support of standard MMC DT bindings). This
series need the patch to make sure everything work.

> 2) You mentioned that Tegra114 isn't supported. What is the failure mode
> on Tegra114? Is suspend simply not available and hence can't be
> requested, or will suspend attempts gracefully return an error, or will
> there we crashes, boot failures, etc.?
> 
Because the DT of Tegra114 didn't describe any PMC suspend information.
So the driver will prevent to register any platform suspend ops. The
result will something like below.

Tegra114 > echo mem > /sys/power/state
write error: No such device

> 3) Sorry for asking this again, but since only LP2 is actually
> implemented in patch 4, what happens if the user selects LP0 or LP1?
> Does the system (a) just use LP2, (b) fail to suspend, and hence
> immediately resume, (c) suspend, but can't be resumed, ...?
> 
Ah. I didn't add any protection here. It will be (c) due the LP2 mask. I
will add a protection in next version. Thanks for remind.

BTW, I want to mention one thing about PMC DT bindings. Because I can't
add all of the PMC DT bindings in one time, the PMC is related to too
many devices to work for runtime PM and power domain control. And some
wake up sources control for deep sleep mode (LP0). They are still under
developing for upstream. May I add more bindings for PMC later?

Thanks,
Joseph
