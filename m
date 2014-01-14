From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 12:36:47 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140114114336.GB28912@e102568-lin.cambridge.arm.com>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-3-git-send-email-broonie@kernel.org>
 <20140114114336.GB28912@e102568-lin.cambridge.arm.com>
Message-ID: <20140114123647.GC15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 11:43:37AM +0000, Lorenzo Pieralisi wrote:
> On Sun, Jan 12, 2014 at 07:20:39PM +0000, Mark Brown wrote:

> > +static void __init parse_core(struct device_node *core, int cluster_id,
> > +			      int core_id)
> > +{
> > +	char name[10];
> > +	bool leaf = true;
> > +	int i, cpu;
> > +	struct device_node *t;
> > +
> > +	i = 0;

> You could initialize i at declaration, I can understand why you are doing that
> explictly in parse_cluster (two loops, to make code clearer), but here
> it does not make much sense to add a line for that.

I still find it clearer for do { } while loops to have the start
condition required for the loop to function right next to the loop.
Yes, you can save a line code but that's about it.

> > +	do {
> > +		snprintf(name, sizeof(name), "thread%d", i);

> If we wanted to be very picky, you need to copy "thread" just once (same
> goes for other strings), but we'd better leave code as is IMHO.

That would just make the code more complex, we need to handle tens of
cores so just doing i + '0' won't cut it.

> > +		t = of_get_child_by_name(core, name);

> Should we check the MT bit in MPIDR_EL1 before validating threads as well ?

> I do not like the idea because this means reliance on MPIDR_EL1 for MT
> and DT for topology bits, but it might be a worthwhile check.

> It is certainly odd to have a DT with threads and an MPIDR_EL1 with the MT
> bit clear.

Checking seems counter to the idea of forcing everyone to provide this
information from the firmware in the first place - checking that one bit
and ignoring the rest of the information even if it's good would seem
perverse.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/8b118e09/attachment.sig>
