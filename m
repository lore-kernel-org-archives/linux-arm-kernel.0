From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 May 2014 10:58:26 -0600
Subject: [PATCH v2 5/6] usb: host: ehci-tegra: Use devm_ioremap_resource
 instead of devm_ioremap
In-Reply-To: <1399723210-21569-6-git-send-email-gautam.vivek@samsung.com>
References: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
 <1399723210-21569-6-git-send-email-gautam.vivek@samsung.com>
Message-ID: <5370FDB2.40704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2014 06:00 AM, Vivek Gautam wrote:
> Using devm_ioremap_resource() API should actually be preferred over
> devm_ioremap(), since the former request the mem region first and then
> gives back the ioremap'ed memory pointer.
> devm_ioremap_resource() calls request_mem_region(), therby preventing
> other drivers to make any overlapping call to the same region.

This patch on its own works OK on Tegra. However, if a similar patch
were to be applied to the Tegra PHY driver, then I expect that would
break USB on Tegra. The reason is that the Tegra USB controller and PHY
registers are interleaved a bit randomly within the same address range,
and rather than call out which individual addresses are relevant to the
controller and the PHY, the DT for both devices just specifies the same
whole range, and the drivers only touch the appropriate registers within
the range. Perhaps we should have described that as an MFD rather than
separate DT nodes and devices, but that's not what we ended up with.
