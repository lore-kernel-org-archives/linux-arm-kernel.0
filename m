From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 1 Aug 2016 15:00:32 -0600
Subject: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
In-Reply-To: <20160801163003.GA17592@rob-hp-laptop>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
 <20160801163003.GA17592@rob-hp-laptop>
Message-ID: <20160801210032.GI1369@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01 2016 at 10:30 -0600, Rob Herring wrote:
>On Fri, Jul 29, 2016 at 03:56:13PM -0600, Lina Iyer wrote:
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> Update DT bindings to describe idle states of PM domains.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> [Lina: Added state properties, removed state names, wakeup-latency,
>> added of_pm_genpd_init() API, pruned commit text]
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
>> ---
>>  .../devicetree/bindings/power/power_domain.txt     | 39 ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>> index 025b5e7..69aa4e2 100644
>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -29,6 +29,10 @@ Optional properties:
>>     specified by this binding. More details about power domain specifier are
>>     available in the next section.
>>
>> +- domain-idle-states : A phandle of an idle-state that shall be soaked into a
>> +                generic domain power state. The idle state definitions are
>> +                compatible with arm,idle-state specified in [1].
>> +
>>  Example:
>>
>>  	power: power-controller at 12340000 {
>> @@ -55,6 +59,39 @@ Example 2:
>>  		#power-domain-cells = <1>;
>>  	};
>>
>> +Example 3:
>> +
>> +	pm-domains {
>> +		a57_pd: a57_pd@ {
>
>The trailing '@' is not valid. If dtc doesn't complain about that, it
>should.
>
Will remove it.

>> +			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
>> +			compatible = "arm,pd","arm,cortex-a57";
>> +			#power-domain-cells = <0>;
>> +			idle-states = <&CLUSTER_SLEEP_0>;
>
>Is this supposed to be 'domain-idle-states'? The domain part is
>pointless IMO given these are power domain nodes.
>
It should domain-idle-states property. Well, the CPU's idle states are
called cpu-idle-states in the CPU node, so I named this
domain-idle-states to be in line.


>> +		};
>> +
>> +		a53_pd: a53_pd@ {
>> +			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
>> +			compatible = "arm,pd","arm,cortex-a53";
>> +			#power-domain-cells = <0>;
>> +			idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
>> +		};
>> +
>> +		CLUSTER_SLEEP_0: idle-state at 0 {
>
>A unit-address should have a matching reg value or be dropped. A reg
>property would be fine here, but I think it should correspond to MPIDR
>values.
>
Will drop it in my next submission.

Thanks Rob.

-- Lina

>> +			compatible = "arm,idle-state";
>> +			entry-latency-us = <1000>;
>> +			exit-latency-us = <2000>;
>> +			residency-us = <10000>;
>> +		};
>> +
>> +		CLUSTER_SLEEP_1: idle-state at 1 {
>> +			compatible = "arm,idle-state";
>> +			entry-latency-us = <5000>;
>> +			exit-latency-us = <5000>;
>> +			residency-us = <100000>;
>> +		};
>> +	};
>> +
>> +
>>  The nodes above define two power controllers: 'parent' and 'child'.
>>  Domains created by the 'child' power controller are subdomains of '0' power
>>  domain provided by the 'parent' power controller.
>> @@ -76,3 +113,5 @@ Example:
>>  The node above defines a typical PM domain consumer device, which is located
>>  inside a PM domain with index 0 of a power controller represented by a node
>>  with the label "power".
>> +
>> +[1]. Documentation/devicetree/bindings/arm/idle-states.txt
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
