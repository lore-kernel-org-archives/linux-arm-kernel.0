From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 17 Oct 2013 10:57:48 +0100
Subject: [PATCH 2/2] ARM: vexpress: Enable platform-specific options in
 defconfig
In-Reply-To: <1381930594-1701-3-git-send-email-pawel.moll@arm.com>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
 <1381930594-1701-3-git-send-email-pawel.moll@arm.com>
Message-ID: <525FB49C.7040607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On 16/10/13 14:36, Pawel Moll wrote:
> This patch enables all drivers and alike to make defconfig-ed
> kernels use Versatile Express specific features, like power
> management services (PSCI, MCPM and cpuidle with drivers for
> DCCSB on Fast Models and SPC on TC2), CMA for frame buffer
> allocation, all virtio device drivers (for QEMU, KVM tools
> and Fast Models), MTD physmap drivers with squashfs and UBIFS
> for flash, I2C master, regulator and hwmon drivers and
> LEDs support with most useful triggers. The maximum
> amount of CPUs has been increased to 8 to facilitate
> big.Little systems.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/configs/vexpress_defconfig | 65 ++++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> index 6d20bc1..f2535e3 100644
> --- a/arch/arm/configs/vexpress_defconfig
> +++ b/arch/arm/configs/vexpress_defconfig
[snip]
> @@ -44,39 +49,46 @@ CONFIG_IP_PNP_BOOTP=y
>  # CONFIG_INET_LRO is not set
>  # CONFIG_IPV6 is not set
>  # CONFIG_WIRELESS is not set
> +CONFIG_NET_9P=y
> +CONFIG_NET_9P_VIRTIO=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_MTD=y
> -CONFIG_MTD_CONCAT=y
> -CONFIG_MTD_PARTITIONS=y
>  CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_AMDSTD=y
> -CONFIG_MTD_ARM_INTEGRATOR=y
> -CONFIG_MISC_DEVICES=y
> +CONFIG_MTD_RAM=y


> +CONFIG_MTD_PHYSMAP=y
> +CONFIG_MTD_PHYSMAP_OF=y

This could cause issues with CPUIdle on TC2. Since TC2 reset vector is in NOR
flash, NOR flash has to be in Read mode when CPU resets and enter reset vector.
But what I have seen is that NOR flash is left in Read Identifier Mode after the
driver is initialised. So we need to make sure NOR device is in Read mode
whenever CPU enters deeper C-states and also may have to register notifiers
which seems overkill IMO. Most of the platform have separate(or secure) flash
for this reason.
Is it possible to disable flash on TC2 only in it's DT something like
         flash at 0,00000000 {
                status = "disabled";
         };	

Regards,
Sudeep
