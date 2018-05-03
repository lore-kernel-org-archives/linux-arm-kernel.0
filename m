From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 May 2018 23:12:21 +0200
Subject: [PATCH 1/3] drm/sti: do not remove the drm_bridge that was never
 added
In-Reply-To: <20180503090648.GG12521@phenom.ffwll.local>
References: <20180502074025.12421-1-peda@axentia.se>
 <20180502074025.12421-2-peda@axentia.se>
 <20180503090648.GG12521@phenom.ffwll.local>
Message-ID: <bd8d12f7-0c71-c96b-80fa-54de7de39511@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-03 11:06, Daniel Vetter wrote:
> On Wed, May 02, 2018 at 09:40:23AM +0200, Peter Rosin wrote:
>> The more natural approach would perhaps be to add an drm_bridge_add,
>> but there are several other bridges that never call drm_bridge_add.
>> Just removing the drm_bridge_remove is the easier fix.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> This mess is much bigger. There's 2 pairs of bridge functions:
> 
> - drm_bridge_attach/detach. Those are meant to be called by the overall
>   drm driver to connect/disconnect a drm_bridge.
> 
> - drm_bridge_add/remove. These are supposed to be called by the bridge
>   driver itself to register/unregister itself. Maybe we should rename
>   them, since the same issue happens with drm_panel, with the same
>   confusion.
> 
> I thought someone was working on a cleanup series to fix this mess, but I
> didn't find anything.

Ok, I just spotted the imbalance and didn't really dig into what
actually happens in these error paths. Now that I have done so I
believe that the removed drm_bridge_remove calls causes NULL
dereferences if/when the error paths are triggered.

So, I don't think this can wait for some bigger cleanup.

drm_bridge_remove calls list_del_init calls __list_del_entry calls
__list_del with NULL in both prev and next since the list member
is never initialized. prev and next are dereferenced by __list_del
and you have *boom*

I recommend adding the tag

Fixes: 84601dbdea36 ("drm: sti: rework init sequence")

so that stable picks this one up.

Cheers,
Peter

> -Daniel
> 
>> ---
>>  drivers/gpu/drm/sti/sti_hda.c  | 1 -
>>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
>>  2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
>> index 67bbdb49fffc..199db13f565c 100644
>> --- a/drivers/gpu/drm/sti/sti_hda.c
>> +++ b/drivers/gpu/drm/sti/sti_hda.c
>> @@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>>  	return 0;
>>  
>>  err_sysfs:
>> -	drm_bridge_remove(bridge);
>>  	return -EINVAL;
>>  }
>>  
>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
>> index 58f431102512..932724784942 100644
>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
>> @@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>>  	return 0;
>>  
>>  err_sysfs:
>> -	drm_bridge_remove(bridge);
>>  	hdmi->drm_connector = NULL;
>>  	return -EINVAL;
>>  }
>> -- 
>> 2.11.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
