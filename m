From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 17 Jul 2013 18:29:34 +0800
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <51E6701E.2070909@linaro.org>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
 <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
 <51E5A438.10004@wwwdotorg.org>
 <1374056130.10997.16.camel@jlo-ubuntu-64.nvidia.com>
 <51E6701E.2070909@linaro.org>
Message-ID: <1374056974.1000.1.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-17 at 18:21 +0800, Daniel Lezcano wrote:
> On 07/17/2013 12:15 PM, Joseph Lo wrote:
> > On Wed, 2013-07-17 at 03:51 +0800, Stephen Warren wrote:
> >> On 07/16/2013 05:17 AM, Joseph Lo wrote:
> >>> On Tue, 2013-07-16 at 02:04 +0800, Stephen Warren wrote:
> >>>> On 06/25/2013 03:23 AM, Joseph Lo wrote:
> >>>>> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> >>>>> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> >>>>> this state.
> >>> or something can increase
> >>> the loading or make regressions. But I think you are testing with USB
> >>> device attached, right? That might cause some extra loading. You can
> >>> give it a try after just removing USB device. And I double confirm that
> >>> on Seaboard. Except that, the test result looks OK for me.
> >>
> >> Yes, having a USB device plugged in does affect the issue. In summary:
> >>
> >> next-20130716, with or without USB devices plugged in: Works fine.
> >>
> >> next-20130716 with your patches, without USB device plugged in:
> >> Occasional short problems (detailed below).
> >>
> >> next-20130716 with your patches, with USB device plugged in: Continual
> >> long problems (detailed below).
> >>
> >> The testing I did was to log in over the serial console, hit <enter>
> >> around five times, and watch the shell prompt echo back, then type
> >> "ls<enter" and watch the (directory listing appear (I have about 20
> >> files in my directory, with long-ish names), then repeat. With plain
> >> next-20130716, this is nice and fast and there are no pauses. With your
> >> patches applied, there are occasional or continual pauses, which last
> >> for either a short time (tenths of a second), or even a second or two,
> >> both depending on whether a USB device is plugged in or not.
> >>
> >> I believe this is the same issue I saw when I applied your patches to
> >> the Tegra tree on top of v3.11-rc1.
> >>
> > OK. I did more stress tests last night and today. I found it cause by
> > the patch "ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag" and
> > only impact the Tegra20 platform. The hot plug regression seems due to
> > this patch. After dropping this patch on top of v3.11-rc1, the Tegra20
> > can back to normal.
> > 
> > And the hop plug and suspend stress test can pass on Tegra30/114 too.
> > 
> > Can the other two patch series for Tegra114 to support CPU idle power
> > down mode and system suspend still moving forward, not be blocked by
> > this patch?
> > 
> > Looks the CPUIDLE_FLAG_TIMER_STOP flag still cause some other issue for
> > hot plug on Tegra20, I will continue to check this. You can just drop
> > this patch.
> 
> Please in the future Cc me when problems occur with some patches I
> submitted. That would be easier for me to track the issues and fix them
> when they happen.
> 
Ah, sorry for that. I should always Cc you. Will do next time. Thanks
for take care.

Joseph
