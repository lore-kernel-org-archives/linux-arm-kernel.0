From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jan 2014 13:26:20 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140109125052.GB6089@e102568-lin.cambridge.arm.com>
References: <1389208330-12495-1-git-send-email-broonie@kernel.org>
 <1389208330-12495-2-git-send-email-broonie@kernel.org>
 <20140109125052.GB6089@e102568-lin.cambridge.arm.com>
Message-ID: <20140109132620.GL31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:50:52PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 08, 2014 at 07:12:08PM +0000, Mark Brown wrote:

> > +#ifdef CONFIG_OF
> > +static int cluster_id;

> This is __initdata. I think it is better to move it to parse_cluster
> and pass it to parse_core as a parameter instead of using a global.

Should be __initdata, yes.  I actually started using pointers but
passing the pointer around just seemed more ugly, it made the code in
the functions look more scary due to the dereferences.

> > +	cpu_node = of_parse_phandle(node, "cpu", 0);
> > +	if (!cpu_node) {
> > +		pr_crit("%s: Unable to parse CPU phandle\n", node->full_name);

> This messages is spit out anytime you try to grab a cpu phandle and it
> is not there. In particular, in parse_core if core is not a leaf but you
> still try to grab a cpu phandle this message is spit out and that's not
> nice at all. Either we remove the message or we do not check the phandle
> in core nodes that are not leaves.

I'll just drop it.

> > +			cpu = get_cpu_for_node(t);
> > +			if (cpu >= 0) {
> > +				pr_info("CPU%d: socket %d core %d thread %d\n",
> > +					cpu, cluster_id, core_id, i);

> Since all these variables are internal values that have no real meaning
> I am not sure it is useful to print them out. Probably better to print
> the resulting cpu masks on every cpu, problem is when to do that.

I found it was useful for getting a quick overview of the topology from
the logs - the actual numbers don't matter but being able to see which
cores are grouped together seemed useful.  I'm not sure the masks would
be an improvement for the human reader, I'd expect that presenting more
decoded information would be more helpful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/64be5a90/attachment.sig>
