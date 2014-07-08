From: drake@endlessm.com (Daniel Drake)
Date: Tue, 8 Jul 2014 09:32:02 +0100
Subject: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
In-Reply-To: <53AC0BCC.1010608@samsung.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
 <20140626113939.GP32514@n2100.arm.linux.org.uk>
 <53AC0BCC.1010608@samsung.com>
Message-ID: <CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

How can we move forward here?

On Thu, Jun 26, 2014 at 1:02 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> - basically Samsung UART already has its own namespace (ttySAC) and the
> order inside it is well-defined - instance ID shall be the hardware
> instance number as specified by documentation. The ports vary in certain
> aspects and the ID is important knowledge of the driver. The problem
> here was broken implementation of assigning IDs based on probe order,
> which worked only because on all Exynos platforms all ports have been
> always registered (which we want to change now and keep unused ones
> "disabled" in DT),

Yes, the kernel help text documents this quite well:

config SERIAL_SAMSUNG
    tristate "Samsung SoC serial support"
    depends on PLAT_SAMSUNG
    select SERIAL_CORE
    help
      Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
      providing /dev/ttySAC0, 1 and 2 (note, some machines may not
      provide all of these ports, depending on how the serial port
      pins are configured.

> - we already have a lot of userspace depending on the aforementioned
> ttySAC namespace and proper ordering of instances there. While I believe
> the proper solution as of today would be to go back to standard ttyS
> namespace and make userspace use a smarter way of identifying the
> instances (e.g. by path or id, as you suggested), I don't think this
> will make anyone's life easier with current assumptions,

I like the sound of going to the standard ttyS notation and only
providing ports for ones that exist, but is this userspace-visible
naming change OK? You could argue that userspace that relies on fixed
device paths is a bit broken, but that argument would be a bit cloudy
given the kernel documentation for the ttySAC devices above.

> - correct me if I'm wrong, but I don't think the
> /dev/serial/by-{path,id} would be handled in kernel's console= parameter.

That's right, that problem is left to the user, but at least we'd be
consistent with other SoCs (and open to generic solutions to that
inconvenience).

Daniel
