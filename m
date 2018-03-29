From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Thu, 29 Mar 2018 11:25:31 +0300
Subject: [PATCH v3 1/2] Documentation: Documentation for qcom, llcc
In-Reply-To: <1522176722-12691-2-git-send-email-rishabhb@codeaurora.org>
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
 <1522176722-12691-2-git-send-email-rishabhb@codeaurora.org>
Message-ID: <887b47bf-3927-7d07-5000-9d74e83be5fe@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/27/2018 09:52 PM, Rishabh Bhatnagar wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..ceb20a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,70 @@
> +== Introduction==
> +
> +LLCC (Last Level Cache Controller) driver is implemented as a platform device.
> +The driver Programs the SCT (system configuration table). The SCT programming
> +divides the system cache into slices. Each slice is assigned an ID A.K.A
> +SCID(Sub-cache ID).
> +HW modules that are designated to use the system cache are known as clients.
> +Each client must also be represented as a node in the device tree just like
> +any other hw module.
> +One client can have multiple SCID's assigned meaning each client could get
> +multiple slices in the cache. Client can use the slices for various pre-defined
> +usecases. Each client defines a set of names for these usecases in its
> +device tree binding.
> +Client makes a request to LLCC device to get cache-slices properties for each
> +of its usecase. Client gets the information like cache slice ID and size of the
> +cache slice.

All this describes the driver, please just describe what is LLCC and for
what it used for.

> +
> +== llcc device ==

drop this.

> +
> +Properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,sdm855-llcc"
> +
> +- reg:
> +	Usage: required
> +	Value Type: <prop-encoded-array>
> +	Definition: must be addresses and sizes of the LLCC registers
> +
> +- #cache-cells:
> +	Usage: required
> +	Value Type: <u32>
> +	Definition: Number of cache cells, must be 1
> +
> +- max-slices:
> +	usage: required
> +	Value Type: <u32>
> +	Definition: Number of cache slices supported by hardware
> +
> +Example:
> +
> +	llcc: qcom,sdm855-llcc at 01100000 {

this should be qcom,llcc at 1100000

> +		compatible = "qcom,sdm845-llcc";
> +		reg = <0x01100000 0x250000>;
> +		#cache-cells = <1>;
> +		max-slices = <32>;
> +	};
> +
> +== Client ==
> +
> +Required properties:
> +- cache-slice-names:

in my opinion this shouldn't be required but optional.

> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: A set of names that identify the usecase names of a client that
> +			uses cache slice. These strings are used to look up the cache slice
> +		    entries by name.
> +
> +- cache-slices:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: The tuple has phandle to llcc device as the first argument and
> +			the second argument is the usecase id of the client.
> +For Example:
> +
> +	venus {
> +		cache-slice-names = "vidsc0", "vidsc1";
> +		cache-slices = <&llcc 2>, <&llcc 3>;

please make 2,3 and so on #defines.

-- 
regards,
Stan
