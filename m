From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jan 2014 17:01:56 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140113164021.GA6934@e102568-lin.cambridge.arm.com>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-4-git-send-email-broonie@kernel.org>
 <20140113164021.GA6934@e102568-lin.cambridge.arm.com>
Message-ID: <20140113170156.GC29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 04:40:21PM +0000, Lorenzo Pieralisi wrote:
> On Sun, Jan 12, 2014 at 07:20:40PM +0000, Mark Brown wrote:

> > @@ -89,7 +113,7 @@ static void __init parse_cluster(struct device_node *cluster, int depth)
> >  	bool leaf = true;
> >  	bool has_cores = false;
> >  	struct device_node *c;
> > -	static int cluster_id = 0;
> > +	static int cluster_id;

> It has to be __initdata, and the line change above does not belong in
> this patch but patch 1.

I would really have expected static data from a function marked init to
end up marked appropriately, but whatever.

> > +		rate = of_get_property(cn, "clock-frequency", &len);
> > +		if (!rate || len != 4) {
> > +			pr_err("%s: Missing clock-frequency property\n",
> > +				cn->full_name);
> > +			continue;
> > +		}

> I am wondering why we spit an error for a property that in practice is
> optional. Either we make it required, or we drop the error output.

> Actually this is not defined anywhere apart from the ePAPR, which
> defines this property as required, but following your attempt to
> standardize it for ARM, I gather it should be considered optional.

It's already standard in the spec we claim to be following...

> If it is optional, should we really print an error ? (I know it is the
> same on arm32, I am questioning that code too).

For big.LITTLE systems with the current implementation this information
is required in order to scale the relative performances of the cores -
such a system the maximum frequencies of the cores may vary as well as
their type (or indeed theoretically even only their maximum frequency).
We could at some future time end up evolving the code so that this
information is acquired from cpufreq or somewhere but that's something
that should probably happen kernel wide as part of the scheduler work
rather than going off and doing something custom.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/27886b75/attachment.sig>
