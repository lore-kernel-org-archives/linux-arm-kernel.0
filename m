From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jan 2016 18:06:39 +0000
Subject: [PATCH] arm64, pci, numa: Adding helper functions as required by
 pci
In-Reply-To: <20160108180131.GB5354@localhost>
References: <1450780730-13667-1-git-send-email-gkulkarni@caviumnetworks.com>
 <20160108180131.GB5354@localhost>
Message-ID: <20160108180638.GF11228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 12:01:31PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 22, 2015 at 04:08:50PM +0530, Ganapatrao Kulkarni wrote:
> > Adding helper functions and necessary code to make
> > pci driver(pci-host-generic) numa aware.
> > 
> > This patch is on top of arm64-numa v7.
> > http://www.spinics.net/lists/arm-kernel/msg460813.html
> > 
> > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> > ---
> >  arch/arm64/include/asm/numa.h       | 8 +++++---
> >  arch/arm64/kernel/pci.c             | 8 ++++++++
> >  drivers/pci/host/pci-host-generic.c | 1 +
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> > index b8c2a3f..1eca4db 100644
> > --- a/arch/arm64/include/asm/numa.h
> > +++ b/arch/arm64/include/asm/numa.h
> > @@ -15,9 +15,11 @@
> >  extern int __node_distance(int from, int to);
> >  #define node_distance(a, b) __node_distance(a, b)
> >  
> > -/* dummy definitions for pci functions */
> > -#define pcibus_to_node(node)	0
> > -#define cpumask_of_pcibus(bus)	0
> > +struct pci_bus;
> > +extern int pcibus_to_node(struct pci_bus *bus);
> > +#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
> > +				 cpu_all_mask :				\
> > +				 cpumask_of_node(pcibus_to_node(bus)))
> 
> All the arch definitions of cpumask_of_pcibus() are pretty similar;
> could they be made more generic?  At the very least, can you drop the
> definition here and use the one in include/asm-generic/topology.h,
> which is identical to what you're defining here?

+1 on that. I asked for exactly the same thing in my review of v7:

  http://www.spinics.net/lists/arm-kernel/msg469592.html

but it looks like I was just ignored.

Will
