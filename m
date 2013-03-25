From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Mar 2013 11:02:36 +0000
Subject: [PATCH] clk: tegra: Don't enable PLLs during early boot
In-Reply-To: <514C7D3B.40602@wwwdotorg.org>
References: <1363953308-28828-1-git-send-email-pdeschrijver@nvidia.com>
 <514C7D3B.40602@wwwdotorg.org>
Message-ID: <20130325110236.GP4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 09:48:11AM -0600, Stephen Warren wrote:
> This assumption was made long ago. I know drivers are supposed to assume
> that clocks are disabled when they're probed, but historically that
> wasn't always the case, so if the audio drivers assumed that, and then
> did clk_enable() as the first thing, they got a warning due to the
> enabling an already enabled clock and/or later attempts to disable the
> clocks wouldn't actually disable them.

No.  clocks have always been able to be enabled multiple times.  You
should only get a warning if you try and disable it more times than you
enabled it, because that's a violation of the API.

Consider two drivers sharing the same input clock.  If one driver
disables the clock more times than it enables it, then it's treading
on the other drivers need to have the clock enabled.
