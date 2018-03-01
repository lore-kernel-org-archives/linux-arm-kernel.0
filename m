From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Mar 2018 22:02:55 +0100
Subject: [PATCH] drm/bridge: sii902x: Fall back to standard modes
In-Reply-To: <20180214130059.19052-1-linus.walleij@linaro.org>
References: <20180214130059.19052-1-linus.walleij@linaro.org>
Message-ID: <CACRpkdYuZE+ohhLf6mmPHEsGmNw6r7UOBCyQEFOcYOYxdVj2oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hm, hard to get review feedback on this one.

It gives me proper video on an ARM Versatile Express utilizing the
bridge driver with a plugged in DVI-to-VGA dongle with the new
PL111 DRI driver.

Liviu? Pawel?

Some ACK is fine to know I am doing the right thing :)

Yours,
Linus Walleij

On Wed, Feb 14, 2018 at 2:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The following happens when connection a DVI output driven
> from the SiI9022 using a DVI-to-VGA adapter plug:
>
> i2c i2c-0: sendbytes: NAK bailout.
> i2c i2c-0: sendbytes: NAK bailout.
>
> Then no picture. Apparently the I2C engine inside the SiI9022
> is not smart enough to try to fall back to DDC I2C. Or the
> vendor have not integrated the electronics properly. I don't
> know which one it is.
>
> By using standard modes as fallback, the bridge probes nicely
> with a minor warning and we get picture.
>
> This code is inspired by similar code in the dumb VGA bridge.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index b1ab4ab09532..4483095c4013 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -168,8 +168,19 @@ static int sii902x_get_modes(struct drm_connector *connector)
>                 return ret;
>
>         edid = drm_get_edid(connector, sii902x->i2c->adapter);
> -       drm_mode_connector_update_edid_property(connector, edid);
> -       if (edid) {
> +       if (!edid) {
> +               /*
> +                * This happens when using a simple DVI-to-VGA converter
> +                * dongle for example: the I2C lines are not bridged over
> +                * to VGA DDC.
> +                */
> +               DRM_INFO("EDID readout failed, falling back to standard modes\n");
> +               ret = drm_add_modes_noedid(connector, 1920, 1080);
> +               /* Set some standard resolution most monitors can handle */
> +               drm_set_preferred_mode(connector, 1024, 768);
> +       } else {
> +               /* Data from EDID readout */
> +               drm_mode_connector_update_edid_property(connector, edid);
>                 num = drm_add_edid_modes(connector, edid);
>                 kfree(edid);
>         }
> --
> 2.14.3
>
