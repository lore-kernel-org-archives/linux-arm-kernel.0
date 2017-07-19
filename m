From: robh@kernel.org (Rob Herring)
Date: Wed, 19 Jul 2017 11:02:01 -0500
Subject: [PATCH] media: Convert to using %pOF instead of full_name
In-Reply-To: <564a6768-3b23-6dc7-ecb5-cb4f4359b633@samsung.com>
References: <CGME20170718215328epcas2p2e5e1d7df96fcd894e70a961df864abdd@epcas2p2.samsung.com>
 <20170718214339.7774-33-robh@kernel.org>
 <564a6768-3b23-6dc7-ecb5-cb4f4359b633@samsung.com>
Message-ID: <CAL_JsqLDCgO60ECGB70pMNcaLg0zUcJ6_+50vH-evfGe-D266Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 4:41 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 07/18/2017 11:43 PM, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>
>> ---
>>   drivers/media/i2c/s5c73m3/s5c73m3-core.c       |  3 +-
>>   drivers/media/i2c/s5k5baf.c                    |  7 ++--
>>   drivers/media/platform/am437x/am437x-vpfe.c    |  4 +-
>>   drivers/media/platform/atmel/atmel-isc.c       |  4 +-
>>   drivers/media/platform/davinci/vpif_capture.c  | 16 ++++----
>>   drivers/media/platform/exynos4-is/fimc-is.c    |  8 ++--
>>   drivers/media/platform/exynos4-is/fimc-lite.c  |  3 +-
>>   drivers/media/platform/exynos4-is/media-dev.c  |  8 ++--
>>   drivers/media/platform/exynos4-is/mipi-csis.c  |  4 +-
>>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.c  |  6 +--
>>   drivers/media/platform/mtk-mdp/mtk_mdp_core.c  |  8 ++--
>>   drivers/media/platform/omap3isp/isp.c          |  8 ++--
>>   drivers/media/platform/pxa_camera.c            |  2 +-
>>   drivers/media/platform/rcar-vin/rcar-core.c    |  4 +-
>>   drivers/media/platform/soc_camera/soc_camera.c |  6 +--
>>   drivers/media/platform/xilinx/xilinx-vipp.c    | 52 +++++++++++++-------------
>>   drivers/media/v4l2-core/v4l2-async.c           |  4 +-
>>   drivers/media/v4l2-core/v4l2-clk.c             |  3 +-
>>   include/media/v4l2-clk.h                       |  4 +-
>>   19 files changed, 71 insertions(+), 83 deletions(-)
>
>> diff --git a/drivers/media/platform/xilinx/xilinx-vipp.c b/drivers/media/platform/xilinx/xilinx-vipp.c
>> index ac4704388920..9233ad0b1b6b 100644
>> --- a/drivers/media/platform/xilinx/xilinx-vipp.c
>> +++ b/drivers/media/platform/xilinx/xilinx-vipp.c
>
>> @@ -144,9 +144,8 @@ static int xvip_graph_build_one(struct xvip_composite_device *xdev,
>>               remote = ent->entity;
>>
>>               if (link.remote_port >= remote->num_pads) {
>> -                     dev_err(xdev->dev, "invalid port number %u on %s\n",
>> -                             link.remote_port,
>> -                             to_of_node(link.remote_node)->full_name);
>> +                     dev_err(xdev->dev, "invalid port number %u on %pOF\n",
>> +                             link.remote_port, link.remote_node);
>
> Shouldn't there be to_of_node(link.remote_node) instead of link.remote_node ?

Humm, yes. I thought I fixed that.

>
>>                       v4l2_fwnode_put_link(&link);
>>                       ret = -EINVAL;
>>                       break;
>
>> @@ -242,17 +241,17 @@ static int xvip_graph_build_dma(struct xvip_composite_device *xdev)
>>               ent = xvip_graph_find_entity(xdev,
>>                                            to_of_node(link.remote_node));
>>               if (ent == NULL) {
>> -                     dev_err(xdev->dev, "no entity found for %s\n",
>> -                             to_of_node(link.remote_node)->full_name);
>> +                     dev_err(xdev->dev, "no entity found for %pOF\n",
>> +                             to_of_node(link.remote_node));
>>                       v4l2_fwnode_put_link(&link);
>>                       ret = -ENODEV;
>>                       break;
>>               }
>
>> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
>> index 851f128eba22..0a385d1ff28c 100644
>> --- a/drivers/media/v4l2-core/v4l2-async.c
>> +++ b/drivers/media/v4l2-core/v4l2-async.c
>> @@ -47,9 +47,7 @@ static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
>>       if (!is_of_node(sd->fwnode) || !is_of_node(asd->match.fwnode.fwnode))
>>               return sd->fwnode == asd->match.fwnode.fwnode;
>>
>> -     return !of_node_cmp(of_node_full_name(to_of_node(sd->fwnode)),
>> -                         of_node_full_name(
>> -                                 to_of_node(asd->match.fwnode.fwnode)));
>> +     return to_of_node(sd->fwnode) == to_of_node(asd->match.fwnode.fwnode);
>
> I'm afraid this will not work, please see commit d2180e0cf77dc7a7049671d5d57d
> "[media] v4l: async: make v4l2 coexist with devicetree nodes in a dt overlay"

Maybe I'm missing something, but how does that work exactly? Before
the overlay is applied, the remote endpoint node (and its parent)
can't be resolved. In the commit example, the endpoint in the
media_bridge would also have to be part of the overlay. If you apply
and un-apply the overlay, then the of_node (and fw_node) in the
overlay is once again invalid. IOW, you should be in the same state as
before the overlay was applied. The node is still around because of
paranoia that actually freeing nodes would break things. It seems this
paranoia is real, so i think we need to do something to prevent this
from spreading.

Furthermore, it does not appear that any media driver supports
overlays and we have no general way to apply them in mainline yet
(other than an in kernel API). So really this scenario is not one we
have to support yet.

Rob
