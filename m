From: mandar.nandale@mindteck.com (Mandar Nandale)
Date: Thu, 20 Feb 2014 08:02:34 +0000 (UTC)
Subject: [PATCH RFC 0/2] watchdog  boot status
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <loom.20140220T090204-808@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti <at> ti.com> writes:

> 
> This patch series does the following
> Patch 1:
> Fixes the omap_prcm_get_reset_sources() for omap3/4
> 
> Patch 2:
> Extends the WDIOC_GETBOOTSTATUS to support omap3/4.
> 
> Tested on omap3sdp and omap4sdp.
> 
> Rajendra Nayak (1):
>   ARM: omap: Fix omap_prcm_get_reset_sources() for omap3/4
> 
> Shubhrajyoti D (1):
>   watchdog : omap_wdt : Implement WDIOC_GETBOOTSTATUS for omap3+
> 
>  arch/arm/mach-omap2/prcm.c    |   13 ++++++++-----
>  arch/arm/mach-omap2/prm44xx.h |    3 ---
>  drivers/watchdog/omap_wdt.c   |    2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
Hi , 

    I am trying to get a last reboot reason using WDIOC_GETBOOTSTATUS ioctl
call from application. Previously before applying this patch it was always
returning me non-zero value no matter reboot is caused by watchdog or power
on reset, so i applied this patch and added some prink statements to
omap_wdt.c file and now after applying patch : 
if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) this
condition is successfull and omap_prcm_get_reset_sources() function is
getting called and everytime i am getting 0 for ioctl call thus even if
reboot is caused by watchdog it will return me 0 (Power-On-Reset). 
What may be the reasons behind this kind of behaviour?

This is the omap_prcm_get_reset_sources() function from
arch/arm/mach-omap2/prcm.c file in my kernel source :

u32 omap_prcm_get_reset_sources(void)
{
        /* XXX This presumably needs modification for 34XX */
        if (cpu_is_omap24xx() || cpu_is_omap34xx())
                return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
        if (cpu_is_omap44xx())
                return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;

        return 0;
}
