From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Jun 2014 18:16:18 +0100
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <539A7480.20606@linux.vnet.ibm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
 <20140612090339.GB29295@e102568-lin.cambridge.arm.com>
 <539A7480.20606@linux.vnet.ibm.com>
Message-ID: <20140613171618.GB16745@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Preeti,

On Fri, Jun 13, 2014 at 04:48:16AM +0100, Preeti U Murthy wrote:

[...]

> >> Do you want this to be generally useful or is it just ARM-specific?
> > 
> > The first series was targeting ARM64, then I noticed that it might be
> > used for ARM too (Daniel is working on that). Actually, I discovered
> > that Power and MIPS can reuse at least the code that initializes the
> > states data too, but I have to point out three things:
> > 
> > 1) state enter function method: in my bindings it is common for all
> >    idle states, need to check if it applies to Power and MIPS too.
> 
> On PowerPC, we have a state enter function for each idle state. It will
> not be too difficult to consolidate them into one, but that is not on
> the cards right now.

Ok, understood, it can become trickier to do when DT bindings for ARM are
merged though, but I understand it is not your priority now.

> > 2) CPUIDLE_FLAG_TIMER_STOP and how to set it. It is non-trivial to
> >    add code that detects what idle states lose the tick device context.
> >    At the moment I am adding the flag by default to all idle states
> >    apart from standbywfi on ARM, but that can be optimised. Unless we
> >    resort to power domains (but that's not trivial), we can add a flag
> >    to the idle states in DT (ie local-timer-stop or suchlike) to support
> >    that. I think that it will be frowned upon but it is worth trying, would
> >    like to know what other people think about this.
> 
> On PowerPC we have a bit in flag property of the idle state device node,
> which determines if timers will stop. Yes, maybe we can fix it at a
> specific bit but it may be messy.

It is the same information defined differently, and TIMER_STOP on Power
is inferred from the entry method. I think that with a bit of work we
could make ends meet, not sure it has to be done now though.

> > 3) idle states bindings should be reviewed, I expect them to be valid
> >    on other architectures too, but I need acknowledgments.
> 
> The major difference as I see it is the idle state bindings. In your
> patch there is a device node for each idle state. On PowerPC however,
> currently we have a single node with the property values of this node
> determining the idle states' name, desc etc..
> 
> Besides this, the names of the device tree nodes for idle states could
> be arch specific to meet some hierarchical requirements in the device
> tree. This would make it difficult for this driver to parse the idle
> states based on a generic idle state node name.
> > 
> > I think this series is not far from being ready to be upstreamed, I
> > would be certainly happy if it can be reused for other archs too so
> > just let me know.
> 
> On PowerPC there are a couple of other sanity checks that we ought to do
> before initializing the driver.
> 
> So IMO, although we can press out the above mentioned differences in one
> way or the other to make way for a generic idle driver which reads from
> the device tree, I am not in favour of it since it has to concern itself
> with quite a bit of arch-specific stuff. This would anyway make it less
> and less of a generic idle driver. So its best to push this patch to be
> ARM specific.

We are not talking about having a common idle driver for all archs, we are
talking about having a common way to initialize idle states data and I think,
as you mentioned that it could be done (from what I read in your driver).
I understand it is not a priority so I will go ahead and leave it ARM
specific for now.

Thanks,
Lorenzo
