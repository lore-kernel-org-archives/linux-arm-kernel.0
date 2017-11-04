From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat, 4 Nov 2017 17:33:54 +0530
Subject: [PATCH 1/2] arm64: dts: orange-pi-zero-plus2: fix sdcard detect
In-Reply-To: <20171103195855.15283-2-geomatsi@gmail.com>
References: <20171103195855.15283-1-geomatsi@gmail.com>
 <20171103195855.15283-2-geomatsi@gmail.com>
Message-ID: <CAMty3ZCs8kq1vUGLOi0ZghY7n0iXgUQ1E=ngBO6Y4wm7wMLF7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 4, 2017 at 1:28 AM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
> The sdcard detect pin on orange-pi-zero-plus2 is pulled up.
> Fix cd-gpio description to enable sdcard detect.
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> index b6b7a561df8c..a42fd79a62a3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> @@ -71,7 +71,7 @@
>         pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>         vmmc-supply = <&reg_vcc3v3>;
>         bus-width = <4>;
> -       cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;

Was able to detect and do mount with existing dts

Log:
# cat /proc/version
Linux version 4.13.7 (root at ubuntu) (gcc version 6.4.0 (Buildroot
2017.11-git-00724-g83af6b3)) #1 SMP PREEMPT Thu Oct 19 00:51:53 CEST
2017
# fdisk -l /dev/mmcblk0
Disk /dev/mmcblk0: 59 GB, 63483936768 bytes, 123992064 sectors
1937376 cylinders, 4 heads, 16 sectors/track
Units: cylinders of 64 * 512 = 32768 bytes

Device       Boot StartCHS    EndCHS        StartLBA     EndLBA
Sectors  Size Id Type
/dev/mmcblk0p1 *  0,15,59     8,56,27           1003     132074
131072 64.0M  c Win95 FAT32 (LBA)
Partition 1 does not end on cylinder boundary
/dev/mmcblk0p2    8,56,28     15,221,57       132075     254954
122880 60.0M 83 Linux
Partition 2 does not end on cylinder boundary
# mount /dev/mmcblk0p1 /mnt/
# ls /mnt/
Image                              sun50i-h5-orangepi-zero-plus2.dtb
boot.scr
# umount  /mnt/
# mount /dev/mmcblk0p2 /mnt/
# ls /mnt/
bin         lib         lost+found  opt         run         tmp
dev         lib64       media       proc        sbin        usr
etc         linuxrc     mnt         root        sys         var
# umount  /mnt/

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
