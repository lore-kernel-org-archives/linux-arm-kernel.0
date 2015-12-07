From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2015 15:01:43 +0000
Subject: [PATCH 0/4] Component helper updates
In-Reply-To: <20151123160210.GR8644@n2100.arm.linux.org.uk>
References: <20151123160210.GR8644@n2100.arm.linux.org.uk>
Message-ID: <20151207150143.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given the lack of interest in these patches, I've put these into my
"for-next" branch so that they can get some exposure in linux-next.

On Mon, Nov 23, 2015 at 04:02:11PM +0000, Russell King - ARM Linux wrote:
> Greg,
> 
> These four patches update the component helper by:
> * Removing the legacy matching code with the .add_components method
>   in the master's operation structure.  Nothing in -rc1 appears to be
>   using the legacy functions or method, according to my git greps.
> 
> * A slight code reorganisation which results in slightly easier to read
>   code.
> 
> * Switch to tracking components via an array rather than a list, which
>   allows us to keep the matching and matched components together, and
>   more importantly allows us to reduce the amount of matching - with
>   this structure, we can incrementally add the component devices as
>   they become available, rather than re-running the list of matches
>   each time something changes.
> 
> * Fix the lack of match release functionality, which Liviu Dudau
>   reminded me was missing.  This allows people who want to pass
>   device_node structures in to (correctly) retain the reference to the
>   node, and drop the node when the need to do matches is no longer
>   required.
> 
> The first three patches have been well tested over the last year as I've
> had them in my tree that long.  I hadn't considered them important enough
> to send as they're only removing and cleaning up functionality.  However,
> with the need to fix something, it now makes sense to get them merged.
> 
> The last patch has been tested with etnaviv DRM to prove that the match
> release works by unloading the module.  On unload, the release function
> is correctly called.
> 
> This is intended for the next merge window.  Please apply.
> 
>  drivers/base/component.c  | 281 ++++++++++++++++++++++++----------------------
>  include/linux/component.h |  33 ++++--
>  2 files changed, 167 insertions(+), 147 deletions(-)
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
