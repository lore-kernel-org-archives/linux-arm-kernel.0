From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Fri, 28 Jul 2017 01:20:44 +0200
Subject: [PATCH] ASoC: fix balance of of_node_get()/of_node_put()
In-Reply-To: <20170726113728.fpj3kboxib5tnmzv@sirena.org.uk>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
 <20170726113728.fpj3kboxib5tnmzv@sirena.org.uk>
Message-ID: <CAAj6DX3fwAY+vLDqYud7bMVjLFV2XcSix4YM8Z3FxP10n6R+_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
thanks for the review.

On Wed, Jul 26, 2017 at 1:37 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 25, 2017 at 11:49:52PM +0200, Antonio Borneo wrote:
>
>> Fixed by:
>> - removing of_node_put() in the body of of_for_each_phandle(){},
>>   since already provided at each iteration. Add it in case the
>>   loop is break out;
>> - adding of_node_get() before calling of_graph_get_port_parent()
>>   or asoc_graph_card_dai_link_of().
>
>>  sound/soc/generic/audio-graph-card.c  | 14 +++++++++-----
>>  sound/soc/generic/simple-card-utils.c |  5 +++++
>>  sound/soc/soc-core.c                  |  5 +++++
>>  3 files changed, 19 insertions(+), 5 deletions(-)
>
> This is a series of different changes to fix different (although
> related) problems which should be being submitted individually.  Sending
> multiple changes in one patch makes it harder to review things and for
> fixes like this makes it harder to backport the fixes where not all the
> code being fixed was introduced in a single kernel version.

Agree! Will split it and send a v2.

>>       of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
>> +             /*
>> +              * asoc_graph_card_dai_link_of() will call
>> +              * of_node_put(). So, call of_node_get() here
>> +              */
>> +             of_node_get(it.node);
>>               ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
>
> Why is this the most sensible fix?  It is really not at all obvious why
> asoc_graph_card_dai_link_of() would drop a reference, or in what
> situations callers might have a reference they're OK with dropping.

Actually this part is wrong. Splitting for v2 and rechecking every
step I get that it's not this function that drops the reference; the
fix is already covered by the rest of the patch. Sorry for the
mistake.

>> +     /*
>> +      * of_graph_get_port_parent() will call
>> +      * of_node_put(). So, call of_node_get() here
>> +      */
>> +     of_node_get(ep);
>>       node = of_graph_get_port_parent(ep);
>
> Same here, why does this make sense?  It is not in the least bit obvious
> to me why looking up the parent of a node would cause us to drop the
> reference to the current node, this seems like an error prone and
> confusing API which would be better fixed.

I tend to agree with you, quite error prone and confusing. I spent
some time to identify who is dropping what.
Actually there is a bunch of functions like this in driver/of/; they
take a node as parameter and return a node, while doing a put of the
parameter. While questionable, looks like there is at least some
consistency.
Maybe the "get" in the API name should match the implicit
of_node_get() of the returned node (not sure it is the case on all
such API). Something else in the name should indicate if the input
node will be of_node_put(). Suggestions are welcome, but I think the
discussion goes beyond the scope of this fix.
In this specific case, I lazily reused some code already upstream here
http://elixir.free-electrons.com/linux/v4.13-rc2/source/sound/soc/generic/simple-card-utils.c#L285
I added in copy Kuninori Morimoto, the developer of the lines above,
in case he has any hint.

Antonio
