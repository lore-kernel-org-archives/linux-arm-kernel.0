From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 10 Apr 2014 07:50:52 -0600
Subject: [PATCH v7 4/6] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <4506772.YFSM2m1eaP@wuerfel>
References: <1394811272-1547-5-git-send-email-Liviu.Dudau@arm.com>
 <20140410012715.GA1328@bart>
 <CAErSpo7egL2T_W_OCJw2kPHFDqspwOHXtZJw8JyjWU=56ofFKQ@mail.gmail.com>
 <4506772.YFSM2m1eaP@wuerfel>
Message-ID: <CAErSpo6u7kr+QdnhAXBo20izg-DNHR4zHT+kRvq34whp68RJCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 2:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 April 2014 21:48:14 Bjorn Helgaas wrote:
>> On Wed, Apr 9, 2014 at 7:27 PM, Liviu Dudau <liviu@dudau.co.uk> wrote:
>> > On Wed, Apr 09, 2014 at 08:02:41AM -0600, Bjorn Helgaas wrote:
>> >> >>   struct pci_host_bridge {
>> >> >>     int domain;
>> >> >>     int node;
>> >> >>     struct device *dev;
>> >> >>     struct pci_ops *ops;
>> >> >>     struct list_head resources;
>> >> >>     void *sysdata;
>> >> >>     struct pci_bus *bus;  /* filled in by core, not by arch */
>> >> >>     ... /* other existing contents managed by core */
>> >> >>   };
>> >> >>
>> >> >>   struct pci_bus *pci_scan_host_bridge(struct pci_host_bridge *bridge);
>> >> >
>> >> > I'm really reluctant to give the arches more rope to hang themselves.
>> >>
>> >> If you mean the sysdata pointer is rope to hang themselves, I think it
>> >> would be great it we didn't need sysdata at all.  But I think it would
>> >> be a huge amount of work to get rid of it completely, and keeping it
>> >> would let us work at that incrementally.
>> >
>> > Agree. But then your suggestion was to wrap sysdata inside another structure,
>> > which to me constitutes additional rope.
>>
>> I'll ponder this more, but I don't see your point here yet.  The arch
>> already supplies a sysdata pointer to pci_scan_root_bus(), and we
>> stash it in every struct pci_bus already.  My idea was just to pass it
>> in differently, as a structure member rather than a separate argument.
>>  (And I'm not completely attached to my proposal; it was only to
>> illustrate my concern about the explosion of interfaces if we have to
>> add *_domain(), *_node(), etc.)
>
> As a minor variation of your suggestion, how about passing in a pointer
> to struct pci_host_bridge, and embed that within its own private
> structure? I think this is closer to how a lot of other subsystems
> do the abstraction.

I'm not sure I'm following you; you mean the arch-specific sysdata
structure would contain a pointer to struct pci_host_bridge?

I have to admit that I'm not up on how other subsystems handle this
sort of abstraction.  Do you have any pointers to good examples that I
can study?

Bjorn
