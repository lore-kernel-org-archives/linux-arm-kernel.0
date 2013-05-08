From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 08 May 2013 17:11:25 +1200
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5189DE7D.7060205@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/13 10:53, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Many USB host drivers contain code such as:
>
> if (!pdev->dev.dma_mask)
>          pdev->dev.dma_mask = &tegra_ehci_dma_mask;
>
> ... where tegra_ehci_dma_mask is a global. I suspect this code originated
> in commit 4a53f4e "USB: ehci-tegra: add probing through device tree" and
> was simply copied everywhere else.
>
> This works fine when the code is built-in, but can cause a crash when the
> code is in a module. The first module load sets up the dma_mask pointer,
> but if the module is removed and re-inserted, the value is now non-NULL,
> and hence is not updated to point at the new location, and hence points
> at a stale location within the previous module load address, which in
> turn causes a crash if the pointer is de-referenced.
>
> The simplest way of solving this seems to be to copy the code from
> ehci-platform.c, which uses the coherent_dma_mask as the target for the
> dma_mask pointer.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
In the case of uhci-platform you would be absolutely correct. I copied the
example from tegra when we first had the problem on arch-vt8500.Because we
have no NAND support yet, I have always booted myrootfs from USB so it's
always been builtin and the problem wasnever a problem. The same problem 
would
have existed on ehci-vt8500 but Arnd replaced it with ehci-platform due to
the multiplatform issues.

for uhci-platform.c
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony P
