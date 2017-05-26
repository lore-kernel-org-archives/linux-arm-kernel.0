From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 26 May 2017 10:30:09 +0800
Subject: [PATCH] drm/rockchip: Don't allow zero sized gem buffer
In-Reply-To: <20170525153045.7svkkmfsqbqkfacp@art_vandelay>
References: <1495521583-29151-1-git-send-email-jeffy.chen@rock-chips.com>
 <20170525153045.7svkkmfsqbqkfacp@art_vandelay>
Message-ID: <59279331.3050402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi sean,

On 05/25/2017 11:30 PM, Sean Paul wrote:
> On Tue, May 23, 2017 at 02:39:43PM +0800, Jeffy Chen wrote:
>> The system would crash when trying to alloc zero sized gem buffer:
>> [    6.712435] Unable to handle kernel NULL pointer dereference at virtual address 00000010 <--ZERO_SIZE_PTR
>> ...
>> [    6.757502] PC is at sg_alloc_table_from_pages+0x170/0x1ec
>
> It's unfortunate that you didn't include the entire stack trace. From code
> inspection, it seems like the 0 size comes from the fb_probe path? Is there
> somewhere in the helpers that you could check the mode is sane so all drivers
> can benefit?

hmm, sorry, i was testing it on chromeos 4.4 kernel, it turns out that 
we have a custom ioctl for userspace to create gem buffer(the same as 
exynos drm), which might get the the 0 size.

but on upstream kernel, it could only be called by dump_create, and the 
drm_mode_create_dumb_ioctl already did the size check.

will resent this patch, and rewrite the commit message, thanx.

>
> Sean
>
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>> index df9e570..8917922 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>> @@ -315,6 +315,11 @@ struct rockchip_gem_object *
>>   	struct drm_gem_object *obj;
>>   	int ret;
>>
>> +	if (!size) {
>> +		DRM_ERROR("gem buffer size is zero\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>>   	size = round_up(size, PAGE_SIZE);
>>
>>   	rk_obj = kzalloc(sizeof(*rk_obj), GFP_KERNEL);
>> --
>> 2.1.4
>>
>
