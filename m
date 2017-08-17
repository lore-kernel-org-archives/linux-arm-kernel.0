From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 Aug 2017 18:26:32 -0700
Subject: [GIT PULL 2/2] bcm2835-soc-next-2017-08-15
In-Reply-To: <20170815180325.12809-2-eric@anholt.net>
References: <20170815180325.12809-1-eric@anholt.net>
 <20170815180325.12809-2-eric@anholt.net>
Message-ID: <36766926-c8d6-b768-59b6-4ff302a6a5ba@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/15/2017 11:03 AM, Eric Anholt wrote:
> The following changes since commit f29c256853b7412961d3ee80ca525bd2530573db:
> 
>   ARM: dts: bcm283x: Add 32-bit enable method for SMP (2017-08-14 20:09:44 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-soc-next-2017-08-15
> 
> for you to fetch changes up to 067b437e55a892e3ebb13e40c98825fcfa1e2d99:
> 
>   ARM: bcm2836: Send event when onlining other cores (2017-08-15 10:52:26 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in two things.
> 
> One is to use sev() to wake up CPUs that might be sleeping when doing
> the custom spin-table boot process in 32-bit mode (new firmware
> versions will have the CPUs sleeping waiting for an event instead of
> just spinning).  However, the irqchip maintainer objected to our SMP
> code continuing to live in the driver, so we had to move it to
> platsmp.c, and to do that we needed a new SMP enable-method to the DT
> for the platsmp.c to attach to (thus the DT cross-merge in this PR).
> The platsmp.c patch was acked by irqchip for going through arm-soc.

This does make us pull quite a lot of changes, how about I just
cherry-pick "ARM: dts: bcm283x: Add 32-bit enable method for SMP" such
that the branch in itself is functional as-is, but we don't pull in
everything else from devicetree/next?

> 
> The other piece is a garbage-collection of the platform's stub clock
> driver for early Raspberry Pi support, before the native clock driver
> was added.  This was acked by the clk subsystem for going through our
> tree as well.
> 
> ----------------------------------------------------------------
> Danilo Krummrich (1):
>       clk: bcm2835: remove remains from stub clk driver
> 
> Eric Anholt (1):
>       Merge tag 'bcm2835-dt-next-2017-08-15' into HEAD
> 
> Phil Elwell (1):
>       ARM: bcm2836: Send event when onlining other cores
> 
> Stefan Wahren (1):
>       irqchip: bcm2836: Move SMP startup code to arch/arm
> 
>  arch/arm/mach-bcm/Makefile          |  5 +++
>  arch/arm/mach-bcm/board_bcm2835.c   |  7 ----
>  arch/arm/mach-bcm/platsmp.c         | 38 ++++++++++++++++++
>  drivers/clk/bcm/clk-bcm2835-aux.c   |  1 -
>  drivers/clk/bcm/clk-bcm2835.c       | 30 --------------
>  drivers/irqchip/irq-bcm2836.c       | 79 +------------------------------------
>  include/linux/clk/bcm2835.h         | 24 -----------
>  include/linux/irqchip/irq-bcm2836.h | 70 ++++++++++++++++++++++++++++++++
>  8 files changed, 115 insertions(+), 139 deletions(-)
>  delete mode 100644 include/linux/clk/bcm2835.h
>  create mode 100644 include/linux/irqchip/irq-bcm2836.h
> 

-- 
Florian
