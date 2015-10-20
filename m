From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Tue, 20 Oct 2015 11:00:55 +0100
Subject: [PATCH v4 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <1445332995-11212-2-git-send-email-Liviu.Dudau@arm.com>
References: <1445332995-11212-1-git-send-email-Liviu.Dudau@arm.com>
 <1445332995-11212-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CACvgo51szQz9iu55mP+Qz+VCzjB-20K169MpX6_71ppcnGHXzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 20 October 2015 at 10:23, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> A lot of component based DRM drivers use a variant of the same code
> as the probe function. They bind the crtc ports in the first iteration
> and then scan through the child nodes and bind the encoders attached
> to the remote endpoints. Factor the common code into a separate
> function called drm_of_component_probe() in order to increase code
> reuse.
>
> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/drm_of.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_of.h     | 13 +++++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index be38840..493c05c 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -1,3 +1,4 @@
> +#include <linux/component.h>
>  #include <linux/export.h>
>  #include <linux/list.h>
>  #include <linux/of_graph.h>
> @@ -61,3 +62,90 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>         return possible_crtcs;
>  }
>  EXPORT_SYMBOL(drm_of_find_possible_crtcs);
> +
> +/**
> + * drm_of_component_probe - Generic probe function for a component based master
> + * @dev: master device containing the OF node
> + * @compare_of: compare function used for matching components
> + * @master_ops: component master ops to be used
> + *
> + * Parse the platform device OF node and bind all the components associated
> + * with the master. Interface ports are added before the encoders in order to
> + * satisfy their .bind requirements
> + * See Documentation/devicetree/bindings/graph.txt for the bindings.
> + *
> + * Returns zero if successful, or one of the standard error codes if it fails.
> + */
> +int drm_of_component_probe(struct device *dev,
> +                          int (*compare_of)(struct device *, void *),
> +                          const struct component_master_ops *m_ops)
> +{
> +       struct device_node *ep, *port, *remote;
> +       struct component_match *match = NULL;
> +       int i;
> +
> +       if (!dev->of_node)
> +               return -EINVAL;
> +
> +       /*
> +        * Bind the crtc's ports first, so that drm_of_find_possible_crtcs()
> +        * called from encoder's .bind callbacks works as expected
> +        */
> +       for (i = 0; ; i++) {
> +               port = of_parse_phandle(dev->of_node, "ports", i);
> +               if (!port)
> +                       break;
> +
> +               if (!of_device_is_available(port->parent)) {
> +                       of_node_put(port);
> +                       continue;
> +               }
> +
> +               component_match_add(dev, &match, compare_of, port);
> +               of_node_put(port);
> +       }
> +
> +       if (i == 0) {
> +               dev_err(dev, "missing 'ports' property\n");
> +               return -ENODEV;
> +       }
> +
> +       if (!match) {
> +               dev_err(dev, "no available port\n");
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * For bound crtcs, bind the encoders attached to their remote endpoint
> +        */
> +       for (i = 0; ; i++) {
> +               port = of_parse_phandle(dev->of_node, "ports", i);
> +               if (!port)
> +                       break;
> +
> +               if (!of_device_is_available(port->parent)) {
> +                       of_node_put(port);
> +                       continue;
> +               }
> +
Of the three drivers converted only the rockchip one has the above
of_device_is_available() hunk. Based on the handling in previous loop
I'm not entirely sure if it's needed, but if so shouldn't one mention
the difference when converting the respective drivers ?

I'm not working on/familiar with either of these drivers so this is
just a fly-by comment.

Cheers,
Emil
