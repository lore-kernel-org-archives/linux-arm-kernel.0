From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Mar 2017 09:33:32 -0700
Subject: [PATCH v3 0/6] bus: brcmstb_gisb: add support for GISBv7 arbiter
In-Reply-To: <20170330002914.7371-1-opendmb@gmail.com>
References: <20170330002914.7371-1-opendmb@gmail.com>
Message-ID: <c3182c24-2245-cf2e-32e4-248b8046a30f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2017 05:29 PM, Doug Berger wrote:
> This patch set contains changes to enable the GISB arbiter driver
> on the latest ARM64 architecture Set-Top Box chips from Broadcom.
> 
> Since the ARM64 architecture does not support the hooking of low
> level fault handlers the driver has been adjusted to depend solely
> on GISB interrupts and notify events to provide diagnostic
> messaging.  The GISB hardware still triggers bus faults for the
> processor so the default low-level aborts will occur and will be
> handled based on the architecture specific kernel implementation.
> 
> While this tends to obsure the GISB error messaging it is still
> reasonable so the same approach is applied to the ARM architecture
> for consistency.
> 
> The patches also correct some issues with the existing driver
> and add the new register map for the GISBv7 hardware first
> appearing in the BCM7278 device.

This all looks great to me, and since there are no more ARM64
dependencies I can take this via the Broadcom ARM/ARM64 SoC pull requests.

Mark, are you also happy with this v3?

Thanks Doug!

> 
> Changes since v2 at [2]:
>  - Removed code associated with enabling the hooking of ARM64
>    memory faults as well as the code that hooks them for both
>    ARM and ARM64 architectures within the GISB arbiter driver.
>  - Created separate notifiers for die and panic events to
>    prevent list corruption, and substituted the notifier return
>    name for the previous magic number (Thanks Mark!)
> 
> Changes since v1 at [1]:
>  - Removed code associated with hooking SError handling in favor
>    of a registered notifier (Thanks Mark!)
>  - Removed an unnecessary explicit cast (Thanks Gregory!)
> 
> [1] https://lkml.org/lkml/2017/3/24/413
> [2] https://lkml.org/lkml/2017/3/28/1125
> 
> Doug Berger (6):
>   bus: brcmstb_gisb: Use register offsets with writes too
>   bus: brcmstb_gisb: correct support for 64-bit address output
>   bus: brcmstb_gisb: add notifier handling
>   bus: brcmstb_gisb: remove low-level ARM hooks
>   bus: brcmstb_gisb: enable driver for ARM64 architecture
>   bus: brcmstb_gisb: update to support new revision
> 
>  .../devicetree/bindings/bus/brcm,gisb-arb.txt      |   3 +-
>  drivers/bus/Kconfig                                |   2 +-
>  drivers/bus/brcmstb_gisb.c                         | 121 ++++++++++++---------
>  3 files changed, 75 insertions(+), 51 deletions(-)
> 


-- 
Florian
