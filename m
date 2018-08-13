From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 13 Aug 2018 14:52:03 -0600
Subject: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
In-Reply-To: <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
 <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
Message-ID: <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 8:25 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-08-13 15:59, jacopo mondi wrote:
> > Hi Peter,
> >
> > On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
> >> This enables more flexible devicetrees. You can e.g. have two output
> >> nodes where one is not enabled, without the ordering affecting things.

Your DTs are not supposed to be flexible. They should be well defined
by the binding.

> >>
> >> Prior to this patch the active node had to have endpoint id zero.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
> >>  1 file changed, 25 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >> index 8db51fb131db..16c1b2f54b42 100644
> >> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
> >>      .destroy = drm_encoder_cleanup,
> >>  };
> >>
> >> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
> >> +                                   struct of_endpoint *endpoint)
> >>  {
> >>      struct drm_encoder *encoder;
> >>      struct drm_panel *panel;
> >>      struct drm_bridge *bridge;
> >>      int ret;
> >>
> >> -    ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
> >> +    ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
> >> +                                      endpoint->port, endpoint->id,
> >
> > You are refusing endpoint->port != 0 in the caller, so that could be
> > 0.
>
> Yes, it could. However, I intentionally did not write 0 here, so that
> the logic related to "port has to be zero" was in one place and not
> scattered about. I guess it's up to Boris?
>
> Maybe the port do not actually have to be zero at all? With the old
> code, it was kind of understandable that the port number was fixed,
> but for the code in my patch it does not matter at all AFAICT. There
> is nothing in the binding docs (except for the example) that hints
> that port has to be zero, so that's one thing in favor of just getting
> rid of the port number checking altogether...

The port numbering must be defined and fixed. If that is not clear in
the binding, fix the binding.

> >> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >>
> >>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
> >>  {
> >> -    int endpoint, ret = 0;
> >> -
> >> -    for (endpoint = 0; !ret; endpoint++)
> >> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> >> +    struct of_endpoint endpoint;
> >> +    struct device_node *node = NULL;
> >> +    int count = 0;
> >> +    int ret = 0;
> >> +
> >> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
> >> +            of_graph_parse_endpoint(node, &endpoint);

I'd really like to kill off of_graph_parse_endpoint, not add more
users (check the git history on this code). You should know what are
possible port and endpoint numbers, so iterate over those.

> >> +
> >> +            if (endpoint.port)
> >> +                    continue;
> >> +
> >> +            ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
> >> +            if (ret == -ENODEV)
> >> +                    continue;
> >> +            if (ret) {
> >> +                    of_node_put(node);
> >> +                    break;
> >> +            }
> >> +            count++;
> >> +    }
> >>
> >>      /* At least one device was successfully attached.*/
> >> -    if (ret == -ENODEV && endpoint)
> >> +    if (ret == -ENODEV && count)
> >>              return 0;
> >>
> >>      return ret;
> >> --
> >> 2.11.0
> >>
>
