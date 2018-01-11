From: eric@anholt.net (Eric Anholt)
Date: Thu, 11 Jan 2018 12:21:15 -0800
Subject: [PATCH 2/4 v6] drm/bridge: Provide a way to embed timing info in
 bridges
In-Reply-To: <20180110144421.GW13066@phenom.ffwll.local>
References: <20180110141226.27826-1-linus.walleij@linaro.org>
 <20180110141226.27826-2-linus.walleij@linaro.org>
 <20180110144421.GW13066@phenom.ffwll.local>
Message-ID: <87d12guoxw.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Vetter <daniel@ffwll.ch> writes:

> On Wed, Jan 10, 2018 at 03:12:24PM +0100, Linus Walleij wrote:
>> After some discussion and failed patch sets trying to convey
>> the right timing information between the display engine and
>> a bridge using the connector, I try instead to use an optional
>> timing information container in the bridge itself, so that
>> display engines can retrieve it from any bridge and use it to
>> determine how to drive outputs.
>> 
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v5->v6:
>> - Sort forward struct declarations alphabetically
>> - Switch to using DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE to indicate
>>   positive or negatice clock samling edge
>> ChangeLog ->v5:
>> - New patch
>> ---
>>  include/drm/drm_bridge.h | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>> 
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 682d01ba920c..28c9ac6d9036 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -29,6 +29,7 @@
>>  #include <drm/drm_modes.h>
>>  
>>  struct drm_bridge;
>> +struct drm_bridge_timings;
>>  struct drm_panel;
>>  
>>  /**
>> @@ -222,6 +223,23 @@ struct drm_bridge_funcs {
>>  	void (*enable)(struct drm_bridge *bridge);
>>  };
>>  
>> +/**
>> + * struct drm_bridge_timings - timing information for the bridge
>> + * @sampling_edge: whether the bridge samples the digital input signal from the
>> + * display engine on the positive or negative edge of the clock, this should
>> + * reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE bitwise flags from the DRM
>> + * connector (bit 2 and 3 valid)
>> + * @setup_time_ps: the time in picoseconds the input data lines must be stable
>> + * before the clock edge
>> + * @hold_time_ps: the time in picoseconds taken for the bridge to sample the
>> + * input signal after the clock edge
>> + */
>
> Just a style nit: for longer kerneldoc comments for struct members the
> in-line style, split up for each member, is imo better.
> -Daniel

The new style also discourages the comments getting out of sync with the
code.  I'd be happy to r-b with them moved.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/864607ae/attachment.sig>
