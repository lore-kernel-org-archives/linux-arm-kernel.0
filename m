From: dann.frazier@canonical.com (Dann Frazier)
Date: Mon, 8 Jun 2015 21:44:21 -0600
Subject: [PATCH 2/2 RESEND] power: reset: Add syscon poweroff device node
 for APM X-Gene platform
In-Reply-To: <1433272747-27114-3-git-send-email-ttnguyen@apm.com>
References: <1433272747-27114-1-git-send-email-ttnguyen@apm.com>
 <1433272747-27114-3-git-send-email-ttnguyen@apm.com>
Message-ID: <CALdTtnvQg2xmL5MqxUcvJmk_33XiEg9tnLzYvC++ZQL3j7J46g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 1:19 PM, Tai Nguyen <ttnguyen@apm.com> wrote:
> This patch adds syscon poweroff device node to support poweroff feature
> on APM X-Gene Mustang platform

hey Tai,
 The reboot changes work just fine for me, but poweroff does not:

[  OK  ] Reached target Final Step.
         Starting Power-Off...
reboot: Power down
Unable to poweroff system
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000

CPU: 0 PID: 1 Comm: systemd-shutdow Tainted: G        W       4.1.0-rc7+ #1
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008990c>] dump_backtrace+0x0/0x11c
[<ffffffc000089a38>] show_stack+0x10/0x1c
[<ffffffc0005b447c>] dump_stack+0x88/0xc8
[<ffffffc0005b3374>] panic+0xe0/0x220
[<ffffffc0000b5f24>] do_exit+0x990/0x994
[<ffffffc0000d06bc>] SyS_reboot+0x14c/0x208
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000

  -dann

> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
> ---
>  arch/arm64/boot/dts/apm/apm-mustang.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
> index 83578e7..910d561 100644
> --- a/arch/arm64/boot/dts/apm/apm-mustang.dts
> +++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
> @@ -23,6 +23,18 @@
>                 device_type = "memory";
>                 reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
>         };
> +
> +       poweroff_mbox: poweroff_mbox at 10548000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x10548000 0x0 0x30>;
> +       };
> +
> +       poweroff: poweroff at 10548010 {
> +               compatible = "syscon-poweroff";
> +               regmap = <&poweroff_mbox>;
> +               offset = <0x10>;
> +               mask = <0x1>;
> +       };
>  };
>
>  &pcie0clk {
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
