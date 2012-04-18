From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 18 Apr 2012 18:18:27 +0300
Subject: [PATCH 5/6] ARM: OMAP3: update cpuidle latency and threshold
 figures
In-Reply-To: <1334756720-29166-6-git-send-email-j-pihet@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
 <1334756720-29166-6-git-send-email-j-pihet@ti.com>
Message-ID: <CANOLnOOmshFXKK73qY+rY7yak3hjwR7i=TCShv-GdMEwOvRdLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 4:45 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> Update the data from the measurements performed at HW and SW levels.
>
> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
> for a detailed explanation on where are the numbers coming from.
>
> ...
> ToDo:
> - Measure the wake-up latencies for all power domains for OMAP3
> - Correct some numbers when sys_clkreq and sys_offmode are supported
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
> ?arch/arm/mach-omap2/cpuidle34xx.c | ? 52 +++++++++++++++++++++++-------------
> ?1 files changed, 33 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 2f95cfc..e406d7b 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -39,27 +39,41 @@
<snip>
> ?static struct cpuidle_params cpuidle_params_table[] = {
> - ? ? ? /* C1 */
> - ? ? ? {2 + 2, 5, 1},
> - ? ? ? /* C2 */
> - ? ? ? {10 + 10, 30, 1},
> - ? ? ? /* C3 */
> - ? ? ? {50 + 50, 300, 1},
> - ? ? ? /* C4 */
> - ? ? ? {1500 + 1800, 4000, 1},
> - ? ? ? /* C5 */
> - ? ? ? {2500 + 7500, 12000, 1},
> - ? ? ? /* C6 */
> - ? ? ? {3000 + 8500, 15000, 1},
> - ? ? ? /* C7 */
> - ? ? ? {10000 + 30000, 300000, 1},
> + ? ? ? /* C1 . MPU WFI + Core active */
> + ? ? ? {73 + 78, 152, 1},
> + ? ? ? /* C2 . MPU WFI + Core inactive */
> + ? ? ? {165 + 88, 345, 1},
> + ? ? ? /* C3 . MPU CSWR + Core inactive */
> + ? ? ? {163 + 182, 345, 1},
> + ? ? ? /* C4 . MPU OFF + Core inactive */
> + ? ? ? {2852 + 605, 150000, 1},
> + ? ? ? /* C5 . MPU RET + Core RET */
> + ? ? ? {800 + 366, 2120, 1},
> + ? ? ? /* C6 . MPU OFF + Core RET */
> + ? ? ? {4080 + 801, 215000, 1},
> + ? ? ? /* C7 . MPU OFF + Core OFF */
> + ? ? ? {4300 + 13000, 215000, 1},
> ?};

These (C1 at least) seem to look quite a bit better than what we see here:
http://marc.info/?t=133375282700004&r=1&w=2
according to that wiki log, some of those measurements are from 2010,
I wonder if that still matches today's code well.


-- 
Gra?vydas
