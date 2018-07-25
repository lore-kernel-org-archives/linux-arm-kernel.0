From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 25 Jul 2018 08:38:09 -0600
Subject: [PATCH v2 02/10] coresight: platform: Refactor graph endpoint
 parsing
In-Reply-To: <ea1a6672-0cbb-86b7-c8cd-0759edb94f85@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-3-git-send-email-suzuki.poulose@arm.com>
 <20180724213031.GA22451@xps15>
 <CANLsYkwDTM2pT0JCCnLdetKoYe6xsmj48Gyb5OJFxJMmRLrZ_g@mail.gmail.com>
 <ea1a6672-0cbb-86b7-c8cd-0759edb94f85@arm.com>
Message-ID: <CANLsYkxcTPWbM75wHgiy8tC6FNhELsMcK=fu2TfvXG-3rM=hCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jul 2018 at 03:01, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 07/24/2018 10:34 PM, Mathieu Poirier wrote:
> > On Tue, 24 Jul 2018 at 15:30, Mathieu Poirier
> > <mathieu.poirier@linaro.org> wrote:
> >>
> >> Good afternoon,
> >>
> >> On Thu, Jul 19, 2018 at 11:55:06AM +0100, Suzuki K Poulose wrote:
> >>> Refactor the of graph endpoint parsing code, to make the error
> >>> handling easier.
> >>>
> >>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>> ---
> >>> Changes since v1:
> >>>   - Splitted from the of_node refcounting fix, part1
> >>> ---
> >>>   drivers/hwtracing/coresight/of_coresight.c | 129 +++++++++++++++++------------
> >>>   1 file changed, 75 insertions(+), 54 deletions(-)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> >>> index 6880bee..68faaf8 100644
> >>> --- a/drivers/hwtracing/coresight/of_coresight.c
> >>> +++ b/drivers/hwtracing/coresight/of_coresight.c
> >>> @@ -114,17 +114,69 @@ int of_coresight_get_cpu(const struct device_node *node)
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
> >>>
> >>> +/*
> >>> + * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> >>> + * and fill the connection information in @pdata[*@i].
> >>> + *
> >>> + * Parses the local port, remote device name and the remote port. Also
> >>> + * updates *@i to point to the next index, when an entry is added.
> >>> + *
> >>> + * Returns :
> >>> + *    0      - If the parsing completed without any fatal errors.
> >>> + *   -Errno  - Fatal error, abort the scanning.
> >>> + */
> >>> +static int of_coresight_parse_endpoint(struct device *dev,
> >>> +                                    struct device_node *ep,
> >>> +                                    struct coresight_platform_data *pdata,
> >>> +                                    int *i)
> >>> +{
> >>> +     int ret = 0;
> >>> +     struct of_endpoint endpoint, rendpoint;
> >>> +     struct device_node *rparent = NULL;
> >>> +     struct device_node *rport = NULL;
> >>> +     struct device *rdev = NULL;
> >>> +
> >>> +     do {
> >>> +             /* Parse the local port details */
> >>> +             if (of_graph_parse_endpoint(ep, &endpoint))
> >>> +                     break;
> >>> +             /*
> >>> +              * Get a handle on the remote port and parent
> >>> +              * attached to it.
> >>> +              */
> >>> +             rparent = of_graph_get_remote_port_parent(ep);
> >>> +             if (!rparent)
> >>> +                     break;
> >>> +             rport = of_graph_get_remote_port(ep);
> >>> +             if (!rport)
> >>> +                     break;
> >>> +             if (of_graph_parse_endpoint(rport, &rendpoint))
> >>> +                     break;
> >>> +
> >>> +             /* If the remote device is not available, defer probing */
> >>> +             rdev = of_coresight_get_endpoint_device(rparent);
> >>> +             if (!rdev) {
> >>> +                     ret = -EPROBE_DEFER;
> >>> +                     break;
> >>> +             }
> >>> +
> >>> +             pdata->outports[*i] = endpoint.port;
> >>> +             pdata->child_names[*i] = dev_name(rdev);
> >>> +             pdata->child_ports[*i] = rendpoint.id;
> >>> +             /* Move the index */
> >>> +             (*i)++;
> >>
> >> Not a big fan, makes the code needlessly complex.  Incrementation of the index
> >> can be done in the while loop of of_get_coresight_platform_data().  See below.
>
> Me neither..
>
> >
> > Void that - it properly deals with the first of_parse_endpoint().
>
> Or may be we could do something with the return value :
>
>           1 - Successfully parsed and populated a connection entry
>           0 - No errors in parsing
>         < 0 - Errors in parsing

Right, that is another solution.  I usually try to avoid those but I
think it is better than what we currently have.

>
> >>> @@ -132,64 +184,33 @@ of_get_coresight_platform_data(struct device *dev,
>
>
> >>> +     while ((ep = of_graph_get_next_endpoint(node, ep))) {
> >>> +             /*
> >>> +              * No need to deal with input ports, processing for as
> >>> +              * processing for output ports will deal with them.
> >>> +              */
> >>
> >> This comment has been broken for a while... It should read:
> >>
> >>                  /*
> >>                   * No need to deal with input ports, as processing
> >>                   * for output ports will deal with them.
> >>                   */
>
> Sure, will fix it.

Thanks,
Mathieu

>
>
> Suzuki
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
