From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 11 Apr 2013 14:11:34 +0100
Subject: [PATCH v5 2/3] of/pci: Provide support for parsing PCI DT
 ranges property
In-Reply-To: <5165AEBA.7000803@gmail.com>
References: <1365578969-30966-1-git-send-email-Andrew.Murray@arm.com>
 <1365578969-30966-3-git-send-email-Andrew.Murray@arm.com>
 <5165AEBA.7000803@gmail.com>
Message-ID: <20130411131134.GC28981@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 07:26:02PM +0100, Rob Herring wrote:
> On 04/10/2013 02:29 AM, Andrew Murray wrote:
> > This patch factors out common implementation patterns to reduce overall kernel
> > code and provide a means for host bridge drivers to directly obtain struct
> > resources from the DT's ranges property without relying on architecture specific
> > DT handling. This will make it easier to write archiecture independent host bridge
> > drivers and mitigate against further duplication of DT parsing code.
> >
> > This patch can be used in the following way:
> >
> >       struct of_pci_range_parser parser;
> >       struct of_pci_range range;
> >
> >       if (of_pci_range_parser(&parser, np))
> >               ; //no ranges property
> >
> >       for_each_of_pci_range(&parser, &range) {
> >
> >               /*
> >                       directly access properties of the address range, e.g.:
> >                       range.pci_space, range.pci_addr, range.cpu_addr,
> >                       range.size, range.flags
> >
> >                       alternatively obtain a struct resource, e.g.:
> >                       struct resource res;
> >                       of_pci_range_to_resource(&range, np, &res);
> >               */
> >       }
> >
> > Additionally the implementation takes care of adjacent ranges and merges them
> > into a single range (as was the case with powerpc and microblaze).
> >
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> 
> A few minor things below, otherwise:
> 
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> 

Thanks for the feedback, I've included this in my next spin.

Andrew Murray
