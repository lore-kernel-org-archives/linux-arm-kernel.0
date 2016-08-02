From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Aug 2016 12:29:49 +0100
Subject: [PATCH 0001/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <20160802103322.13810-1-baolex.ni@intel.com>
References: <20160802103322.13810-1-baolex.ni@intel.com>
Message-ID: <20160802112949.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 06:33:22PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

Sending a huge patch series is always a no-no.  Please:

(a) group the patches according to maintainer
(b) send in smaller chunks, especially when starting off a new cleanup

I'm not sure why I received powerpc and ia64 changes in addition to ARM
changes, I've nothing to do with powerpc and ia64.  In any case, I'm
not going to read each individual mail to find out whether the patch
is something that is relevent or not.

> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  arch/arm/common/bL_switcher.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index 37dc0fe..bd51c35 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -773,7 +773,7 @@ static int bL_switcher_hotplug_callback(struct notifier_block *nfb,
>  }
>  
>  static bool no_bL_switcher;
> -core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
> +core_param(no_bL_switcher, no_bL_switcher, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

This unnecessarily violates the column limit that we have in the coding
style.  It's also a very simplistic conversion from the octal constant
to the definitions.

core_param(no_bL_switcher, no_bL_switcher, bool, S_IRUGO | S_IWUSR);

would be a better way of saying the same thing - see include/linux/stat.h

However, the cleanup of file modes is at best of questionable value.
Octal file modes are something of a Unix standard - see the chmod man
page.  So, I don't see there's even a need to change file modes to
symbolic constants, especially when it means a _lot_ of mail noise.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
