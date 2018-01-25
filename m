From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Thu, 25 Jan 2018 22:00:23 +0000
Subject: DRM: double free in rcar_du_vsp.c
In-Reply-To: <f61c270f-219c-56e5-a03d-e9a3e122d4b4@epam.com>
References: <234140a7-8538-3ec4-1c40-e6ebcc42be8f@epam.com>
 <f61c270f-219c-56e5-a03d-e9a3e122d4b4@epam.com>
Message-ID: <8130932d-7b03-291b-df4f-3227c089fcc4@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Volodymyr,

My apologies for the silence on this thread, but it has not been ignored.

I believe Laurent has investigated this issue, and prepared a patch
locally on his tree. However, he is currently out-of-office with travel and may
not find time to reply to this thread this week or next.

I suspect after a bit of testing and polish he will send it out for
review/integration, or inclusion in a mainline pull-request.
--
Regards

Kieran

On 24/01/18 12:04, Volodymyr Babchuk wrote:
> 
> Looping in DRM maintainer.
> 
>> Hello,
>>
>> I have found issue with double free() in RCAR DU VSP driver. it is
>> caused by rcar_du_vsp_plane_atomic_duplicate_state(), which duplicates
>> struct rcar_du_vsp_plane_state. This struct holds sg_tables which are
>> then freed in rcar_du_vsp_plane_cleanup_fb(). This function is called
>> for every rcar_du_vsp_plane_state, so it calls sg_free_table() twice for
>> the same sg_table.
>>
>> I'm not familiar with DRM, so I can't say why this does not occur every
>> time, but this bug caused problems on our setup from time to time. Looks
>> like it occurs only under heavy system load.
>>
>> As I said, I'm not good in DRM, so I don't know the proper fix. But you
>> can find workaround at [1]. I don't know how good it is, but at least
>> it resolved issue on our setup. If drm guys think that this fix is fine
>> enough, I can push it to the? ML for a proper review.
>>
>> [1]
>> https://github.com/lorc/linux/commit/80155506d3499273155366a1d263a81baface718
>>
>> Cheers,
>> --?
>> Volodymyr Babchuk
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
