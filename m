From: robherring2@gmail.com (Rob Herring)
Date: Mon, 03 Dec 2012 15:54:09 -0600
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
In-Reply-To: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
Message-ID: <50BD1F81.9080304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 11:52 AM, Will Deacon wrote:
> Hello,
> 
> When running Linux on a para-virtualised platform (that is, one where
> the guest is aware that it is dealing with virtual devices sitting on
> things like virtio or xenbus) we require very little in the way of
> platform code and piggy-backing on top of an existing platform can
> require a lot of device emulation for very little gain.
> 
> These two patches introduce mach-virt: a very simple, DT-based machine
> which can be used with kvmtool in conjunction with virtio-based devices.
> It's not hard to imagine the same machine being targetted by Xen, which
> currently emulates a minimal variant of the vexpress platform.
> 
> Note that this patch series depends on the timer rework from Mark
> Rutland, posted on Friday:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/135651.html
> 
> All feedback welcome. We suspect that most controversy will be around
> the name of the thing :)

We've discussed this before at conferences. I don't know that we
concluded this wasn't needed, but it certainly leaned that direction. So
what has changed? You're not going to save code space because we're
building multiple platforms together. You'll save some boot time, but a
stripped down dtb with only the minimal peripherals would probably save
nearly as much time. However, I do have concerns with using VExpress as
the guest. For example, you can't support a non-PAE guest with 4GB of
RAM on VExpress (maybe if the vexpress code gets all memory map info
from DT).

Is this really complete? Will we need reset, poweroff, hotplug, and
suspend/resume support for example? Unlike most initial platform
submissions which are minimal, I think seeing full support would be
useful here. Then we can better gauge how much we are really saving.

Rob

> 
> Will
> 
> 
> Marc Zyngier (2):
>   ARM: Dummy Virtual Machine platform support
>   ARM: SMP support for mach-virt
> 
>  arch/arm/Kconfig             |   2 +
>  arch/arm/Makefile            |   1 +
>  arch/arm/mach-virt/Kconfig   |   9 ++
>  arch/arm/mach-virt/Makefile  |   6 ++
>  arch/arm/mach-virt/headsmp.S |  38 ++++++++
>  arch/arm/mach-virt/platsmp.c | 205 +++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-virt/virt.c    |  71 +++++++++++++++
>  7 files changed, 332 insertions(+)
>  create mode 100644 arch/arm/mach-virt/Kconfig
>  create mode 100644 arch/arm/mach-virt/Makefile
>  create mode 100644 arch/arm/mach-virt/headsmp.S
>  create mode 100644 arch/arm/mach-virt/platsmp.c
>  create mode 100644 arch/arm/mach-virt/virt.c
> 
