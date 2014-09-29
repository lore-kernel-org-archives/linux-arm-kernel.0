From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 30 Sep 2014 08:31:52 +1000
Subject: [PATCH v13 10/12] PCI: Assign unassigned bus resources in
 pci_scan_root_bus()
In-Reply-To: <CAErSpo62ap1YkzvuZ6MCpXry9=VpLv+Skzrwr10h=+Lc4VfVgQ@mail.gmail.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
 <1412000971-9242-11-git-send-email-Liviu.Dudau@arm.com>
 <CAE9FiQXEUZvkuzwOrK+2zGVj0ywFaQsiWH7SHufZk9BRWnwddQ@mail.gmail.com>
 <CAE9FiQUkcPRMUEn01VJMyXz8aYvk6C5MBNZi5NCV2m3qkNabeg@mail.gmail.com>
 <1412024521.4285.98.camel@pasglop>
 <CAErSpo62ap1YkzvuZ6MCpXry9=VpLv+Skzrwr10h=+Lc4VfVgQ@mail.gmail.com>
Message-ID: <1412029912.4285.110.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-29 at 15:33 -0600, Bjorn Helgaas wrote:
> > Right and on powerpc and others as well. We need to survey existing
> > resources. We also have a number of platform things that might need
> > to happen before we do the final re-assignment pass.
> 
> That's true today.  But I don't know whether it *has* to be this way
> forever.  On x86, pcibios_resource_survey() throws in E820 information
> (which we know long before we do any PCI enumeration) and some IO-APIC
> resources (it looks like we also know these before PCI enumeration).
> Powerpc has pcibios_reserve_legacy_regions(), but that looks like
> mostly stuff that could be done when we find the host bridge, before
> we enumerate PCI devices below it.

Oh we can probably change that but it's going to be much more work than
just moving the assignment into pci_scan_root_bus(). There are also a
number of subtle and not-so-subtle bits of code that rely on side
effects of the current code such as anything that tests for bus->added
or dev->added. Again, nothing we can't sort out eventually but the
transition might be a bit painful.

We might need to introduce a new flag for platforms converted to the
"new style" generalized resource assignment which we can deprecate once
everybody has moved over.

Cheers,
Ben.
 
