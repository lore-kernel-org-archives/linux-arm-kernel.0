From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 14:23:08 -0700
Subject: [PATCH v3 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
In-Reply-To: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <5123ED3C.3080900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 04:35 AM, Philipp Zabel wrote:
> The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
> 
> The following patches add a simple API for devices to request being reset
> by separate reset controller hardware and implements the reset signal
> device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
> the i.MX SRC contains self-deasserting reset registers, so I've included
> both ops to manually assert/deassert a reset line, as well as a "reset"
> operation that is supposed to assert the reset line and wait for it to
> deassert.

One note here: Even though Tegra HW doesn't have auto-clear reset
hardware, I'd still tend to prefer that most Tegra drivers use a single
"assert then deassert" API to keep knowledge of the reset mechanisms out
of the individual drivers. Our reset driver would manually assert, sleep
a short time, de-assert within the implementation. Still, a few drivers
do need a bit more control (e.g. PCIe and powergating) so having the
other APIs around is useful too.
