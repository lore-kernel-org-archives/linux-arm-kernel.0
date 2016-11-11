From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Nov 2016 16:46:10 +0000
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20161107154738.ewliwzx5plams4ni@lukather>
References: <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
 <20160117000434.GB7774@rob-hp-laptop>
 <20160118162538.GH6588@sirena.org.uk>
 <20160121154649.GE3997@lukather>
 <20160121162802.GL6588@sirena.org.uk>
 <20160205143328.GD31506@lukather>
 <20160205153258.GW4455@sirena.org.uk>
 <20161107154738.ewliwzx5plams4ni@lukather>
Message-ID: <20161111164610.rocq76fopcxjkafa@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 04:47:38PM +0100, Maxime Ripard wrote:

> Since regulator_get returns a struct regulator pointer, it felt
> logical to try to add the list of parent regulators to it, especially
> as this structure is per-consumer, and different consumers might have
> different combinations of regulators.

> However, this structure embeds a pointer to a struct regulator_dev,
> which seems to model the regulator itself, but will also contain
> pointer to the struct regulator, probably to model its parent? I guess

It'd be a lot easier to follow this if you named the fields...  The rdev
in the struct regulator is indeed the physical device.  The struct
regulator called supply in struct regulator_dev is indeed the parent
regulator.

> my first question would be do we care about nesting? or having a
> regulator with multiple parents?

Well, it seems that your use case here is multiple parents so I guess we
do care about it.  :)

> It also contains the constraints on each regulator, which might or
> might not be different for each of the coupled regulators, but I'm
> guessing the couple might have contraints of its own too I guess. Is
> it something that might happen? Should we care about it?

I can't see how one could physically have constraints that didn't apply
to both parents.

> And finally, my real question is, do we want to aggregate them in
> struct regulator, at the consumer level, which might make the more
> sense, or do we want to create an intermediate regulator internally?
> What is your take on this?

My initial thought without having tried to implement this is that doing
things in an intermediate regulator might do a better job of
encapsulating things it if it works out but I've got a feeling that it's
not going to work out well and that therefore doing it in the consumer
with multiple rdevs will be better.  But really either approach is fine
if it doesn't look horrible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/8ecde8e8/attachment.sig>
