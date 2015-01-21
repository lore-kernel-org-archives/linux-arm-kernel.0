From: tj@kernel.org (Tejun Heo)
Date: Wed, 21 Jan 2015 11:25:23 -0500
Subject: next-20150120 broken on Tegra by "ata: libahci: Allow using
 multiple regulators"
In-Reply-To: <20150121155519.GA25166@ulmo.nvidia.com>
References: <alpine.DEB.2.02.1501210003010.5450@utopia.booyaka.com>
 <20150121105001.GA9921@ulmo.nvidia.com>
 <20150121123134.GD8684@htj.dyndns.org>
 <20150121155519.GA25166@ulmo.nvidia.com>
Message-ID: <20150121162523.GE8684@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 04:55:21PM +0100, Thierry Reding wrote:
> From a4f78e3ec05f1b2ad86aa44d6bd5394d75a23a06 Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Wed, 21 Jan 2015 11:50:52 +0100
> Subject: [PATCH] ata: libahci: Fix devres cleanup on failure
> 
> Commit c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
> releases regulators during ahci_platform_put_resources(). That doesn't
> work because the function is run as part of the devres machinery. Such
> resources are torn down in reverse order. Since the array that holds
> pointers to the regulators is allocated using devres after the device
> context to which ahci_platform_put_resources() is attached, the memory
> will be freed before calling ahci_platform_put_resources() and thereby
> causing a use-after-free error.
> 
> This commit fixes this by using regular allocations for the array. The
> memory can then be freed after the regulators have been released. This
> conserves the advantages of using the managed API.
> 
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to libata/for-3.20.

Thanks.

-- 
tejun
