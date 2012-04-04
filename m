From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 4 Apr 2012 11:42:30 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
References: <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
 <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com>
 <87ehs4pfw4.fsf@ti.com>
 <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
Message-ID: <CACVXFVOxCx-mwLqeM_yDrJDhQrpo6axOWuUvX7eoj87PoMTEsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 7:29 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 3 Apr 2012, Kevin Hilman wrote:
>
>> Indeed, like you, I have to change the EMU clock domain to SWSUP[1] in
>> order to see any interrupts and see anything in perf top. ?This isn't
>> really a mergeable workaround, so I'll look into this a little closer
>> with Santosh to see what we can do once we fully understand the HW
>> problem.
>
> Part of the problem is that the clockdomain data for the emu_sys
> clockdomain is wrong. ?Here's something to try to fix it. ?It might just
> be enough to get it to work.
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Tue, 3 Apr 2012 17:13:48 -0600
> Subject: [PATCH] ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm
> ?CLKTRCTRL data
>
> According to the 4430 ES2.0 TRM vX Table 3-744 "CM_EMU_CLKSTCTRL",
> the emu_sys clockdomain data in mainline is incorrect.
>
> The emu_sys clockdomain does not support the DISABLE_AUTO state, and
> instead it supports the FORCE_WAKEUP state.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> ---
> ?arch/arm/mach-omap2/clockdomains44xx_data.c | ? ?2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
> index 9299ac2..bd7ed13 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
> ? ? ? ?.prcm_partition ? = OMAP4430_PRM_PARTITION,
> ? ? ? ?.cm_inst ? ? ? ? ?= OMAP4430_PRM_EMU_CM_INST,
> ? ? ? ?.clkdm_offs ? ? ? = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
> - ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_HWSUP,
> + ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP,

I tested the patch just now, but unfortunately, the change still doesn't make
PMU to generate IRQs.

Mark the flags as CLKDM_CAN_SWSUP may work, but PMU will stop producing
IRQs after resuming from suspend.


Thanks
--
Ming Lei
