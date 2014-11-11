From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Nov 2014 11:59:59 +0000
Subject: [RFC 2/2] regulator: qcom-rpm: Implement RPM assisted disable
In-Reply-To: <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20141111115959.GY24004@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Nov 2014, Bjorn Andersson wrote:

> Some regulators are used to power e.g. PLLs that clocks the core we're
> running on, so we can't turn them off directly; but we do want them off
> when the core is powered down. To handle this the Qualcomm SoC provides
> a means to specify a "sleep state" for RPM resources that can be
> triggered by the hardware when the cores are brought down.
> 
> Resources of this type should be considered always-on while the CPU(s)
> are running and we can utilize the "sleep state" functionality to defer
> disabling them until the CPU(s) go to sleep, if not used by other
> peripherals at that time.
> 
> Other properties are kept in sync between the states, so that if the
> CPU(s) go to sleep with a particular regulator still enabled there will
> be no change.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt |   28 ++++++++

Please place this into a seperate patch.

See: Documentation/devicetree/bindings/submitting-patches.txt

>  drivers/regulator/qcom_rpm-regulator.c             |   68 +++++++++++++++-----
>  2 files changed, 79 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> index 4264021..4671eef 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> @@ -112,6 +112,13 @@ of valid subnodes that can operate on these resources.
>  	Definition: select that the power supply should operate in hysteretic
>  		    mode, instead of the default pwm mode
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM
> +		    after going to sleep
> +

This requires a DT Ack.

>  Standard regulator bindings are used inside switch mode power supply subnodes.
>  Check Documentation/devicetree/bindings/regulator/regulator.txt for more
>  details.
> @@ -160,6 +167,13 @@ details.
>  						qcom,rpm-pm8921-nldo,
>  						qcom,rpm-pm8921-nldo1200
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM
> +		    after going to sleep
> +

Eh?  I think I'm seeing double.

>  Standard regulator bindings are used inside switch low-dropout regulator
>  subnodes.  Check Documentation/devicetree/bindings/regulator/regulator.txt for
>  more details.
> @@ -190,6 +204,13 @@ more details.
>  		    2740000, 2400000, 2130000, 1920000, 1750000, 1600000,
>  		    1480000, 1370000, 1280000, 1200000
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM
> +		    after going to sleep
> +

Triple?

>  Standard regulator bindings are used inside negative charge pump regulator
>  subnodes.  Check Documentation/devicetree/bindings/regulator/regulator.txt for
>  more details.
> @@ -215,6 +236,13 @@ more details.
>  		    QCOM_RPM_PM8921_LVS1 - QCOM_RPM_PM8921_LVS7,
>  		    QCOM_RPM_PM8921_MVS
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM
> +		    after going to sleep
> +

There must be a better way to document this.

>  = EXAMPLE
>  
>  	#include <dt-bindings/mfd/qcom-rpm.h>

[...]
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
