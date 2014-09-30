From: s-anna@ti.com (Suman Anna)
Date: Tue, 30 Sep 2014 16:55:48 -0500
Subject: [RFC 1/7] soc: qcom: Add device tree binding for SMEM
In-Reply-To: <1412037291-16880-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <542B26E4.2000708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 09/29/2014 07:34 PM, Bjorn Andersson wrote:
> Add device tree binding documentation for the Qualcom Shared Memory
> manager.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
> 
> Exposed by this node is a set of items of different sizes. For many things a
> standard of_xlate method of referencing the individual nodes would be
> preferable, so a #something-cells would make sense. We do however also needs
> access to these items without explicitly stating the references in devicetree
> (e.g. SMD references 257 of these). I haven't found any good example of how to
> implement this, so suggestions are welcome.
> 
> Note that the hwspinlock reference is not yet supported in the mainline, but
> this will likely need a few iterations so I wanted to get this out.
> 
>  .../devicetree/bindings/soc/qcom/qcom,smem.txt     |   34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smem.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smem.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.txt
> new file mode 100644
> index 0000000..ddd58c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.txt
> @@ -0,0 +1,34 @@
> +Qualcomm Shared Memory binding
> +
> +This binding describes the Qualcomm Shared Memory, used to share data between
> +various subsystems and OSes in Qualcomm platforms.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be:
> +		    "qcom,smem"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: base address and size pair for each area representing the
> +		    shared memory. The first pair will must represent the "main"
> +		    area, where the shared memory header and table-of-content
> +		    can be found.
> +
> +- hwspinlocks:

The property name to use should be "hwlocks" and not "hwspinlocks". This
is what the hwspinlock driver core expects from client users.

regards
Suman

> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: reference to a hwspinlock used to protect allocations from
> +		    the shared memory
> +
> += EXAMPLE
> +
> +        smem: smem at fa00000 {
> +                compatible = "qcom,smem";
> +                reg = <0x0fa00000 0x200000>,
> +                      <0xfc428000 0x4000>;
> +
> +                hwspinlocks = <&tcsr_mutex 3>;


> +        };
> 
