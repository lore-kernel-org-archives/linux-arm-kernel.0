From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 22 Dec 2014 16:11:28 +0100
Subject: [PATCH v6 0/3] Add of-graph helpers to loop over endpoints and find
 ports by id
Message-ID: <1419261091-29888-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

next try for v3.20. After the merge window we have a few new users of
of_graph_get_next_endpoint, could I please get some acks from the respective
maintainers for this to go in through Grant's tree?

This series converts all existing users of of_graph_get_next_endpoint that pass
a non-NULL prev argument to the function and decrement its refcount themselves
to stop doing that. The of_node_put is moved into of_graph_get_next_endpoint
instead.
This allows to add a for_each_endpoint_of_node helper macro to loop over all
endpoints in a device tree node.

Changes since v5:
 - Rebased onto v3.19-rc1
 - Added new users of of_graph_get_next_endpoint, coresight and
   drm/rcar-du. There's also rockchip, but the driver already doesn't
   decrement the prev node's reference count.
 - Dropped the "use for_each_endpoint_of_node macro" patches,
   I'll add the new users and resend them separately.

The previous version can be found here: https://lkml.org/lkml/2014/9/29/529

regards
Philipp

Philipp Zabel (3):
  of: Decrement refcount of previous endpoint in
    of_graph_get_next_endpoint
  of: Add for_each_endpoint_of_node helper macro
  of: Add of_graph_get_port_by_id function

 drivers/coresight/of_coresight.c               | 13 ++--------
 drivers/gpu/drm/imx/imx-drm-core.c             | 13 ++--------
 drivers/gpu/drm/rcar-du/rcar_du_kms.c          | 15 +++--------
 drivers/media/platform/soc_camera/soc_camera.c |  3 ++-
 drivers/of/base.c                              | 35 ++++++++++++++++++++------
 include/linux/of_graph.h                       | 18 +++++++++++++
 6 files changed, 55 insertions(+), 42 deletions(-)

-- 
2.1.4
