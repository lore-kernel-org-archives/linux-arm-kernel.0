From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 Jan 2014 14:29:29 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140107133829.GF31886@sirena.org.uk>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <1387483575-11430-4-git-send-email-broonie@kernel.org>
 <20140107130540.GA8090@e102568-lin.cambridge.arm.com>
 <20140107133829.GF31886@sirena.org.uk>
Message-ID: <20140107142929.GB8090@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 01:38:29PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2014 at 01:05:40PM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Dec 19, 2013 at 08:06:14PM +0000, Mark Brown wrote:
> 
> > > +		/* check if the cpu is marked as "disabled", if so ignore */
> > > +		if (!of_device_is_available(cn))
> > > +			continue;
> 
> > It is time we defined what a "disabled" CPU means in ARM world, I need to
> > have a proper look into this since this topic has been brought up before.
> 
> What is the confusion here - why would there be something architecture
> specific going on?

I think this check was added following this thread discussion:

http://lkml.indiana.edu/hypermail/linux/kernel/1306.0/03663.html

So my question is: what does "disabled" mean ? A CPU present in HW
that can't/must not be booted ?

ePAPR v1.1 page 43:

"disabled". The CPU is in a quiescent state. A quiescent CPU is in a state
where it cannot interfere with the normal operation of other CPUs, nor can
its state be affected by the normal operation of other running CPUs, except
by an explicit method for enabling or reenabling the quiescent CPU (see the
enable-method property).

This means that a "disabled" CPU can be booted with eg PSCI but that is
not what the thread in the link above wants to achieve. Furthermore, if
we add the check in topology.c, the check must be executed also when
building the cpu_logical_map, otherwise a "disabled" cpu would be marked
possible and then booted, am I wrong ?

Lorenzo
