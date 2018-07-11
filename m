From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 15:11:30 +0800
Subject: [PATCH v2 10/18] drm/sun4i: mixer: Read id from DT
In-Reply-To: <3034661.dpXlJLpBba@jernej-laptop>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180710203511.18454-11-jernej.skrabec@siol.net>
 <CAGb2v66vU4gBewGjLL-Ohx6mvKOVu4dDdwKNsXrkr3nZsSq3Cg@mail.gmail.com>
 <3034661.dpXlJLpBba@jernej-laptop>
Message-ID: <CAGb2v66Ghosy92MQH8YmqxkimNe5S0sYSVmt+X-ZsDHYzPK=EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 3:10 PM, Jernej ?krabec <jernej.skrabec@siol.net> wrote:
> Dne sreda, 11. julij 2018 ob 05:11:56 CEST je Chen-Yu Tsai napisal(a):
>> On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > Currently, TCON supports 2 ways to match TCON with engine (mixer in this
>> > case). Old way is to just traverse of graph backwards and compare node
>> > pointer. New way is to match TCON and engine by their respective ids.
>> > All SoCs with DE2 enabled till now used the old way, which means mixer
>> > id was never used and thus never implemented.
>> >
>> > However, for R40, only the new way will be used. To prepare for that,
>> > implement mixer id fetching from DT.
>> >
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> > ---
>> >
>> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 40 +++++++++++++++++++++++++++--
>> >  1 file changed, 38 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index aa81b9838ae8..4bd4d8ccb34f
>> > 100644
>> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> > @@ -22,6 +22,7 @@
>> >
>> >  #include <linux/component.h>
>> >  #include <linux/dma-mapping.h>
>> >  #include <linux/of_device.h>
>> >
>> > +#include <linux/of_graph.h>
>> >
>> >  #include <linux/reset.h>
>> >
>> >  #include "sun4i_drv.h"
>> >
>> > @@ -322,6 +323,42 @@ static struct regmap_config sun8i_mixer_regmap_config
>> > = {>
>> >         .max_register   = 0xbfffc, /* guessed */
>> >
>> >  };
>> >
>> > +static int sun8i_mixer_of_get_id(struct device_node *node)
>> > +{
>> > +       struct device_node *port, *ep;
>> > +       int ret = -EINVAL;
>> > +
>> > +       /* output is port 1 */
>> > +       port = of_graph_get_port_by_id(node, 1);
>> > +       if (!port)
>> > +               return -EINVAL;
>> > +
>> > +       /* try to find downstream endpoint */
>> > +       for_each_available_child_of_node(port, ep) {
>> > +               struct device_node *remote;
>> > +               u32 reg;
>> > +
>> > +               remote = of_graph_get_remote_endpoint(ep);
>> > +               if (!remote)
>> > +                       continue;
>> > +
>> > +               ret = of_property_read_u32(remote, "reg", &reg);
>> > +               if (!ret) {
>> > +                       of_node_put(remote);
>> > +                       of_node_put(ep);
>> > +                       of_node_put(port);
>> > +
>> > +                       return reg;
>> > +               }
>> > +
>> > +               of_node_put(remote);
>> > +       }
>> > +
>> > +       of_node_put(port);
>> > +
>> > +       return ret;
>> > +}
>> > +
>>
>> The above looks good.
>>
>> >  static int sun8i_mixer_bind(struct device *dev, struct device *master,
>> >
>> >                               void *data)
>> >
>> >  {
>> >
>> > @@ -353,8 +390,7 @@ static int sun8i_mixer_bind(struct device *dev, struct
>> > device *master,>
>> >         dev_set_drvdata(dev, mixer);
>> >         mixer->engine.ops = &sun8i_engine_ops;
>> >         mixer->engine.node = dev->of_node;
>> >
>> > -       /* The ID of the mixer currently doesn't matter */
>> > -       mixer->engine.id = -1;
>> > +       mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
>>
>> Should you be handling error codes?
>
> Sadly, no. Other supported DE2 SoC miss reg property in DT and it would break
> them. Additionally, V3s has only one mixer and thus technically doesn't
> violate binding with omiting mixer id.
>
> Anyway, it was -1 all the time before and not really used, so having negative
> value doesn't change anything for other SoCs. If this fails and it's needed,
> it would stop at mixer <-> TCON matching stage anyway.
>
> I guess I should add comment for that.

Yes. Please. We'll leave the rest till later. I plan to fix up the missing
IDs for all the other SoCs anyway.

ChenYu
