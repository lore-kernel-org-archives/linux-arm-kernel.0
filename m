From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 19 Jul 2017 14:05:42 -0700
Subject: [PATCH] media: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqLDCgO60ECGB70pMNcaLg0zUcJ6_+50vH-evfGe-D266Q@mail.gmail.com>
References: <CGME20170718215328epcas2p2e5e1d7df96fcd894e70a961df864abdd@epcas2p2.samsung.com>
 <20170718214339.7774-33-robh@kernel.org>
 <564a6768-3b23-6dc7-ecb5-cb4f4359b633@samsung.com>
 <CAL_JsqLDCgO60ECGB70pMNcaLg0zUcJ6_+50vH-evfGe-D266Q@mail.gmail.com>
Message-ID: <596FC9A6.7090509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/17 09:02, Rob Herring wrote:
> On Wed, Jul 19, 2017 at 4:41 AM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 07/18/2017 11:43 PM, Rob Herring wrote:
>>> Now that we have a custom printf format specifier, convert users of
>>> full_name to use %pOF instead. This is preparation to remove storing
>>> of the full path string for each node.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>
>>> ---

< snip >

>>> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
>>> index 851f128eba22..0a385d1ff28c 100644
>>> --- a/drivers/media/v4l2-core/v4l2-async.c
>>> +++ b/drivers/media/v4l2-core/v4l2-async.c
>>> @@ -47,9 +47,7 @@ static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
>>>       if (!is_of_node(sd->fwnode) || !is_of_node(asd->match.fwnode.fwnode))
>>>               return sd->fwnode == asd->match.fwnode.fwnode;
>>>
>>> -     return !of_node_cmp(of_node_full_name(to_of_node(sd->fwnode)),
>>> -                         of_node_full_name(
>>> -                                 to_of_node(asd->match.fwnode.fwnode)));
>>> +     return to_of_node(sd->fwnode) == to_of_node(asd->match.fwnode.fwnode);
>>
>> I'm afraid this will not work, please see commit d2180e0cf77dc7a7049671d5d57d
>> "[media] v4l: async: make v4l2 coexist with devicetree nodes in a dt overlay"

Commit d2180e0cf77dc7a7049671d5d57d seems to have a fundamental
misunderstanding of overlays, if I understand the implications of that
commit.

When an overlay (1) is removed, all uses and references to the nodes and
properties in that overlay are no longer valid.  Any driver that uses any
information from the overlay _must_ stop using any data from the overlay.
Any driver that is bound to a new node in the overlay _must_ unbind.  Any
driver that became bound to a pre-existing node that was modified by the
overlay (became bound after the overlay was applied) _must_ adjust itself
to account for any changes to that node when the overlay is removed.  One
way to do this is to unbind when notified that the overlay is about to
be removed, then to re-bind after the overlay is completely removed.

If an overlay (2) is subsequently applied, a node with the same
full_name as from overlay (1) may exist.  There is no guarantee
that overlay (1) and overlay (2) are the same overlay, even if
that node has the same full_name in both cases.


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

My understanding is that nodes from an un-applied overlay will be
freed if the expanded device tree that was used to create it has
its reference counts drop to zero.  But I wouldn't count on me
remembering this correctly without actually walking through all
the code.  And as far as I know, there is no example of this
in the mainline tree.


> Furthermore, it does not appear that any media driver supports
> overlays and we have no general way to apply them in mainline yet
> (other than an in kernel API). So really this scenario is not one we
> have to support yet.
> 
> Rob
> 
