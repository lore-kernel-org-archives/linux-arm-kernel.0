From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Jun 2016 18:35:17 +0100
Subject: [PATCH 02/14] dt/bindings: update binding for PM domain idle
 states
In-Reply-To: <1466624209-27432-3-git-send-email-lina.iyer@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160623173312.GA22204@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 22, 2016 at 01:36:37PM -0600, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
> 
> Update DT bindings to describe idle states of PM domains.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [Lina: Added state properties, removed state names, wakeup-latency,
> added of_pm_genpd_init() API, pruned commit text]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
> ---
>  .../devicetree/bindings/power/power_domain.txt     | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 025b5e7..41e8dda 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -29,6 +29,43 @@ Optional properties:
>     specified by this binding. More details about power domain specifier are
>     available in the next section.
>  
> +- power-states : A phandle of an idle-state that shall be soaked into a
> +                generic domain power state.

It's somewhat unfortunate that this gives us two possible locations for
idle state lists (under the /cpus node and in a pm-domains node),
especially as it's not clear what would happen were a DT to have both.

I would prefer that we extend the existing bindings such that states can
refer to the power domains which they affect.

> +==Power state==
> +
> +A PM domain power state describes an idle state of a domain and must be
> +have the following properties -
> +
> +	- entry-latency-us
> +		Usage: Not required if wakeup-latency-us is provided.
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing worst case latency in
> +		microseconds required to enter the idle state.
> +		The exit-latency-us duration may be guaranteed
> +		only after entry-latency-us has passed.
> +
> +	- exit-latency-us
> +		Usage: Not required if wakeup-latency-us is provided.
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing worst case latency
> +		in microseconds required to exit the idle state.

These are part of the existing idle state binding
(Documentation/devicetree/bindings/arm/idle-states.txt), and I would
prefer that we did not duplicate this nor come up with an independent
set of idle state bindings.

> +
> +	- residency-us:
> +		Usage: Optional
> +		Value type: <prop-encoded-array>
> +		Definition: A u32 value representing the time for which a
> +		domain must be idle in the state to reap power saving benefits
> +		of entering the state.

This is "min-residency-us" per the existing bindings.

> +
> +	- state-param:
> +		Usage: Optional
> +		Value type: <prop-encoded-array>
> +		Definition: A u32 value as defined by the state. May be used
> +		by the driver to hold state related u32 data. In the case of
> +		PSCI, an extended state-id for the domain may be encoded in
> +		this value.

This is "arm,psci-suspend-param", per the existing bindings.

Thanks,
Mark.
