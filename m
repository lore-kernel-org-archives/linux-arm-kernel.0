From: dianders@chromium.org (Doug Anderson)
Date: Mon, 17 Jul 2017 13:44:28 -0700
Subject: [PATCH] drm/rockchip: cdn-dp: send audio infoframe to sink
In-Reply-To: <20170717202300.c2r7ypclqbwvqbzq@art_vandelay>
References: <1500116418-4178-1-git-send-email-zyw@rock-chips.com>
 <20170717202300.c2r7ypclqbwvqbzq@art_vandelay>
Message-ID: <CAD=FV=Xq6ZDgzzL9Y79hmtZxdogBkUwx=6NwQHM+8vt9PRL__A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 17, 2017 at 1:23 PM, Sean Paul <seanpaul@chromium.org> wrote:
>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> index 9b0b058..e59ca47 100644
>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> @@ -802,6 +802,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
>>               .sample_rate = params->sample_rate,
>>               .channels = params->channels,
>>       };
>> +     u8 buffer[14];
>
> Why 14?
>
> I think you should probably have buffer[HDMI_AUDIO_INFOFRAME_SIZE +
> SDP_HEADER_SIZE] so the reader knows how you arrived at this value.
>
>>       int ret;
>>
>>       mutex_lock(&dp->lock);
>> @@ -823,6 +824,25 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
>>               goto out;
>>       }
>>
>> +     memset(buffer, 0, sizeof(buffer));

It is less error prone (and probably makes better code) to just to do
this at init time.  AKA:

u8 buffer[14] = { 0 };
