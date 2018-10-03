From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 3 Oct 2018 17:43:09 +0800
Subject: [PATCH 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
In-Reply-To: <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
References: <20181001093612.GA13672@mwanda>
 <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
Message-ID: <CAGb2v64z+j=ywU8n210Zw+97n=Ff4rVdUwNR9nbKO-hMD3nJcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2018 at 5:59 AM Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
> has been used, but that macro doesn't check if tcon->panel pointer is
> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
>
> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
> condition to check if it's a pointer not null.

There's actually more than one occurance of this error:

drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {
drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {

These four are responsible for enabling and disabling the panel.

drivers/gpu/drm/sun4i/sun4i_tcon.c:     if (!IS_ERR(tcon->panel)) {

All this looks like it was left over from commit ebc9446135671 ("drm: convert
drivers to use drm_of_find_panel_or_bridge"). We have checks against tcon->panel
in several places and not all of them were converted.

ChenYu

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index c78cd35a1294..e4b3bd0307ef 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -555,7 +555,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>          * Following code is a way to avoid quirks all around TCON
>          * and DOTCLOCK drivers.
>          */
> -       if (!IS_ERR(tcon->panel)) {
> +       if (tcon->panel) {
>                 struct drm_panel *panel = tcon->panel;
>                 struct drm_connector *connector = panel->connector;
>                 struct drm_display_info display_info = connector->display_info;
> --
> 2.17.1
>
