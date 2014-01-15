From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jan 2014 15:45:26 +0000
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20140115154526.GC3571@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 15, 2014 at 01:07:07PM +0000, Prashant Gaikwad wrote:
> Now arch timer is registerd using generic sched timer, delay
> timer registration is the only part remaining in arch ports.
> Move this part to drivers clocksource and remove arch timer
> from arch ports.

What's the advantage in doing this? I'd have thought consolidation, but...

> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---
>  arch/arm/include/asm/arch_timer.h    |    1 -
>  arch/arm/kernel/Makefile             |    1 -
>  arch/arm/kernel/arch_timer.c         |   44 ----------------------------------
>  arch/arm64/include/asm/arch_timer.h  |    5 ----
>  arch/arm64/include/asm/delay.h       |   32 ++++++++++++++++++++++++
>  arch/arm64/include/asm/timex.h       |    5 +--
>  arch/arm64/kernel/time.c             |    9 -------
>  arch/arm64/lib/delay.c               |   26 ++++++++++++++++++++
>  drivers/clocksource/arm_arch_timer.c |   12 ++++++++-
>  9 files changed, 71 insertions(+), 64 deletions(-)

... that's a positive diffstat! I also think that delaying the delay loop
initialisation for arm64 could be problematic, since we don't have anything
to fall back on (like the busy-loop on ARM) in case of early *delay calls.

What happens if I call udelay on arm64 before the counter has registered?

Will
