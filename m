From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 15 Jun 2016 15:48:21 +0100
Subject: [PATCH v5 4/8] arm64: parse cpu capacity-dmips-mhz from DT
In-Reply-To: <20160615134938.GA2282@sirena.org.uk>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-5-git-send-email-juri.lelli@arm.com>
 <20160615134938.GA2282@sirena.org.uk>
Message-ID: <20160615144821.GF5981@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/16 14:49, Mark Brown wrote:
> On Wed, Jun 15, 2016 at 11:17:53AM +0100, Juri Lelli wrote:
> 
> > +		if (!raw_capacity) {
> > +			raw_capacity = kzalloc(sizeof(*raw_capacity) *
> > +					num_possible_cpus(), GFP_KERNEL);
> 
> kcalloc()?
> 

Right. Will change.

> > +			if (!raw_capacity) {
> > +				pr_err("cpu_capacity: failed to allocate memory"
> > +				       " for raw capacities\n");
> 
> It's normally better to avoid splitting errors message so people can
> grep if they see the error.
> 

Tried to avoid breaking 80 columns. But, we seem to have longer pr_err
strings already. I'll change that.

> > +	} else {
> > +		pr_err("cpu_capacity: missing %s raw capacity "
> > +		       "(fallback to 1024 for all CPUs)\n",
> > +				cpu_node->full_name);
> 
> That's going to complain fairly loudly for all existing DTs isn't it and
> it's kind of redundant if all the cores have the same capacity (which is
> a very common case)?  How about printing an error only if we already
> found one, or printing a single warning at the end if we didn't get
> anything?

Right, I'll change the condition for which pr_err is emitted. I think
the situation for which we care the most about is when we find partial
information in DT.

Thanks,

- Juri
