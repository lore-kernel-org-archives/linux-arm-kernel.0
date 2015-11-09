From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 09 Nov 2015 12:20:36 +0100
Subject: [RFC PATCH v3 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <20151109105316.GD963@e106497-lin.cambridge.arm.com>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <1445267270-23126-2-git-send-email-Liviu.Dudau@arm.com>
 <564069CD.2070102@rock-chips.com>
 <20151109105316.GD963@e106497-lin.cambridge.arm.com>
Message-ID: <1447068036.3964.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 09.11.2015, 10:53 +0000 schrieb Liviu Dudau:
> On Mon, Nov 09, 2015 at 05:39:25PM +0800, Mark yao wrote:
> > On 2015?10?19? 23:07, Liviu Dudau wrote:
> > >A lot of component based DRM drivers use a variant of the same code
> > >as the probe function. They bind the crtc ports in the first iteration
> > >and then scan through the child nodes and bind the encoders attached
> > >to the remote endpoints. Factor the common code into a separate
> > >function called drm_of_component_probe() in order to increase code
> > >reuse.
> > >
> > >Cc: David Airlie <airlied@linux.ie>
> > >Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > >---
> > >  drivers/gpu/drm/drm_of.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/drm/drm_of.h     | 13 +++++++
> > >  2 files changed, 101 insertions(+)
> > >
> > >diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > >index be38840..493c05c 100644
> > >--- a/drivers/gpu/drm/drm_of.c
> > >+++ b/drivers/gpu/drm/drm_of.c
> > >@@ -1,3 +1,4 @@
> > >+#include <linux/component.h>
> > >  #include <linux/export.h>
> > >  #include <linux/list.h>
> > >  #include <linux/of_graph.h>
> > >@@ -61,3 +62,90 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
> > >  	return possible_crtcs;
> > >  }
> > >  EXPORT_SYMBOL(drm_of_find_possible_crtcs);
> > >+
> > >+/**
> > >+ * drm_of_component_probe - Generic probe function for a component based master
> > >+ * @dev: master device containing the OF node
> > >+ * @compare_of: compare function used for matching components
> > >+ * @master_ops: component master ops to be used
> > >+ *
> > >+ * Parse the platform device OF node and bind all the components associated
> > >+ * with the master. Interface ports are added before the encoders in order to
> > >+ * satisfy their .bind requirements
> > >+ * See Documentation/devicetree/bindings/graph.txt for the bindings.
> > >+ *
> > >+ * Returns zero if successful, or one of the standard error codes if it fails.
> > >+ */
> > >+int drm_of_component_probe(struct device *dev,
> > >+			   int (*compare_of)(struct device *, void *),
> > >+			   const struct component_master_ops *m_ops)
> > >+{
> > >+	struct device_node *ep, *port, *remote;
> > >+	struct component_match *match = NULL;
> > >+	int i;
> > >+
> > >+	if (!dev->of_node)
> > >+		return -EINVAL;
> > >+
> > >+	/*
> > >+	 * Bind the crtc's ports first, so that drm_of_find_possible_crtcs()
> > >+	 * called from encoder's .bind callbacks works as expected
> > >+	 */
> > >+	for (i = 0; ; i++) {
> > >+		port = of_parse_phandle(dev->of_node, "ports", i);
> > >+		if (!port)
> > >+			break;
> > >+
> > >+		if (!of_device_is_available(port->parent)) {
> > >+			of_node_put(port);
> > >+			continue;
> > >+		}
> > >+
> > >+		component_match_add(dev, &match, compare_of, port);
> > Hi Liviu
> >       Rockchip drm can't work with drm_of_component_probe function now,
> > 
> >       At drm_of_component_probe:
> >             component_match_add(dev, &match, compare_of, port);
> >       And original rockchip drm use:
> >             component_match_add(dev, &match, compare_of, port->parent);
> > 
> >      That different "port" and "port->parent" cause crtc device node always
> > mis-match.
> > 
> >      I'm confused that rockchip use same dts node map as imx drm driver, but
> > it works
> > for imx drm, not work on rockchip drm.
> 
> Hi Mark,
> 
> I'm (slightly) confused as well. The drivers are different so there must be a reason
> to account for the different behaviour. Unfortunately I don't have a Rockchip based
> platform ready for testing, so I would appreciate if you could add some debugging
> messages to drm_of_component_probe() when component_match_add is being called and
> compare that with the version before my patch.

The reason is that rockchip has device tree probed devices that contain
the ports, but on imx crtc devices are platform devices created by the
driver, which don't have their own device tree node. They are associated
with the port nodes directly in ipu_drm_probe (ipuv3-crtc.c).

regards
Philipp
