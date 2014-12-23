From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 23 Dec 2014 14:09:15 +0100
Subject: [PATCH v7 0/3] Add of-graph helpers to loop over endpoints and find
 ports by id
Message-ID: <1419340158-20567-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I addressed Andrzej's comments on of_graph_get_port_by_id() and added
Mathieu's ack to the first patch. Also I missed the omap2-dss init code
last time around. For the first patch, I'd like to get an ack for the rcar-du
and omap2-dss changes so this can go in through Grant's tree.

This series converts all existing users of of_graph_get_next_endpoint that pass
a non-NULL prev argument to the function and decrement its refcount themselves
to stop doing that. The of_node_put is moved into of_graph_get_next_endpoint
instead.
This allows to add a for_each_endpoint_of_node helper macro to loop over all
endpoints in a device tree node.

Changes since v6:
 - Fixed of_graph_get_port_by_id to handle the optional 'ports' node
   and synchronize documentation and parameter names in the process.
 - Added omap2-dss to the list of updated of_graph_get_next_endpoint
   users in the first patch.
 - Added Mathieu's ack to the first patch.

The previous version can be found here: https://lkml.org/lkml/2014/12/22/220

regards
Philipp

Philipp Zabel (3):
  of: Decrement refcount of previous endpoint in
    of_graph_get_next_endpoint
  of: Add for_each_endpoint_of_node helper macro
  of: Add of_graph_get_port_by_id function

 drivers/coresight/of_coresight.c                  | 13 ++-----
 drivers/gpu/drm/imx/imx-drm-core.c                | 13 ++-----
 drivers/gpu/drm/rcar-du/rcar_du_kms.c             | 15 +++------
 drivers/media/platform/soc_camera/soc_camera.c    |  3 +-
 drivers/of/base.c                                 | 41 ++++++++++++++++++-----
 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |  7 +---
 include/linux/of_graph.h                          | 18 ++++++++++
 7 files changed, 62 insertions(+), 48 deletions(-)

-- 
2.1.4
