From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 5 Feb 2017 09:56:18 +0000
Subject: [PATCH v2 1/5] Documentation: dt: iio: document stm32 adc trigger
 polarity
In-Reply-To: <1485786840-4557-2-git-send-email-fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
 <1485786840-4557-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1b326a3d-522f-b76e-0bc3-656b5fd2a8ae@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/17 14:33, Fabrice Gasnier wrote:
> STM32 ADC trigger polarity can be set to either rising, falling
> or both edges. Allow to configure it from dt.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
This falls into the same question of whether this is really an interrupt
(be it one that linux can't see) or not.

It certainly similar enough I'd like to see us use as much of the
interrupt bindings as possible rather than reinventing the wheel.

cc'd Thomas Gleixner.

Thomas, what we have here effectively an interrupt that we have the option
to directly route to the hardware block to initialize an ADC sample
(rather than bouncing through the kernel).  It can also be directly
exposed as a real interrupt and the chances are we are going to end
up with a mixture of the two depending on who is interesting in the
'interrupt'.

Any thoughts?

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 5dfc88e..6c6d968 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -57,6 +57,8 @@ Optional properties:
>  - dmas: Phandle to dma channel for this ADC instance.
>    See ../../dma/dma.txt for details.
>  - dma-names: Must be "rx" when dmas property is being used.
> +- st,trigger-polarity: Must be 0 (default), 1 or 2 to set default trigger
> +  polarity to respectively "rising-edge", "falling-edge" or "both-edges".
>  
>  Example:
>  	adc: adc at 40012000 {
> @@ -84,6 +86,7 @@ Example:
>  			st,adc-channels = <8>;
>  			dmas = <&dma2 0 0 0x400 0x0>;
>  			dma-names = "rx";
> +			st,trigger-polarity = <1>;
>  		};
>  		...
>  		other adc child nodes follow...
> 
