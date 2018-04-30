From: peda@axentia.se (Peter Rosin)
Date: Mon, 30 Apr 2018 22:32:48 +0200
Subject: [PATCH 23/24] drm/bridge: require the .owner to be filled in on
 drm_bridge_attach
In-Reply-To: <20180430152438.GO12521@phenom.ffwll.local>
References: <20180426223139.16740-1-peda@axentia.se>
 <20180426223139.16740-24-peda@axentia.se>
 <20180430152438.GO12521@phenom.ffwll.local>
Message-ID: <dabd40ac-408d-22d7-25c8-370c50663989@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-30 17:24, Daniel Vetter wrote:
> On Fri, Apr 27, 2018 at 12:31:38AM +0200, Peter Rosin wrote:
>> The .owner will be handy to have around.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/drm_bridge.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 9f023bd84d56..a038da696802 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -115,6 +115,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>  	if (!encoder || !bridge)
>>  		return -EINVAL;
>>  
>> +	if (WARN_ON(!bridge->owner))
>> +		return -EINVAL;
> 
> I think conceptually this is checked at the wrong place, and I think also misnamed
> a bit. The ->owner is essentially the struct device (and its associated
> driver) that provides the drm_bridge. As such it should be filled out
> already at drm_bridge_add() time, and I think the check should be in
> there. For driver-internal bridges it might make sense to also check this
> here, not sure. Or just require all bridges get added.

The reason for the position is that while I originally had the WARN in
drm_bridge_add, I found that quite a few bridges never call drm_bridge_add.
So I moved it. Other options are to start requiring all bridge suppliers to
call drm_bridge_add or to have the WARN in both function. Too me, it would
make sense to require all bridge suppliers to call drm_bridge_add, as that
enables other init stuff later, when needed. But that is a hairy patch to
get right, and is probably best left as a separate series.

> Wrt the name, I think we should call this pdev or something. ->owner
> usually means the module owner. I think in other subsystems ->dev is used,
> but in drm we use ->dev for the drm_device pointer, so totally different
> thing. pdev = physical device is the best I came up with. Better
> suggestions very much welcome.

pdev is about as problematic as owner. To me it reads "platform device".
And dev for a drm_device is also somewhat problematic, and I think that
drm would have been better, but dev for drm_device is probably quite
common. But one way to go is to rename the current dev to drm, so that
dev is freed up for the owner/supplier device. But that is a tedious
patch to write (I don't do the cocci thing).

Other suggestions I can think of: odev for owner device, sdev for supplier
device or just plain supplier.

Cheers,
Peter

> -Daniel
> 
>> +
>>  	if (previous && (!previous->dev || previous->encoder != encoder))
>>  		return -EINVAL;
>>  
>> -- 
>> 2.11.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
