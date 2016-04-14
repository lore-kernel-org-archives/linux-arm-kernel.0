From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Apr 2016 08:33:45 -0700
Subject: [PATCH V2] ARM: OMAP3: Fix external abort on 36xx waking from
 off mode idle
In-Reply-To: <1460598588-28468-1-git-send-email-d-gerlach@ti.com>
References: <1460598588-28468-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20160414153345.GJ5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [160413 18:51]:
> Depending on timing during the resume path from off mode on 36xx, we may
> see external aborts. These seem to be caused by the following:
> 
> - OMAP3 Advisory 1.62 "MPU Cannot Exit from Standby" says we need to
>   disable disable intc autoidle before WFI
> 
> - DM3730 Advisory 1.106 "MPU Leaves MSTANDBY State Before IDLEREQ of
>   Interrupt Controller is Released" says we need to wait before
>   accessing intc
> 
> omap3_intc_resume_idle restores the intc autoidle for all resume paths,
> however in the resume path from off mode only it is also being restored
> by omap_intc_restore_context before this call to omap3_intc_resume_idle
> happens. The second restore of the intc autoidle in this path is what
> appears to be causing the external abort so for the off mode resume path
> let's rely on omap_intc_restore_context to restore intc autoidle, and
> for all other paths let omap3_intc_resume_idle handle it as it is now.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v1->v2:
>   - Rebased on v4.6-rc1
>   - Tested with and without patch and no abort seen on v4.6-rc1
>   - Series at [1] that v1 was based on alone on v4.6-rc1 sees abort,
>     if series is applied on this patch abort goes away

Thanks for updating it, applying into omap-for-v4.6/fixes.

Regards,

Tony
