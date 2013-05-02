From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 May 2013 21:06:27 +0300
Subject: Latest build results - errors/warnings - lots of them
In-Reply-To: <51829D65.7040109@ti.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <20130502082218.GA21614@n2100.arm.linux.org.uk>
 <20130502153834.GR28721@atomide.com> <51829D65.7040109@ti.com>
Message-ID: <20130502180627.GA10672@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 02, 2013 at 01:07:49PM -0400, Eduardo Valentin wrote:
> Arnd, Tony,
> 
> On 02-05-2013 11:38, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [130502 01:27]:
> >> On Tue, Apr 30, 2013 at 09:17:39AM +0100, Russell King - ARM Linux wrote:
> >>> Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> >>> great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> >>> arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> >>> source of errors.
> >>>
> >>> OMAP stuff needs a serious look at too - much Kconfig madness there
> >>> caused by over-use of select, which then goes on to cause build errors
> >>> because it assumes some stuff is always enabled.
> >>>
> >>> There's also warnings about of_device_id from include/linux/of_platform.h
> >>> via from arch/arm/kernel/setup.c which feature in all the non-OF builds
> >>> too which need addressing.
> >>>
> >>> See todays http://www.arm.linux.org.uk/developer/build/ results for all
> >>> the details and configs.  Not pushing my tree until some of this stuff
> >>> gets fixed.
> >>
> >> And now we have a new bunch of warnings from OMAP stuff which weren't
> >> previously there...
> >>
> >> arch/arm/mach-omap2/omap_device.c: In function 'omap_device_get_by_hwmod_name':
> >> arch/arm/mach-omap2/omap_device.c:821:3: warning: return makes pointer from integer without a cast
> >> arch/arm/mach-omap2/omap_device.c:826:3: warning: return makes pointer from integer without a cast
> > 
> > Hmm these I already fixed earlier along with a merge resolution, and
> > I'm not seeing them in next/master or arm-soc/for-next. What do you
> > have merged into your current tree?
> > 
> >> drivers/power/twl4030_charger.c: In function 'twl4030_charger_enable_usb':
> >> drivers/power/twl4030_charger.c:192:20: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result
> > 
> > Neil, care to provide a fix for this? It's from your commit ab37813
> > (twl4030_charger: Allow charger to control the regulator that feeds it).
> > 
> >> include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_event' defined but not used
> > 
> > Eduardo, can you fix that one? It seems to be from your commit 8ab3e6a
> > (thermal: Use thermal zone device id in netlink messages).
> 
> Yeah sure I can fix it. As simple as the following:
> From c04244c87312f5bfc61d9e12ba3fbaa0fdd81adb Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <eduardo.valentin@ti.com>
> Date: Thu, 2 May 2013 12:58:20 -0400
> Subject: [PATCH 1/1] thermal: remove stub for thermal_generate_netlink_event
> 
> This patch removes the stub for thermal_generate_netlink_event
> because this function is not used anywhere inside the kernel.
> 
> In case CONFIG_NET is not set we get:
> include/linux/thermal.h:254:12: warning:
> 'thermal_generate_netlink_event' defined but not used
> 
> Thus removing it.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  include/linux/thermal.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e3c0ae9..e3f3cba 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -250,12 +250,6 @@ void thermal_unregister_governor(struct
> thermal_governor *);
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  						enum events event);
> -#else
> -static int thermal_generate_netlink_event(struct thermal_zone_device *tz,

just adding 'inline' would be an easier patch and lets you compile fine
on !CONFIG_NET when you starting using thermal_generate_netlink_event().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130502/024a20b2/attachment-0001.sig>
