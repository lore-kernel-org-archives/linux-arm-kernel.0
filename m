From: rk@ti.com (Ravikumar)
Date: Wed, 3 May 2017 19:27:40 +0530
Subject: [PATCH 1/1] ARM: dts: dra7: Reduce cpu thermal shutdown
 temperature
In-Reply-To: <20170412062442.17736-1-rk@ti.com>
References: <20170412062442.17736-1-rk@ti.com>
Message-ID: <e96e275d-1ba0-c904-e469-d86c6e687912@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 12 April 2017 11:54 AM, Kattekola, Ravikumar wrote:
> On dra7, as per TRM, the HW shutdown (TSHUT) temperature is hardcoded
> to 123C and cannot be modified by SW. This means when the temperature
> reaches 123C HW asserts TSHUT output which signals a warm reset.
> This reset is held until the temperature goes below the TSHUT low (105C).
>
> While in SW, the thermal driver continuously monitors current temperature
> and takes decisions based on whether it reached an alert or a critical point.
> The intention of setting a SW critical point is to prevent force reset by HW
> and instead do an orderly_poweroff(). But if the SW critical temperature is
> greater than or equal to that of HW then it defeats the purpose. To address
> this and let SW take action before HW does keep the SW critical temperature
> less than HW TSHUT value.
>
> The value for SW critical temperature was chosen as 120C just to ensure
> we give SW sometime before HW catches up.
>
> Document reference
> SPRUI30C ? DRA75x, DRA74x Technical Reference Manual - November 2016
> SPRUHZ6H - AM572x Technical Reference Manual - November 2016
>
> Tested on:
> DRA75x PG 2.0 Rev H EVM
>
> Signed-off-by: Ravikumar Kattekola <rk@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 57892f2..e714466 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -2017,4 +2017,8 @@
>   	coefficients = <0 2000>;
>   };
>   
> +&cpu_crit {
> +	temperature = <120000>; /* milli Celsius */
> +};
> +
>   /include/ "dra7xx-clocks.dtsi"
Ping..
Any comments?

Regards,
RK
