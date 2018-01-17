From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Wed, 17 Jan 2018 17:52:50 +0200
Subject: DRM: double free in rcar_du_vsp.c
Message-ID: <234140a7-8538-3ec4-1c40-e6ebcc42be8f@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have found issue with double free() in RCAR DU VSP driver. it is 
caused by rcar_du_vsp_plane_atomic_duplicate_state(), which duplicates 
struct rcar_du_vsp_plane_state. This struct holds sg_tables which are 
then freed in rcar_du_vsp_plane_cleanup_fb(). This function is called 
for every rcar_du_vsp_plane_state, so it calls sg_free_table() twice for 
the same sg_table.

I'm not familiar with DRM, so I can't say why this does not occur every 
time, but this bug caused problems on our setup from time to time. Looks 
like it occurs only under heavy system load.

As I said, I'm not good in DRM, so I don't know the proper fix. But you 
can find workaround at [1]. I don't know how good it is, but at least
it resolved issue on our setup. If drm guys think that this fix is fine 
enough, I can push it to the  ML for a proper review.

[1] 
https://github.com/lorc/linux/commit/80155506d3499273155366a1d263a81baface718

Cheers,
-- 
Volodymyr Babchuk
