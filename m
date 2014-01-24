From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 24 Jan 2014 16:31:27 +0100
Subject: [PATCH] sunxi: dts: add a note that memory size is adjusted by
 boot loader.
In-Reply-To: <1390572852-15027-1-git-send-email-ijc@hellion.org.uk>
References: <1390572852-15027-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <52E2874F.10703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/24/2014 03:14 PM, Ian Campbell wrote:
> I had to spend a couple of minutes proving to myself that this was the case on
> cubietruck, so add a comment to save the next guy some effort.

Seems like a good idea to me, one small nitpick though see comments inline.

> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-sunxi at googlegroups.com
> ---
> This patch applies cleanly against v3.13 and Hans' sunxi-devel branch.
>
> A plausible alternative would be to pull the memory node out of the dtsi files
> and into the board specific files. I didn't go straight to that since I'd have
> to research all the various boards ;-)

That won't help, some boards ie the original cubieboard and the mele-a1000 come
in both 512 MB and 1024 MB versions, and I don't think we want to start maintaining
2 different dts files just for that.

>
> I considered maing it "reg = <0 0>" but decided that having some sort of least
> common denominator would let things work even if the bootloader were broken.
> ---
>   arch/arm/boot/dts/sun4i-a10.dtsi  |    1 +
>   arch/arm/boot/dts/sun5i-a10s.dtsi |    1 +
>   arch/arm/boot/dts/sun5i-a13.dtsi  |    1 +
>   arch/arm/boot/dts/sun6i-a31.dtsi  |    1 +
>   arch/arm/boot/dts/sun7i-a20.dtsi  |    1 +
>   5 files changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 3e60883..9ba0beb 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -30,6 +30,7 @@
>   	};
>
>   	memory {
> +		/* 1GB by default, will be updated by U-Boot */
>   		reg = <0x40000000 0x80000000>;
>   	};
>

The comment says 1GB, but the range says 2GB, note 2GB is consistent with what the
datasheet claims as max RAM.

> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> index 0376c50..d12ed7e 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -27,6 +27,7 @@
>   	};
>
>   	memory {
> +		/* 512MB by default, will be updated by U-Boot */
>   		reg = <0x40000000 0x20000000>;
>   	};
>

This seems wrong (copy paste from A13 error) I've a10s boards with 1G, and the data
sheet claims 2GB max RAM.

> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index b81aeb9..6f8bfd9 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -27,6 +27,7 @@
>   	};
>
>   	memory {
> +		/* 512MB by default, will be updated by U-Boot */
>   		reg = <0x40000000 0x20000000>;
>   	};
>
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 3f6f07b..bcbef9a 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -46,6 +46,7 @@
>   	};
>
>   	memory {
> +		/* 2GB by default, will be updated by U-Boot */
>   		reg = <0x40000000 0x80000000>;
>   	};
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 907cfcc..658e74b 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -38,6 +38,7 @@
>   	};
>
>   	memory {
> +		/* 1GB by default, will be updated by U-Boot */
>   		reg = <0x40000000 0x80000000>;
>   	};

The comment says 1GB, but the range says 2GB, note 2GB is consistent with what the
datasheet claims as max RAM.

Regards,

Hans
