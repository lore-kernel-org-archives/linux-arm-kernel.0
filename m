From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 20 Jul 2017 12:22:34 +0200
Subject: [PATCH] media: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqLDCgO60ECGB70pMNcaLg0zUcJ6_+50vH-evfGe-D266Q@mail.gmail.com>
References: <CGME20170718215328epcas2p2e5e1d7df96fcd894e70a961df864abdd@epcas2p2.samsung.com>
 <20170718214339.7774-33-robh@kernel.org>
 <564a6768-3b23-6dc7-ecb5-cb4f4359b633@samsung.com>
 <CAL_JsqLDCgO60ECGB70pMNcaLg0zUcJ6_+50vH-evfGe-D266Q@mail.gmail.com>
Message-ID: <7b004361-f103-f804-3884-299eb5607648@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2017 06:02 PM, Rob Herring wrote:
>>> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
>>> index 851f128eba22..0a385d1ff28c 100644
>>> --- a/drivers/media/v4l2-core/v4l2-async.c
>>> +++ b/drivers/media/v4l2-core/v4l2-async.c
>>> @@ -47,9 +47,7 @@ static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
>>>        if (!is_of_node(sd->fwnode) || !is_of_node(asd->match.fwnode.fwnode))
>>>                return sd->fwnode == asd->match.fwnode.fwnode;
>>>
>>> -     return !of_node_cmp(of_node_full_name(to_of_node(sd->fwnode)),
>>> -                         of_node_full_name(
>>> -                                 to_of_node(asd->match.fwnode.fwnode)));
>>> +     return to_of_node(sd->fwnode) == to_of_node(asd->match.fwnode.fwnode);
 >>
>> I'm afraid this will not work, please see commit d2180e0cf77dc7a7049671d5d57d
>> "[media] v4l: async: make v4l2 coexist with devicetree nodes in a dt overlay"
 >
> Maybe I'm missing something, but how does that work exactly? Before
> the overlay is applied, the remote endpoint node (and its parent)
> can't be resolved. In the commit example, the endpoint in the
> media_bridge would also have to be part of the overlay. If you apply
> and un-apply the overlay, then the of_node (and fw_node) in the
> overlay is once again invalid. IOW, you should be in the same state as
> before the overlay was applied. The node is still around because of
> paranoia that actually freeing nodes would break things. It seems this
> paranoia is real, so i think we need to do something to prevent this
> from spreading.
> 
> Furthermore, it does not appear that any media driver supports
> overlays and we have no general way to apply them in mainline yet
> (other than an in kernel API). So really this scenario is not one we
> have to support yet.

Indeed, the motivation of the above mentioned commit was some out of
tree driver. I don't know was the exact use case, assuming that the
endpoint in the bridge node was also part of the overlay the bridge
driver must have not been rescanning device tree after overlay un-apply
and apply. Currently there is no other way to do this than to unbind
and bind. So the bridge driver must have been referencing an already
invalid node as you point out.

I haven't been following DT overlays very closely, as Frank explains
your change seems to be actually an improvement of current code.

-- 
Thanks,
Sylwester
