From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jun 2014 17:34:00 +0100
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140604155129.GD10775@e102568-lin.cambridge.arm.com>
References: <1401644249-23792-1-git-send-email-broonie@kernel.org>
 <20140603173103.GA18004@red-moon>
 <20140603210424.GJ31751@sirena.org.uk>
 <20140604093452.GA8057@e102568-lin.cambridge.arm.com>
 <20140604115751.GH2520@sirena.org.uk>
 <20140604130114.GB10775@e102568-lin.cambridge.arm.com>
 <20140604135431.GL2520@sirena.org.uk>
 <20140604155129.GD10775@e102568-lin.cambridge.arm.com>
Message-ID: <20140604163400.GQ2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 04:51:29PM +0100, Lorenzo Pieralisi wrote:

> My question is: is it better to pack affinity levels and "guess" what aff3
> (and aff2 on non-SMT) means or add an additional level of hierarchy in the
> arm64 topology code (eg book_id - implemented only for s390 to the best
> of my knowledge) ?

Shoving them in there would address the issue as well, yes (though we'd
still have to combine aff2 and aff3 for the non-SMT case).  I don't know
if having books enabled has some overhead we don't want though.

> I personally prefer the latter approach but I think it boils down to
> understanding what do we want to provide the scheduler with if we have
> a hierarchy that extends beyond "cluster" level.

> I will be glad to help you implement it when time comes (and this will also
> fix the clusters of clusters DT issue we are facing - ie how to treat them).

> Now, I do not think it is a major problem at the moment, merging the
> patch I sent will give us more time to discuss how to define the
> topology for clusters of clusters, because that's what we are talking
> about.

In so far as you're saying that we don't really need to worry about
exactly how we handle multi-level clusters properly at the minute I
agree with you - until we have some idea what they physically look like
and can consider how well that maps onto the scheduler and whatnot it
doesn't really matter and we can just ignore it.  Given that I'm not
concerned about just reporting everything as flat like we do with DT at
the minute and don't see a real need to theorise about it, it'll just be
a performance problem and not a correctness problem when it is
encountered.  That feels like a better position to leave things in as it
will be less stress for whoever is bringing up such a fancy new system,
they can stand a reasonable chance of getting things at least running
with minimal effort.

> Does it make sense ?

Like I say I do think that merging your current code is better than
nothing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/8aeccc55/attachment-0001.sig>
