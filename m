From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 09:47:01 +0200
Subject: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
In-Reply-To: <56016787-0487-1571-7c28-2767033cda23@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
 <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
 <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
 <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se>
 <CAL_JsqJHRL0f2YwvOJBpggKRVQwPWy8j08-+_nd-VifOOKYqFA@mail.gmail.com>
 <56016787-0487-1571-7c28-2767033cda23@axentia.se>
Message-ID: <20180824094701.1f17393f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Aug 2018 17:05:29 +0200
Peter Rosin <peda@axentia.se> wrote:

> >>>>>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >>>>>>
> >>>>>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
> >>>>>>  {
> >>>>>> -    int endpoint, ret = 0;
> >>>>>> -
> >>>>>> -    for (endpoint = 0; !ret; endpoint++)
> >>>>>> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> >>>>>> +    struct of_endpoint endpoint;
> >>>>>> +    struct device_node *node = NULL;
> >>>>>> +    int count = 0;
> >>>>>> +    int ret = 0;
> >>>>>> +
> >>>>>> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
> >>>>>> +            of_graph_parse_endpoint(node, &endpoint);  
> >>>
> >>> I'd really like to kill off of_graph_parse_endpoint, not add more
> >>> users (check the git history on this code). You should know what are
> >>> possible port and endpoint numbers, so iterate over those.  
> >>
> >> So, add a comment to that effect in the docs of the of_graph_parse_endpoint
> >> function.
> >>
> >> How can the hlcdc driver know the actual number of endpoints? It's a
> >> one-way signal path out from that port, and it can easily be routed to
> >> 1, 2, 3 or even more places. As shown above, forcing the endpoint id
> >> to start at zero is a nuisance, and I don't see the point of it.
> >>
> >> But I welcome suggestions on how to arrange the above dtsi/dts fragments
> >> in a world where the endpoint id absolutely has to start at zero.  
> > 
> > Your dts file arrangement seems fine. Can't you just not exit the loop
> > on -ENODEV? IOW, just iterate til you find an enabled endpoint.  
> 
> That would regress cases where two (or more) endpoints are enabled
> (which is currently supported). As I see it, the driver will have a
> very hard time knowing when to stop iterating with any solution not
> involving the equivalent of the functions for_each_endpoint_of_node
> and of_graph_parse_endpoint. Open-coding of_graph_parse_endpoint just
> to avoid it is a bit more than silly IMHO...

I agree, and actually, I think this is Rob who suggested to do what we
do here :-) (iterate from 0 to X, and stop as soon as
-ENODEV is returned).
