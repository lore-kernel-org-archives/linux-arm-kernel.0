From: john.stultz@linaro.org (John Stultz)
Date: Fri, 15 Jan 2016 14:41:55 -0800
Subject: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CALAqxLUxh3=LhoHxqiRm_5L4G6m1Vctp=aUg+9_uAtLkFwW9bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 3:29 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
> add device tree binding document for reboot-mode driver
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>
> ---
>
> Changes in v2: None
> Changes in v1: None
>
>  .../bindings/power/reset/reboot-mode.txt           | 41 +++++++++++++++++
>  .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> new file mode 100644
> index 0000000..81d9f66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> @@ -0,0 +1,41 @@
> +Generic reboot mode core map driver
> +
> +This driver get reboot mode arguments and call the write
> +interface to stores the magic value in special register
> +or ram . Then the bootloader can read it and take different
> +action according to the argument stored.
> +
> +Required properties:
> +- compatible: only support "syscon-reboot-mode" now.
> +
> +Each mode is represented as a sub-node of reboot_mode:
> +
> +Subnode required properties:
> +- linux,mode: reboot mode command,such as "loader", "recovery", "fastboot".
> +- loader,magic: magic number for the mode, this is vendor specific.
> +
> +Example:
> +       reboot_mode {
> +               compatible = "syscon-reboot-mode";
> +               offset = <0x40>;
> +
> +               loader {
> +                       linux,mode = "loader";
> +                       loader,magic = <BOOT_LOADER>;
> +               };
> +
> +               maskrom {
> +                       linux,mode = "maskrom";
> +                       loader,magic = <BOOT_MASKROM>;
> +               };
> +
> +               recovery {
> +                       linux,mode = "recovery";
> +                       loader,magic = <BOOT_RECOVERY>;
> +               };
> +
> +               fastboot {
> +                       linux,mode = "fastboot";
> +                       loader,magic = <BOOT_FASTBOOT>;
> +               };
> +        };


So one minor thought here. While the commands are somewhat vendor
specific, would it be a good idea for the example commands to match
the common commands on Android devices?  For example, usually
"bootloader" is what gets you into fastboot mode on nexus devices.

thanks
-john
