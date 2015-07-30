From: stefan@agner.ch (Stefan Agner)
Date: Thu, 30 Jul 2015 14:14:50 +0200
Subject: [PATCH] irqchip: gic: Add a cpu map for each GIC instance
In-Reply-To: <55B9F0A5.8030309@arm.com>
References: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
 <20150729183321.GP7557@n2100.arm.linux.org.uk> <55B92939.5040101@nvidia.com>
 <55B9DE44.1010102@arm.com> <55B9E145.9050202@nvidia.com>
 <55B9E89E.5050905@arm.com> <55B9EEA7.4090903@nvidia.com>
 <55B9F0A5.8030309@arm.com>
Message-ID: <e9c6df1524d9e11b090222c1443dba1a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-07-30 11:38, Marc Zyngier wrote:
> On 30/07/15 10:30, Jon Hunter wrote:
>> Yes the "other CPU" may not run Linux, but it is certainly under the
>> control of Linux as a slave CPU. Linux will decide whether it wants to
>> receive the interrupts from this GIC or route them to the other CPU.
>>
>> Yes, I see that this may not be technically a cpu map and may be that is
>> a mis-use. Following that I assume that using set_affinity here would
>> also not be correct and a custom API should be employed?
> 
> Indeed. set_affinity is only concerned with delivering interrupts to the
> CPUs, and not to other entities. It looks like we need an different API,
> but I would refrain from declaring it "custom". There is at least one
> other example of a platform doing similar things (vybrid), and I'd like
> to see some collaboration on that (Stefan on CC).

The Vybrid SoC allows to assign CPU "complex" affinity through something
called interrupt router (which is part of a miscellaneous module, hence
the driver is called vf610-mscm-ir). Typically on the secondary core
(Cortex-M4) a RTOS has been used. So far each CPU complex configured the
affinity of the interrupts to the own CPU on interrupt enable (e.g.
under Linux handled the vf610-mscm-ir driver). In this mode, the whole
router is somewhat pointless since you could also only mask/unmask your
local interrupt controller. Either way, this can lead to conflicts,
hence it is up to the developer to configure the operating systems
peripheral access (and hence interrupts) orthogonal.

The question in those heterogeneous architectures is who should be
responsible for resource control? The vf610-mscm-ir driver only cares
about the local CPU, so no "resource control" for the other CPU complex.

I guess from a security standpoint one should be the master and restrict
access of the other CPU complex as much as possible. On Vybrid, there
are only limited options in that regard, and access to the interrupt
router could not be disabled without disabling other peripherals too.

Newer heterogeneous Freescale SoCs (e.g. i.MX 7) don't have this
interrupt router at all. However, there is now a Resource Domain
Controller which allow to restrict access of memory regions
(peripherals..). However, afaik there is no control over interrupts
there, so only the local interrupt controller which allow to
enable/disable the shared peripheral interrupts.

--
Stefan
