From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 Jan 2012 09:38:54 -0600
Subject: [RFC PATCH 0/5] ARM: introducing DT topology
In-Reply-To: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4F16E78E.2060801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2012 08:36 AM, Lorenzo Pieralisi wrote:
> The introduction of multi-cluster ARM systems in SoC designs requires the kernel
> to become cluster aware, so that it can be booted on every CPU in the system
> and it can build an appropriate representation of topology levels.
> 
> Current code in the kernel, in particular the boot sequence, hinges upon a
> sequential mapping of MPIDR values for cpus and related interrupt
> controller CPU interfaces to logical cpu indexing. 
> This hypothesis is not valid when the concept of cluster is introduced since
> the MPIDR cannot be represented as a single index and interrupt controller
> CPU interfaces might be wired with a numbering scheme following per-SoC
> design parameters which cannot be extrapolated easily through generic functions
> by the primary CPU.
> 
> Furthermore, relying on the MPIDR to be wired according to real topology levels
> might turn out to be an unreliable solution, hence a SW representation is
> needed to override possibly incorrect MPIDR register values.
> 

"might be" is used several times. Is this a real problem? Wouldn't a
more simple solution be providing properties to override the MPIDR
register value if it is unreliable?

> Through the device tree and relative bindings, the kernel is provided
> with HW values for MPIDR registers, interrupt controller CPU interfaces and
> with a topology representation of hierarchy levels and connection between cores.
> 
> The device tree bindings allow to boot the Linux kernel on a multi-cluster
> system without relying on platform specific hook to identify the number of CPUs
> and interrupt controller wiring definition.
> 
> The patchset has been tested against:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-arm-arch.git master
> 
> to boot an 8-core dual-cluster system on every possible CPU and to describe
> the relative cpu topology according to the affinity levels.
> 
> Compile tested against linux-next, with a dependency on the following patch:
> 
> http://www.spinics.net/lists/arm-kernel/msg155873.html
> 
> Documentation of new device tree bindings is provided in the corresponding
> patches and provided for discussion.
> 
> Lorenzo Pieralisi (5):
>   ARM: kernel: add device tree init map function
>   ARM: kernel: add cpu logical map DT init in setup_arch
>   ARM: kernel: add logical mappings look-up
>   ARM: gic: add cpuif topology description
>   ARM: kernel: build CPU topology from DT
> 
>  Documentation/devicetree/bindings/arm/cpus.txt     |   42 +++++
>  Documentation/devicetree/bindings/arm/gic.txt      |   69 ++++++++
>  Documentation/devicetree/bindings/arm/topology.txt |  167 ++++++++++++++++++++
>  arch/arm/common/gic.c                              |   94 +++++++++++-
>  arch/arm/include/asm/prom.h                        |    2 +
>  arch/arm/include/asm/smp_plat.h                    |   12 ++
>  arch/arm/kernel/devtree.c                          |   40 +++++
>  arch/arm/kernel/setup.c                            |    1 +
>  arch/arm/kernel/topology.c                         |  110 +++++++++++---
>  9 files changed, 513 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/topology.txt
> 
