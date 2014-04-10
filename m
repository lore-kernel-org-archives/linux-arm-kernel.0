From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Apr 2014 10:00:17 +0200
Subject: [PATCH v7 4/6] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <CAErSpo7egL2T_W_OCJw2kPHFDqspwOHXtZJw8JyjWU=56ofFKQ@mail.gmail.com>
References: <1394811272-1547-5-git-send-email-Liviu.Dudau@arm.com>
 <20140410012715.GA1328@bart>
 <CAErSpo7egL2T_W_OCJw2kPHFDqspwOHXtZJw8JyjWU=56ofFKQ@mail.gmail.com>
Message-ID: <4506772.YFSM2m1eaP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 April 2014 21:48:14 Bjorn Helgaas wrote:
> On Wed, Apr 9, 2014 at 7:27 PM, Liviu Dudau <liviu@dudau.co.uk> wrote:
> > On Wed, Apr 09, 2014 at 08:02:41AM -0600, Bjorn Helgaas wrote:
> >> >>   struct pci_host_bridge {
> >> >>     int domain;
> >> >>     int node;
> >> >>     struct device *dev;
> >> >>     struct pci_ops *ops;
> >> >>     struct list_head resources;
> >> >>     void *sysdata;
> >> >>     struct pci_bus *bus;  /* filled in by core, not by arch */
> >> >>     ... /* other existing contents managed by core */
> >> >>   };
> >> >>
> >> >>   struct pci_bus *pci_scan_host_bridge(struct pci_host_bridge *bridge);
> >> >
> >> > I'm really reluctant to give the arches more rope to hang themselves.
> >>
> >> If you mean the sysdata pointer is rope to hang themselves, I think it
> >> would be great it we didn't need sysdata at all.  But I think it would
> >> be a huge amount of work to get rid of it completely, and keeping it
> >> would let us work at that incrementally.
> >
> > Agree. But then your suggestion was to wrap sysdata inside another structure,
> > which to me constitutes additional rope.
> 
> I'll ponder this more, but I don't see your point here yet.  The arch
> already supplies a sysdata pointer to pci_scan_root_bus(), and we
> stash it in every struct pci_bus already.  My idea was just to pass it
> in differently, as a structure member rather than a separate argument.
>  (And I'm not completely attached to my proposal; it was only to
> illustrate my concern about the explosion of interfaces if we have to
> add *_domain(), *_node(), etc.)

As a minor variation of your suggestion, how about passing in a pointer
to struct pci_host_bridge, and embed that within its own private
structure? I think this is closer to how a lot of other subsystems
do the abstraction.

> > The "what" for PCI host bridges is defined in the spec. The "how" is implementation
> > defined. What I'm trying to get with the cleanup is the ordering of pci_host_bridge
> > creation: core creates the structure first ("what"), arch then has the chance
> > of adding specific data to it (ops, resources, etc) ("how").
> >
> > At the moment arm and powerpc do some horrible dances in trying to create their
> > local idea of a host bridge before passing it to the core code.
> >
> > As for the root bus number, maybe we can offer some sensible default strategy
> > for numbering them and the arches that don't care too much can use that.
> 
> I think we're at the limit of what can be accomplished with the
> abstractness of English.
> 
> My opinion is that it's reasonable for the arch to discover the host
> bridge properties first and pass them to the core, and it doesn't
> require unreasonable things of the arch.  I know the arm PCI setup is
> complicated, partly because it deals with a huge number of machines
> that don't have a consistent firmware interface.  The x86/ACPI setup
> is relatively simple because it deals with a simple firmware
> interface.  But that's just my opinion, and maybe your code will show
> otherwise.

Makes sense. One of the areas where the PCI code shows its age is the
method how the various parts link together: there are function calls
going back and forth between architecture specific files and generic
files, rather a hierarchy of files with generic code being code by more
specific code.

To do the probing properly, I think it's totally fine to have the
core code expect stuff like the resources and domain number
to be filled out already by whoever calls it, but then have wrappers
around it that get this information from a firmware interface, or
from hardwired architecture specific code where necessary.

	Arnd
