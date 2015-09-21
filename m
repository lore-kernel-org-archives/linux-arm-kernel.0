From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Sep 2015 17:49:14 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56001B78.2090001@free.fr>
References: <56001B78.2090001@free.fr>
Message-ID: <2206647.QPrIpE2UC0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 September 2015 17:00:08 Mason wrote:
> Hello everyone,
> 
> I've been working on an arch/arm port for some time. I've removed
> a lot of non-essential code, and currently, what I have is:
> 
> $ git diff --stat v4.2 my4.2
>  Makefile                                               |    4 +-
>  arch/arm/Kconfig                                       |   26 ++
>  arch/arm/Makefile                                      |    1 +
>  arch/arm/boot/dts/Makefile                             |    1 +
>  arch/arm/boot/dts/tango.dts                            |   96 ++++++++
>  arch/arm/kernel/smp_twd.c                              |    3 +-
>  arch/arm/mach-tangox/Kconfig                           |   57 +++++
>  arch/arm/mach-tangox/Makefile                          |   10 +
>  arch/arm/mach-tangox/Makefile.boot                     |    3 +
>  arch/arm/mach-tangox/clock-tangox.c                    |  134 ++++++++++
>  arch/arm/mach-tangox/io.c                              |   18 ++
>  arch/arm/mach-tangox/setup.c                           |   22 ++
>  arch/arm/tools/mach-types                              |    1 +
>  drivers/irqchip/Makefile                               |    1 +
>  drivers/irqchip/irq-tangox.c                           |  234 ++++++++++++++++++
>  drivers/net/ethernet/Kconfig                           |    1 +
>  drivers/net/ethernet/Makefile                          |    1 +
>  drivers/net/ethernet/sigmadesigns/Kconfig              |    7 +
>  drivers/net/ethernet/sigmadesigns/Makefile             |    5 +
>  drivers/net/ethernet/sigmadesigns/tangox/Kconfig       |   21 ++
>  drivers/net/ethernet/sigmadesigns/tangox/Makefile      |    5 +
>  drivers/net/ethernet/sigmadesigns/tangox/tangox_enet.c | 1158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sigmadesigns/tangox/tangox_enet.h |  257 +++++++++++++++++++
>  drivers/tty/serial/8250/8250_core.c                    |    8 +-
>  drivers/tty/serial/of_serial.c                         |    2 +-
>  25 files changed, 2066 insertions(+), 10 deletions(-)
> 
> (The two drivers (irqchip and ethernet) are from Mans Rullgard's tree.)
> 
> TODO
> Convert the clock registration code to device tree
> Add PHY ISR to ethernet driver
> 
> 
> Could you provide some pointers/links and guidance detailing the
> steps required to submit a new port under arch/arm?
> (With the current requirements: DT, ARCH_MULTIPLATFORM, etc)

A few things to be aware of:

- As you are probably aware, please split the series into multiple patches,
  doing one thing at a time. A lot of the patches don't have dependencies
  on one another and can just get merged as soon as they are ready

- submit the ethernet driver to the netdev at vger.kernel.org mailing list.
  It should not be controversial at all, but you should probably move it
  on directory up and remove the tangox subdir when there is only one source
  file in it. The driver will need a binding documentation in
  Documentation/devicetree/bindings/net/

- similarly, the irqchip driver should be sent to the respective maintainers
  and be accompanied by a DT binding doc.

- the 8250 changes go through Greg and linux-serial

- no mach-types changes please

- Makefile.boot should not be needed

- the clock support should probably go to drivers/clk, unless this is
  a clocksource driver, which should go to drivers/clocksource. Add a
  DT binding spec. If you lack DT support, don't bother sending it,
  but send the rest anyway.

- merge io.c and setup.c into one file

- whatever you need in smp_twd.c will have to get merged by Russell,
  the other patches go through the arm-soc tree.

	Arnd
