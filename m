From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 30 Aug 2016 23:51:26 +0800
Subject: [PATCH] drm/sun4i: Clear encoder->bridge if a bridge is not found
In-Reply-To: <20160830125622.GF18605@lukather>
References: <20160830122223.21377-1-wens@csie.org>
 <20160830125622.GF18605@lukather>
Message-ID: <CAGb2v64JC5+uzsvLjZVi_Xi8q=U+_Bokqnu33w3oQ-2h2DLnKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 8:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Aug 30, 2016 at 08:22:23PM +0800, Chen-Yu Tsai wrote:
>> The KMS helpers (drm_atomic_helper_check_modeset/mode_fixup) pass
>> encoder->bridge directly to drm_bridge_mode_fixup, which expects a
>> valid pointer, or NULL (in which case it just returns).
>>
>> Clear encoder->bridge if a bridge is not found, instead of keeping
>> the ERR_PTR value.
>>
>> Since other drm_bridge functions also follow this pattern of checking
>> for a non-NULL pointer, we can drop the ifs around the calls and just
>> pass the pointer directly.
>>
>> Fixes: 894f5a9f4b4a ("drm/sun4i: Add bridge support")
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_rgb.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
>> index d4e52522ec53..ee0795152a33 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
>> @@ -154,8 +154,7 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
>>       if (!IS_ERR(tcon->panel))
>>               drm_panel_enable(tcon->panel);
>>
>> -     if (!IS_ERR(encoder->bridge))
>> -             drm_bridge_enable(encoder->bridge);
>> +     drm_bridge_enable(encoder->bridge);
>>
>>       sun4i_tcon_channel_enable(tcon, 0);
>>  }
>> @@ -170,8 +169,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
>>
>>       sun4i_tcon_channel_disable(tcon, 0);
>>
>> -     if (!IS_ERR(encoder->bridge))
>> -             drm_bridge_disable(encoder->bridge);
>> +     drm_bridge_disable(encoder->bridge);
>
> I'd rather keep those changes, it makes it obvious that it's something
> optionnal, that can be set to NULL.

OK.

>>       if (!IS_ERR(tcon->panel))
>>               drm_panel_disable(tcon->panel);
>> @@ -230,6 +228,9 @@ int sun4i_rgb_init(struct drm_device *drm)
>>               return 0;
>>       }
>>
>> +     if (IS_ERR(encoder->bridge))
>> +             encoder->bridge = NULL;
>> +
>
> And that could be the else condition of the if statement below.

That would be a bit confusing, changing it after calling drm_encoder_init.
The code says it ok to do though.

ChenYu

> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
