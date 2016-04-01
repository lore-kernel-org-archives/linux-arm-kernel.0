From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 1 Apr 2016 16:22:59 +0200
Subject: [PATCH] ARM: dts: s3c: Fix DTC unit name warnings in S3C2416 and
 S3C6410
In-Reply-To: <1459494710-16269-1-git-send-email-k.kozlowski@samsung.com>
References: <1459494710-16269-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAGhQ9VwJVz0riwx=DWY=giaL=Jo6R=HYZg4hm2FQ6X2_g5hi5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 April 2016 at 09:11, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> Fix following DTC warnings in S3C2416 and S3C6410 boards:
>
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/s3c2416-smdk2416.dts | 2 +-
>  arch/arm/boot/dts/s3c6410-mini6410.dts | 2 +-
>  arch/arm/boot/dts/s3c6410-smdk6410.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> index f257926c13b7..15f3d1c1bb80 100644
> --- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
> +++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> @@ -15,7 +15,7 @@
>         model = "SMDK2416";
>         compatible = "samsung,s3c2416";
>
> -       memory {
> +       memory at 30000000 {
>                 reg =  <0x30000000 0x4000000>;
>         };

This change will cause duplicated memory node entries in the DT as
noted by Vladimir Zapolskiy [1]. Same goes for all the other patch
where you make this change.

$ scripts/dtc/dtc -I dtb -O dts arch/arm/boot/dts/s3c2416-smdk2416.dtb
| grep -A2 memory
        memory {
                device_type = "memory";
                reg = <0x0 0x0>;
        };
--
        memory at 30000000 {
                reg = <0x30000000 0x4000000>;
        };


regards,
Joachim Eastwood

[1] http://marc.info/?l=linux-arm-kernel&m=145933287125938&w=2
