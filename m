From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 27 Jul 2010 09:41:40 +0200
Subject: [PATCHv2 2/4] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <201007262228.42358.hverkuil@xs4all.nl>
References: <cover.1280151963.git.m.nazarewicz@samsung.com>
	<743102607e2c5fb20e3c0676fadbcb93d501a78e.1280151963.git.m.nazarewicz@samsung.com>
	<dc4bdf3e0b02c0ac4770927f72b6cbc3f0b486a2.1280151963.git.m.nazarewicz@samsung.com>
	<201007262228.42358.hverkuil@xs4all.nl>
Message-ID: <002801cb2d5f$2b288550$81798ff0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, July 26, 2010 10:29 PM Hans Verkuil wrote:

> Hi Michal,
> 
> Thanks for working on this, we definitely need something along these lines.
> 
> On Monday 26 July 2010 16:40:30 Michal Nazarewicz wrote:
> > The Contiguous Memory Allocator framework is a set of APIs for
> > allocating physically contiguous chunks of memory.
> >
> > Various chips require contiguous blocks of memory to operate.  Those
> > chips include devices such as cameras, hardware video decoders and
> > encoders, etc.
> >
> > The code is highly modular and customisable to suit the needs of
> > various users.  Set of regions reserved for CMA can be configured on
> > run-time and it is easy to add custom allocator algorithms if one
> > has such need.
> >
> > For more details see Documentation/contiguous-memory.txt.
> >
> > Signed-off-by: Michal Nazarewicz <m.nazarewicz@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Reviewed-by: Pawel Osciak <p.osciak@samsung.com>
> > ---
> >  Documentation/00-INDEX                             |    2 +
> >  .../ABI/testing/sysfs-kernel-mm-contiguous         |    9 +
> >  Documentation/contiguous-memory.txt                |  646 +++++++++++
> >  Documentation/kernel-parameters.txt                |    4 +
> >  include/linux/cma.h                                |  445 ++++++++
> >  mm/Kconfig                                         |   34 +
> >  mm/Makefile                                        |    3 +
> >  mm/cma-best-fit.c                                  |  407 +++++++
> >  mm/cma.c                                           | 1170
> ++++++++++++++++++++
> >  9 files changed, 2720 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-contiguous
> >  create mode 100644 Documentation/contiguous-memory.txt
> >  create mode 100644 include/linux/cma.h
> >  create mode 100644 mm/cma-best-fit.c
> >  create mode 100644 mm/cma.c
> >
> > diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
> > index 5405f7a..bb50209 100644
> > --- a/Documentation/00-INDEX
> > +++ b/Documentation/00-INDEX
> > @@ -94,6 +94,8 @@ connector/
> >  	- docs on the netlink based userspace<->kernel space communication
> mod.
> >  console/
> >  	- documentation on Linux console drivers.
> > +contiguous-memory.txt
> > +	- documentation on physically-contiguous memory allocation framework.
> >  cpu-freq/
> >  	- info on CPU frequency and voltage scaling.
> >  cpu-hotplug.txt
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-contiguous
> b/Documentation/ABI/testing/sysfs-kernel-mm-contiguous
> > new file mode 100644
> > index 0000000..05e2f6a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-contiguous
> > @@ -0,0 +1,9 @@
> > +What:		/sys/kernel/mm/contiguous/
> > +Date:		July 2008
> > +Contact:	Michal Nazarewicz <m.nazarewicz@samsung.com>
> > +Description:
> > +		/sys/kernel/mm/contiguous/ contains two files: asterisk and
> > +		map.  They are used to configure the Contiguous Memory
> > +		Allocator framework.
> > +
> > +		For details see Documentation/contiguous-memory.txt.
> > diff --git a/Documentation/contiguous-memory.txt
> b/Documentation/contiguous-memory.txt
> > new file mode 100644
> > index 0000000..6eb1295
> > --- /dev/null
> > +++ b/Documentation/contiguous-memory.txt
> > @@ -0,0 +1,646 @@
> > +                                                             -*- org -*-
> > +
> > +* Contiguous Memory Allocator
> > +
> > +   The Contiguous Memory Allocator (CMA) is a framework, which allows
> > +   setting up a machine-specific configuration for physically-contiguous
> > +   memory management. Memory for devices is then allocated according
> > +   to that configuration.
> > +
> > +   The main role of the framework is not to allocate memory, but to
> > +   parse and manage memory configurations, as well as to act as an
> > +   in-between between device drivers and pluggable allocators. It is
> > +   thus not tied to any memory allocation method or strategy.
> > +
> > +** Why is it needed?
> > +
> > +    Various devices on embedded systems have no scatter-getter and/or
> > +    IO map support and as such require contiguous blocks of memory to
> > +    operate.  They include devices such as cameras, hardware video
> > +    decoders and encoders, etc.
> > +
> > +    Such devices often require big memory buffers (a full HD frame is,
> > +    for instance, more then 2 mega pixels large, i.e. more than 6 MB
> > +    of memory), which makes mechanisms such as kmalloc() ineffective.
> > +
> > +    Some embedded devices impose additional requirements on the
> > +    buffers, e.g. they can operate only on buffers allocated in
> > +    particular location/memory bank (if system has more than one
> > +    memory bank) or buffers aligned to a particular memory boundary.
> > +
> > +    Development of embedded devices have seen a big rise recently
> > +    (especially in the V4L area) and many such drivers include their
> > +    own memory allocation code. Most of them use bootmem-based methods.
> > +    CMA framework is an attempt to unify contiguous memory allocation
> > +    mechanisms and provide a simple API for device drivers, while
> > +    staying as customisable and modular as possible.
> > +
> > +** Design
> > +
> > +    The main design goal for the CMA was to provide a customisable and
> > +    modular framework, which could be configured to suit the needs of
> > +    individual systems.  Configuration specifies a list of memory
> > +    regions, which then are assigned to devices.  Memory regions can
> > +    be shared among many device drivers or assigned exclusively to
> > +    one.  This has been achieved in the following ways:
> 
> OK, I like the idea of regions, i.e. defining memory areas with specific
> properties or uses.
> 
> But why should it be possible to define regions through kernel parameters?
> Regions are typically fixed for a particular platform and can be setup in
> the
> platform specific code. Actually, one region could be setup by default:
> DMA-able memory. That would be very handy in fact for many PCI-based TV
> capture drivers.

IMHO this is a just desktop-point-of-view. In embedded world things are
a bit different. Most SoCs have a some kind of common system memory and
usually all build-in peripherals are able to DMA to any part of it (there is
no DMA specific hardware zone).

> I think that the only thing that you want to set in the kernel params is
> the size of each region.

Keeping it as a kernel parameter is very handy for development. But I agree
that we might make it dependent on some Kconfig entry. This way a platform
setup code would provide default region description just as an array of the
region structures and we will get rid of the parsing code in the release
versions.
 
> The same with assigning regions to drivers: why would you want to do that?
> The driver should know which regions it can use (with possible fallbacks).

I'm sorry, but this is again a little 'desktop-centric point-of-view'. On
desktop it is perfectly acceptable to have a separate memory region for each
device. In embedded world memory is a precious resource. Of course we can go
the 'separate memory region for each device' way, but we observed that at
least some memory can be recovered if we decide to share memory regions for
some of the devices.

Assigning regions to the drivers is a way to describe how memory can be
shared. This is something that is independent from the actual drivers. 
Device drivers cannot and mustn't have such knowledge. 

> And it can know that provided regions are setup by the platform code and
> not created dynamically. This will simplify things enormously.
> 
> > +    1. The core of the CMA does not handle allocation of memory and
> > +       management of free space.  Dedicated allocators are used for
> > +       that purpose.
> > +
> > +       This way, if the provided solution does not match demands
> > +       imposed on a given system, one can develop a new algorithm and
> > +       easily plug it into the CMA framework.
> > +
> > +       The presented solution includes an implementation of a best-fit
> > +       algorithm.
> 
> Again, do we really need user-settable per-region allocators? Just provide
> one with the option to later choose others through the kernel Kconfig files.
