From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 29 Oct 2013 22:09:34 +0400
Subject: [PATCH 3/3] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial
 ports in DT
In-Reply-To: <1383060193-1505-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383060193-1505-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <526FF9DE.9090909@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-10-2013 19:23, Laurent Pinchart wrote:

> SCIF0 and SCIF1 are used as debug serial ports. Enable them and
> configure pinmuxing appropriately. We can now remove the clkdev
> registration hack for SCIF devices from the Lager reference board file.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts            | 24 ++++++++++++++++++++----
>   arch/arm/mach-shmobile/board-lager-reference.c | 18 ++----------------
>   2 files changed, 22 insertions(+), 20 deletions(-)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index a923ab6..9830c87 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -16,8 +16,13 @@
>   	model = "Lager";
>   	compatible = "renesas,lager", "renesas,r8a7790";
>
> +	aliases {
> +		serial0 = &scif0;
> +		serial1 = &scif1;
> +	};
> +
>   	chosen {
> -		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
> +		bootargs = "console=ttySC0,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";

    Hm... is the rename a by-product of the SCIF device tree enablement?

[...]
> diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
> index bc3d0d2..1f5d6e2 100644
> --- a/arch/arm/mach-shmobile/board-lager-reference.c
> +++ b/arch/arm/mach-shmobile/board-lager-reference.c
> @@ -36,24 +36,10 @@ static void __init lager_init_time(void)
>   static void __init lager_add_standard_devices(void)
>   {
>   	/*
> -	 * This is a really crude hack to provide clkdev support to the SCIF
> -	 * and CMT devices until they get moved to DT.
> +	 * This is a really crude hack to provide clkdev support to the CMT
> +	 * CMT device until it gets moved to DT.

    Minor nit: "CMT" repeated twice.

WBR, Sergei
