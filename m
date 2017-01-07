From: john.stultz@linaro.org (John Stultz)
Date: Fri, 6 Jan 2017 20:06:53 -0800
Subject: [PATCH v2] ARM: dts: qcom: apq8064: Add missing scm clock
In-Reply-To: <20161229120611.7948-1-bjorn.andersson@linaro.org>
References: <20161229120611.7948-1-bjorn.andersson@linaro.org>
Message-ID: <CALAqxLVp8kocYrwW0wNgeRmLy016wf_c_SesDzaq_fCgj0G-Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 4:06 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> As per the device tree binding the apq8064 scm node requires the core
> clock to be specified, so add this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Changed clock to Daytona Fabric
>
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 1dbe697b2e90..a27cc96ac069 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/clock/qcom,gcc-msm8960.h>
>  #include <dt-bindings/reset/qcom,gcc-msm8960.h>
>  #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
>  #include <dt-bindings/soc/qcom,gsbi.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -303,6 +304,9 @@
>         firmware {
>                 scm {
>                         compatible = "qcom,scm-apq8064";
> +
> +                       clocks = <&rpmcc RPM_DAYTONA_FABRIC_CLK>;
> +                       clock-names = "core";
>                 };
>         };

So using this on my nexus7, I see:

[   14.240169] ------------[ cut here ]------------
[   14.240230] WARNING: CPU: 0 PID: 0 at
drivers/usb/chipidea/udc.c:954 isr_setup_status_phase+0x98/0x9c
[   14.243872] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.10.0-rc2-00024-g4f53a60 #1774
[   14.252975] Hardware name: Generic DT based system
[   14.260810] [<c03113f0>] (unwind_backtrace) from [<c030d678>]
(show_stack+0x20/0x24)
[   14.265493] [<c030d678>] (show_stack) from [<c05cad80>]
(dump_stack+0x80/0x94)
[   14.273385] [<c05cad80>] (dump_stack) from [<c03207dc>] (__warn+0xf0/0x10c)
[   14.280416] [<c03207dc>] (__warn) from [<c03208c8>]
(warn_slowpath_null+0x30/0x38)
[   14.287269] [<c03208c8>] (warn_slowpath_null) from [<c07ce6b4>]
(isr_setup_status_phase+0x98/0x9c)
[   14.294913] [<c07ce6b4>] (isr_setup_status_phase) from [<c07cf11c>]
(udc_irq+0x9f0/0xd0c)
[   14.303856] [<c07cf11c>] (udc_irq) from [<c07ca294>] (ci_irq+0x64/0x118)
[   14.312103] [<c07ca294>] (ci_irq) from [<c03785c0>]
(__handle_irq_event_percpu+0x84/0x2b4)
[   14.318871] [<c03785c0>] (__handle_irq_event_percpu) from
[<c037881c>] (handle_irq_event_percpu+0x2c/0x68)
[   14.326945] [<c037881c>] (handle_irq_event_percpu) from
[<c03788a0>] (handle_irq_event+0x48/0x6c)
[   14.336581] [<c03788a0>] (handle_irq_event) from [<c037c620>]
(handle_fasteoi_irq+0xe0/0x1b0)
[   14.345522] [<c037c620>] (handle_fasteoi_irq) from [<c0377bb8>]
(generic_handle_irq+0x30/0x44)
[   14.354026] [<c0377bb8>] (generic_handle_irq) from [<c0377c58>]
(__handle_domain_irq+0x8c/0xfc)
[   14.362535] [<c0377c58>] (__handle_domain_irq) from [<c03014dc>]
(gic_handle_irq+0x58/0x9c)
[   14.371125] [<c03014dc>] (gic_handle_irq) from [<c030e28c>]
(__irq_svc+0x6c/0xa8)
[   14.379450] Exception stack(0xc1001ee8 to 0xc1001f30)
[   14.387102] 1ee0:                   00000001 00000000 00000000
c031b240 c1000000 c10050c0
[   14.392145] 1f00: c100506c c0f92ea8 c1001f58 00000000 00000000
c1001f44 c1001f48 c1001f38
[   14.400295] 1f20: c03097d4 c03097d8 60000113 ffffffff
[   14.408457] [<c030e28c>] (__irq_svc) from [<c03097d8>]
(arch_cpu_idle+0x48/0x4c)
[   14.413497] [<c03097d8>] (arch_cpu_idle) from [<c0b2debc>]
(default_idle_call+0x30/0x3c)
[   14.420959] [<c0b2debc>] (default_idle_call) from [<c036b390>]
(do_idle+0x17c/0x210)
[   14.429027] [<c036b390>] (do_idle) from [<c036b710>]
(cpu_startup_entry+0x28/0x2c)
[   14.436756] [<c036b710>] (cpu_startup_entry) from [<c0b2647c>]
(rest_init+0x94/0x98)
[   14.444130] [<c0b2647c>] (rest_init) from [<c0f00e08>]
(start_kernel+0x390/0x39c)
[   14.452022] ---[ end trace cc56495fca556bcb ]---


And then usb doesn't seem to work...

thanks
-john
