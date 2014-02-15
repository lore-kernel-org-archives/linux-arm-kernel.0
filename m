From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Feb 2014 14:03:26 +0100
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140214220047.GA5394@bart.dudau.co.uk>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <5805232.JrD2FybBlg@wuerfel> <20140214220047.GA5394@bart.dudau.co.uk>
Message-ID: <2312919.pM61KLBcYY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 February 2014 22:00:47 Liviu Dudau wrote:
> 
> What I'm going to suggest in my v2 patch (hope to send it before Monday)
> is a new API in the generic PCI code that will allow you to create a
> host bridge in a new domain or in the existing domain, with the management
> of the domain number being done in the generic code.
> 
> Something like:
> 
>   int create_hostbridge_in_new_domain(....);
>   int create_hostbridge(....);
> 
> with the functions being wrappers around the pci_hostbridge_of_init function
> that I'm introducing.
> 
> What do you think?

Not sure. It would still keep the decision about whether to use a
new domain or not in the host bridge driver, but that doesn't seem
like the right place. The same driver might be used in different
ways based on what is around it.

I've also had a look at the MIPS implementation now, which has its
own way of dealing with this, see arch/mips/pci/pci.c.

There was also an interesting comment in the MIPS header file:

        /* For compatibility with current (as of July 2003) pciutils
           and XFree86. Eventually will be removed. */
        unsigned int need_domain_info;

This is over ten years old, so I wonder if we can start assuming that
domains work out of the box now. All references to problems from 
PCI domains are about old code (ca. pre-2007) that doesn't understand
nonzero domains and that has since been fixed. I am pretty sure we
don't need to ever worry about stuffing multiple host bridges into
a domain other than the first one, and I also doubt we have to worry
about the problem at all on arm64 as we won't run old binaries on it
(or arm32 compat mode binaries that need to manage PCI devices).

Can anyone with more experience on the subject than me (Bjorn,
Russell, Jason, ...) think of a reason why we would not want to
just use a new domain for every host bridge we find?

If we do need to stuff multiple buses into one domain, how about
using this approach in pci_hostbridge_of_init():

  The first time we add a host bridge, scan the entire DT for
  devices setting device_type="pci". If there is actually more
  than one host bridge, check all "bus-range" properties to
  see if they overlap. If there is no overlap or only one
  bridge, don't use domains.
  If there is any overlap at all, or there are multiple host
  bridge and one of them does not have a bus-range property,
  use a separate domain per host bridge.
  Remember the function was called before so it doesn't
  have to scan the DT again, and count the domain locally.

Does this make sense?

	Arnd
