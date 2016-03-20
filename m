From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 19 Mar 2016 20:23:21 -0400
Subject: [PATCH v2 0/5] xen: avoid module usage in non-modular code
In-Reply-To: <1456099568-5154-1-git-send-email-paul.gortmaker@windriver.com>
References: <1456099568-5154-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20160320002321.GX23251@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[PATCH v2 0/5] xen: avoid module usage in non-modular code] On 21/02/2016 (Sun 19:06) Paul Gortmaker wrote:

> This series of commits is a part of a larger project to ensure
> people don't reference modular support functions in non-modular
> code.  Overall there was roughly 5k lines of dead code in the
> kernel due to this.  So far we've fixed several areas, like tty,
> x86, net, ... and we continue to work on other areas.

Just wondering if this is still pending for this merge window; Stefano
had reviewed the two commits he wanted changed vs. v1 and this v2 was
sent approximately a month ago w/o any further change requests.

Thanks,
Paul.
--

> 
> There are several reasons to not use module support for code that
> can never be built as a module, but the big ones are:
> 
>  (1) it is easy to accidentally write unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>       modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else.
>  (4) it gets copied/replicated into other code and spreads like weeds.
> 
> For the xen subsystem, there are just five commits:
> 
> First, we get rid of "include <linux/module.h>" instances that are
> completely unnecessary.
> 
> Then #2 and #3 and #5 are basically trivial remapping to the
> appropriate non-modular counterparts, meaning that there is no
> runtime change here either.
> 
> The fourth hypervisor commit is similar, but also has removal of
> some dead code associated with the module_exit function that will
> never be called.  So the runtime should be the same, but the object
> file will be different (reduced in size).
> 
> Patches created on linux-next and build tested for x86-64 and ARM64
> allmodconfig.
> 
> ---
> 
> [v2: manually inline one-liners in #4; update probe vs init fcn names
>  in #5 ; both suggestions by Stefano ; add Reviewed tags to #1, #2, #3.
>  Redid build testing on x86-64 and ARM64 to test for typos etc.  ]
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: xen-devel at lists.xenproject.org
> 
> Paul Gortmaker (5):
>   xen: audit usages of module.h ; remove unnecessary instances
>   drivers/xen: make [xen-]ballon explicitly non-modular
>   drivers/xen: make xenbus_dev_[front/back]end explicitly non-modular
>   drivers/xen: make sys-hypervisor.c explicitly non-modular
>   drivers/xen: make platform-pci.c explicitly non-modular
> 
>  arch/arm/include/asm/xen/hypercall.h     |  2 ++
>  drivers/xen/balloon.c                    |  4 ----
>  drivers/xen/events/events_2l.c           |  1 -
>  drivers/xen/events/events_base.c         |  2 +-
>  drivers/xen/events/events_fifo.c         |  1 -
>  drivers/xen/features.c                   |  2 +-
>  drivers/xen/grant-table.c                |  1 -
>  drivers/xen/platform-pci.c               | 16 ++++++----------
>  drivers/xen/sys-hypervisor.c             | 31 ++++---------------------------
>  drivers/xen/xen-balloon.c                | 14 +++-----------
>  drivers/xen/xen-pciback/conf_space.c     |  2 +-
>  drivers/xen/xen-pciback/pciback_ops.c    |  2 +-
>  drivers/xen/xen-pciback/xenbus.c         |  2 +-
>  drivers/xen/xen-selfballoon.c            |  1 -
>  drivers/xen/xenbus/xenbus_dev_backend.c  | 13 ++-----------
>  drivers/xen/xenbus/xenbus_dev_frontend.c | 13 ++-----------
>  drivers/xen/xenbus/xenbus_xs.c           |  1 -
>  drivers/xen/xenfs/xensyms.c              |  1 -
>  18 files changed, 24 insertions(+), 85 deletions(-)
> 
> -- 
> 2.6.1
> Paul Gortmaker (5):
>   xen: audit usages of module.h ; remove unnecessary instances
>   drivers/xen: make [xen-]ballon explicitly non-modular
>   drivers/xen: make xenbus_dev_[front/back]end explicitly non-modular
>   drivers/xen: make sys-hypervisor.c explicitly non-modular
>   drivers/xen: make platform-pci.c explicitly non-modular
> 
>  arch/arm/include/asm/xen/hypercall.h     |  2 ++
>  drivers/xen/balloon.c                    |  4 ---
>  drivers/xen/events/events_2l.c           |  1 -
>  drivers/xen/events/events_base.c         |  2 +-
>  drivers/xen/events/events_fifo.c         |  1 -
>  drivers/xen/features.c                   |  2 +-
>  drivers/xen/grant-table.c                |  1 -
>  drivers/xen/platform-pci.c               | 22 +++++-------
>  drivers/xen/sys-hypervisor.c             | 59 +++++---------------------------
>  drivers/xen/xen-balloon.c                | 14 ++------
>  drivers/xen/xen-pciback/conf_space.c     |  2 +-
>  drivers/xen/xen-pciback/pciback_ops.c    |  2 +-
>  drivers/xen/xen-pciback/xenbus.c         |  2 +-
>  drivers/xen/xen-selfballoon.c            |  1 -
>  drivers/xen/xenbus/xenbus_dev_backend.c  | 13 ++-----
>  drivers/xen/xenbus/xenbus_dev_frontend.c | 13 ++-----
>  drivers/xen/xenbus/xenbus_xs.c           |  1 -
>  drivers/xen/xenfs/xensyms.c              |  1 -
>  18 files changed, 31 insertions(+), 112 deletions(-)
> 
> -- 
> 2.6.1
> 
