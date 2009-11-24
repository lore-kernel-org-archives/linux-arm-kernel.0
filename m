From: srplsnh@gmail.com (Surinder P Singh)
Date: Tue, 24 Nov 2009 17:41:25 +0530
Subject: [PATCH] ARM l2x0: check whether l2x0 already enabled
In-Reply-To: <1259014663.2742.3.camel@vinay-desktop>
References: <1259014663.2742.3.camel@vinay-desktop>
Message-ID: <f2235a630911240411x67ad7e05k218b32e8d732dd0c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 3:47 AM, srinidhi kasagar
<srinidhi.kasagar@stericsson.com> wrote:
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Date: Tue, 24 Nov 2009 13:59:20 +0530
>
> If running in non-secure mode, accessing
> control and auxiliary registers of l2x0
> will fault.
>
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
> ?arch/arm/mm/cache-l2x0.c | ? 24 +++++++++++++++---------
> ?1 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index b480f1d..7c0d056 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -99,18 +99,24 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>
> ? ? ? ?l2x0_base = base;
>
> - ? ? ? /* disable L2X0 */
> - ? ? ? writel(0, l2x0_base + L2X0_CTRL);
> + ? ? ? /* check if l2x0 controller is already enabled.
> + ? ? ? ?* if you are booting from non-secure mode
> + ? ? ? ?* accessing the below registers will fault.
> + ? ? ? ?*/
> + ? ? ? if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {

2 points:

1. Since this code is also valid for devices based on pre-ARMv6, maybe
making this code conditional for >=ARMv6 would be cleaner ?

2. Even for trustzone capable devices, would'nt it be better to read
the Secure Configuration Register (SCR) to determine the CPU's current
state (secure/non-secure) and only write to the L2 cache cntrl
registers if you're in non-secure state ?

Cheers,
sp
