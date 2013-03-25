From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Mar 2013 10:12:43 -0600
Subject: [PATCH] clk: tegra: Don't enable PLLs during early boot
In-Reply-To: <20130325110236.GP4977@n2100.arm.linux.org.uk>
References: <1363953308-28828-1-git-send-email-pdeschrijver@nvidia.com>
 <514C7D3B.40602@wwwdotorg.org> <20130325110236.GP4977@n2100.arm.linux.org.uk>
Message-ID: <5150777B.8030304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 05:02 AM, Russell King - ARM Linux wrote:
> On Fri, Mar 22, 2013 at 09:48:11AM -0600, Stephen Warren wrote:
>> This assumption was made long ago. I know drivers are supposed to assume
>> that clocks are disabled when they're probed, but historically that
>> wasn't always the case, so if the audio drivers assumed that, and then
>> did clk_enable() as the first thing, they got a warning due to the
>> enabling an already enabled clock and/or later attempts to disable the
>> clocks wouldn't actually disable them.
> 
> No.  clocks have always been able to be enabled multiple times.  You
> should only get a warning if you try and disable it more times than you
> enabled it, because that's a violation of the API.

That may have been the issue; the clock may have been on at boot, and
hence the driver attempted to disable it without ever enabling it
itself, and this triggered an error/warning.

Equally, it's plausible this issue is long gone; the audio clocks were
set up this way due to issues over 2 years ago when the audio code was
upstreamed. At that time, Tegra's clock code was using very little
standard infra-structure, whereas now it's been cleaned up to use the
common clock framework etc.
