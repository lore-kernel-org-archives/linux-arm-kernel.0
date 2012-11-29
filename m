From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 29 Nov 2012 12:54:42 +0200
Subject: [PATCH] OMAPDSS: Use only "omapdss_dss" platform device to get
 context lost count
In-Reply-To: <1354102299-4928-1-git-send-email-archit@ti.com>
References: <1354102299-4928-1-git-send-email-archit@ti.com>
Message-ID: <50B73EF2.4090307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-28 13:31, Archit Taneja wrote:
> When enabling a hwmod, omap_hwmod refers to the register mentioned in the
> hwmod struct's member 'prcm.omap4.context_offs' to see whether context was
> lost or not. It increments the context lost count for the hwmod and then clears
> the register.
> 
> All the DSS hwmods have the same register(RM_DSS_DSS_CONTEXT) as context_offs.
> When DSS is enabled, the first hwmod to be enabled is the "dss_core" hwmod since
> it's corresponding platform device is the parent platform device("omapdss_dss").
> The dss_core hwmod updates it's context lost count correctly and clears the
> register. When the hwmods corresponding to the children platform devices are
> enabled, they see that the register is clear, and don't increment their context
> lost count. Therefore, all the children platform devices never report a loss in
> context.
> 
> The DISPC driver currently gets the context lost count for DSS power domain from
> it's corresponding platform device instance("omapdss_dispc"). The DISPC platform
> device is one of the child devices, and it's corresponding hwmod("dss_dispc")
> doesn't report the context lost count correctly.
> 
> Modify dss_get_ctx_loss_count() such that it always takes the "omapdss_dss"
> platform device as it's input, move the function to dss.c so that it has access
> to that platform device.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/core.c  |   15 ---------------
>  drivers/video/omap2/dss/dispc.c |    4 ++--
>  drivers/video/omap2/dss/dss.c   |   15 +++++++++++++++
>  drivers/video/omap2/dss/dss.h   |    3 ++-
>  4 files changed, 19 insertions(+), 18 deletions(-)

I think this looks fine. I'll apply to dss master.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121129/09711c45/attachment.sig>
