From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 3 Oct 2018 00:00:55 +0200
Subject: [PATCH 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
In-Reply-To: <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
References: <20181001093612.GA13672@mwanda>
 <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
Message-ID: <e8344f9e-54af-e287-c992-4494d8a54025@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for sending twice(and top posting), but I was not subscribed to 
dri-devel ML, so patchwork was not aware of these 2 patches.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

Il 02/10/2018 23:59, Giulio Benetti ha scritto:
> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
> has been used, but that macro doesn't check if tcon->panel pointer is
> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
> 
> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
> condition to check if it's a pointer not null.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index c78cd35a1294..e4b3bd0307ef 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -555,7 +555,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>   	 * Following code is a way to avoid quirks all around TCON
>   	 * and DOTCLOCK drivers.
>   	 */
> -	if (!IS_ERR(tcon->panel)) {
> +	if (tcon->panel) {
>   		struct drm_panel *panel = tcon->panel;
>   		struct drm_connector *connector = panel->connector;
>   		struct drm_display_info display_info = connector->display_info;
> 
