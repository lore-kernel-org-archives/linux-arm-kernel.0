From: john.stultz@linaro.org (John Stultz)
Date: Tue, 2 Feb 2016 10:29:32 -0800
Subject: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CALAqxLXBMOicSm41jnD2pqmYEGCA9cy9RfrdXFPNM1m_iH53WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 1:59 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
> add device tree bindings document for reboot-mode driver
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>
> ---
>
> Changes in v3:
> - descirbe all reboot mode as properity instead of subnode
>
> Changes in v2: None
> Changes in v1: None
>
>  .../bindings/power/reset/reboot-mode.txt           | 26 ++++++++++++++++
>  .../bindings/power/reset/syscon-reboot-mode.txt    | 36 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> new file mode 100644
> index 0000000..517080f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> @@ -0,0 +1,26 @@
> +Generic reboot mode core map driver
> +
> +This driver get reboot mode arguments and call the write
> +interface to stores the magic value in special register
> +or ram . Then the bootloader can read it and take different
> +action according the argument stored.
> +
> +All mode properties are vendor specific, it is a indication to tell
> +the bootloder what to do when the system reboot, and should be named
> +as mode-xxx = <magic> (xxx is mode name).
> +
> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
> +- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
> +- mode-fastboot: Android fastboot mode, it's a mode to  re-flash partitions on the device.

One minor tweak here, on most Android devices (atleast most Nexus
devices) getting to fastboot is done via "reboot bootloader" not
"reboot fastboot".

If we are going to document the commands here to establish a standard,
I'd prefer we use use what existing userspace expects:

So across nexus devices, there's really two consistent commands:
"bootloader", and "recovery"

Nexus 6p:  https://android.googlesource.com/kernel/msm.git/+/android-msm-bullhead-3.10-marshmallow-mr1/drivers/power/reset/msm-poweroff.c#230
Nexus 9: https://android.googlesource.com/kernel/tegra.git/+/android-tegra-flounder-3.10-marshmallow-mr1/drivers/htc_debug/stability/reboot_params.c#86
Nexus 7: https://android.googlesource.com/kernel/msm.git/+/android-msm-flo-3.4-marshmallow-mr1/arch/arm/mach-msm/restart.c#273
Nexus 10: https://android.googlesource.com/kernel/exynos.git/+/android-exynos-manta-3.4-lollipop-mr1/arch/arm/mach-exynos/board-manta-power.c#422

While I don't object to having a duplicative mode-fastboot (it is more
clear as to what the command does), or the other oem specific modes, I
think we should make it clear that the Android userspace expects the
"bootloader" and "recovery" commands and document them here.

thanks
-john
