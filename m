From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Oct 2012 09:38:59 -0500
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <507EC303.1080000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2012 02:07 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Move Tegra's debug-macro.S over to the common debug macro directory.
> 
> Move Tegra's debug UART selection menu into ARM's Kconfig.debug, so that
> all related options are selected in the same place.
> 
> Tegra's uncompress.h is left in mach-tegra/include/mach; it will be
> removed whenever Tegra is converted to multi-platform.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Rob, Arnd, Olof, I'd particularly like feedback on whether the following:
> 
> #include "../../mach-tegra/iomap.h"
> 
> in arch/arm/include/debug/tegra.S is acceptable. I'd really like to
> continue to #include a header to share the defines to Tegra physical
> memory layout and virtual based addresses with Tegra's io.c's struct
> map_desc entries, so they can't get out of sync. So, the include can
> either use the relative path as quoted above (which I don't think will
> cause any significant maintenance issue), or Tegra's iomap.h would have
> to be moved somewhere public so e.g. <tegra-iomap.h> could be included.

We already have a way to get the phys and virt addresses at runtime with
addruart macro. Couldn't we wrap this with a proper function and setup
the mapping at runtime. This would move it out of the platforms.

I'd also like to make the virtual address the same on all platforms (but
different offsets within a 1MB section) and make the phys address a
kconfig option. This would also eliminate the need for the platform
include and potentially addruart for that matter.

Rob
