From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Oct 2018 16:03:12 +0100
Subject: [PATCH v9 04/11] dt: psci: Update DT bindings to support
 hierarchical PSCI states
In-Reply-To: <20181003143824.13059-5-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-5-ulf.hansson@linaro.org>
Message-ID: <20181010150312.GA4844@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 04:38:17PM +0200, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Update DT bindings to represent hierarchical CPU and CPU PM domain idle
> states for PSCI. Also update the PSCI examples to clearly show how
> flattened and hierarchical idle states can be represented in DT.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../devicetree/bindings/arm/psci.txt          | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
> index a2c4f1d52492..17aa3d3a1c8e 100644
> --- a/Documentation/devicetree/bindings/arm/psci.txt
> +++ b/Documentation/devicetree/bindings/arm/psci.txt
> @@ -105,7 +105,163 @@ Case 3: PSCI v0.2 and PSCI v0.1.
>  		...
>  	};
>  
> +ARM systems can have multiple cores sometimes in hierarchical arrangement.
> +This often, but not always, maps directly to the processor power topology of
> +the system. Individual nodes in a topology have their own specific power states
> +and can be better represented in DT hierarchically.
> +
> +For these cases, the definitions of the idle states for the CPUs and the CPU
> +topology, must conform to the domain idle state specification [3]. The domain
> +idle states themselves, must be compatible with the defined 'domain-idle-state'
> +binding [1], and also need to specify the arm,psci-suspend-param property for
> +each idle state.
> +
> +DT allows representing CPUs and CPU idle states in two different ways -
> +
> +The flattened model as given in Example 1, lists CPU's idle states followed by
> +the domain idle state that the CPUs may choose. Note that the idle states are
> +all compatible with "arm,idle-state".
> +
> +Example 2 represents the hierarchical model of CPUs and domain idle states.
> +CPUs define their domain provider in their psci DT node. The domain controls
> +the power to the CPU and possibly other h/w blocks that would enter an idle
> +state along with the CPU. The CPU's idle states may therefore be considered as
> +the domain's idle states and have the compatible "arm,idle-state". Such domains
> +may also be embedded within another domain that may represent common h/w blocks
> +between these CPUs. The idle states of the CPU topology shall be represented as
> +the domain's idle states.
> +
> +In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order to use it,
> +the hierarchical representation must be used.
> +
> +Example 1: Flattened representation of CPU and domain idle states

[...]

> +Example 2: Hierarchical representation of CPU and domain idle states

I understand that this may not be of interest for this series, but do
we need to add any suggestions on how to arrive Flattened representation
of CPU idle states from its hierarchical representation. If the DT has
latter and PSCI call returns as PC mode only for idle. We need to deal
with that case.

--
Regards,
Sudeep
