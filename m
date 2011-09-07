From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 7 Sep 2011 14:31:32 +0200
Subject: [PATCH 09/12] OMAP: VP: Explicitly mask VPVOLTAGE field
In-Reply-To: <1314640692-3386-10-git-send-email-khilman@ti.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
	<1314640692-3386-10-git-send-email-khilman@ti.com>
Message-ID: <CAORVsuVmNa_15X4okj0mgCx=MHNPo+8zxNO03j7aKSS+t7yD-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Mon, Aug 29, 2011 at 7:58 PM, Kevin Hilman <khilman@ti.com> wrote:
> From: Todd Poynor <toddpoynor@google.com>
>
> Reading the VPVOLTAGE field of PRM_VP_*_VOLTAGE registers currently
> relies on a u32 -> u8 conversion to mask off the FORCEUPDATEWAIT field
> in the upper bits. ?Make this explicit using the mask symbol
> already defined, added as a new field in struct omap_vp_common.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> ?arch/arm/mach-omap2/vp.c ? ? ? ? ?| ? ?3 ++-
> ?arch/arm/mach-omap2/vp.h ? ? ? ? ?| ? ?2 ++
> ?arch/arm/mach-omap2/vp3xxx_data.c | ? ?2 ++
> ?arch/arm/mach-omap2/vp44xx_data.c | ? ?1 +
> ?4 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index e7d38f6..3807620 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -227,7 +227,8 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
> ? ? ? ? ? ? ? ?return 0;
> ? ? ? ?}
>
> - ? ? ? curr_vsel = voltdm->read(vp->voltage);
> + ? ? ? curr_vsel = (voltdm->read(vp->voltage) & vp->common->vpvoltage_mask)
> + ? ? ? ? ? ? ? >> __ffs(vp->common->vpvoltage_mask);
