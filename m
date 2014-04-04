From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 4 Apr 2014 16:56:27 +0100
Subject: [PATCH RFC v5 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <1395142132-20788-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395142132-20788-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140404155622.GA4061@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[replying to self, since I have a query]

[...]

> +===========================================
> +4 - Examples
> +===========================================
> +
> +Example 1 (ARM 64-bit, 16-cpu system):
> +
> +pd_clusters: power-domain-clusters at 80002000 {
> +       compatible = "arm,power-controller";
> +       reg = <0x0 0x80002000 0x0 0x1000>;
> +       #power-domain-cells = <1>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       pd_cores: power-domain-cores at 80000000 {
> +               compatible = "arm,power-controller";
> +               reg = <0x0 0x80000000 0x0 0x1000>;
> +               #power-domain-cells = <1>;
> +       };
> +};
> +
> +cpus {
> +       #size-cells = <0>;
> +       #address-cells = <2>;
> +
> +       idle-states {
> +               entry-method = "arm,psci-cpu-suspend";
> +
> +               CLUSTER_RETENTION_0: cluster-retention-0 {
> +                       compatible = "arm,idle-state";
> +                       index = <2>;
> +                       logic-state-retained;
> +                       cache-state-retained;
> +                       entry-method-param = <0x1010000>;
> +                       entry-latency-us = <50>;
> +                       exit-latency-us = <100>;
> +                       min-residency-us = <250>;
> +                       power-domains = <&pd_clusters 0>;
> +                       CPU_RETENTION_0_0: cpu-retention-0 {
> +                               compatible = "arm,idle-state";
> +                               index = <0>;
> +                               cache-state-retained;
> +                               entry-method-param = <0x0010000>;
> +                               entry-latency-us = <20>;
> +                               exit-latency-us = <40>;
> +                               min-residency-us = <30>;
> +                               power-domains = <&pd_cores 0>,
> +                                               <&pd_cores 1>,
> +                                               <&pd_cores 2>,
> +                                               <&pd_cores 3>,
> +                                               <&pd_cores 4>,
> +                                               <&pd_cores 5>,
> +                                               <&pd_cores 6>,
> +                                               <&pd_cores 7>;
> +                       };
> +               };
> +
> +               CLUSTER_SLEEP_0: cluster-sleep-0 {
> +                       compatible = "arm,idle-state";
> +                       index = <3>;
> +                       entry-method-param = <0x1010000>;
> +                       entry-latency-us = <600>;
> +                       exit-latency-us = <1100>;
> +                       min-residency-us = <2700>;
> +                       power-domains = <&pd_clusters 0>;
> +                       CPU_SLEEP_0_0: cpu-sleep-0 {
> +                               /* cpu sleep */
> +                               compatible = "arm,idle-state";
> +                               index = <1>;
> +                               entry-method-param = <0x0010000>;
> +                               entry-latency-us = <250>;
> +                               exit-latency-us = <500>;
> +                               min-residency-us = <350>;
> +                               power-domains = <&pd_cores 0>,
> +                                               <&pd_cores 1>,
> +                                               <&pd_cores 2>,
> +                                               <&pd_cores 3>,
> +                                               <&pd_cores 4>,
> +                                               <&pd_cores 5>,
> +                                               <&pd_cores 6>,
> +                                               <&pd_cores 7>;
> +                       };
> +               };

I noticed while developing the CPUidle generic driver, that by using this
representation I might end up requiring duplicated states.

For instance, a cluster-retention state and a cluster-sleep state might
want to have cpu-sleep state as substate, and this would require an
idle state node duplication.

I think it is better to have a single flat (and ordered...that would
kill two birds with one stone) list of nodes in the idle-states node and
every state might have a list of phandles to subnodes (substates), something
like the following example.

This simplifies parsing  and I think it solves the last issue I
came across (the need for duplicate states - in the bindings below,
CPU_SLEEP_0 is a substate of both CLUSTER_RETENTION_0 and
CLUSTER_SLEEP_0, through phandles).

Thoughts very appreciated, thanks.

Lorenzo

idle-states {
       entry-method = "arm,psci-cpu-suspend";

	CPU_RETENTION_0: cpu-retention-0 {
		       compatible = "arm,idle-state";
		       cache-state-retained;
		       entry-method-param = <0x0010000>;
		       entry-latency-us = <20>;
		       exit-latency-us = <40>;
		       min-residency-us = <30>;
		       power-domains = <&pd_cores 0>,
				       <&pd_cores 1>,
				       <&pd_cores 2>,
				       <&pd_cores 3>,
	};

	CPU_SLEEP_0: cpu-sleep-0 {
		       /* cpu sleep */
		       compatible = "arm,idle-state";
		       entry-method-param = <0x0010000>;
		       entry-latency-us = <250>;
		       exit-latency-us = <500>;
		       min-residency-us = <350>;
		       power-domains = <&pd_cores 0>,
				       <&pd_cores 1>,
				       <&pd_cores 2>,
				       <&pd_cores 3>,
	};

	CPU_SLEEP_1: cpu-sleep-1 {
		       /* cpu sleep */
		       compatible = "arm,idle-state";
		       entry-method-param = <0x0010000>;
		       entry-latency-us = <250>;
		       exit-latency-us = <500>;
		       min-residency-us = <350>;
				       <&pd_cores 4>,
				       <&pd_cores 5>,
				       <&pd_cores 6>,
				       <&pd_cores 7>;
	};

	CLUSTER_RETENTION_0: cluster-retention-0 {
	       compatible = "arm,idle-state";
	       logic-state-retained;
	       cache-state-retained;
	       entry-method-param = <0x1010000>;
	       entry-latency-us = <50>;
	       exit-latency-us = <800>;
	       min-residency-us = <2400>;
	       power-domains = <&pd_clusters 0>;
	       substates = <&CPU_SLEEP_0>;
	};

	CLUSTER_SLEEP_0: cluster-sleep-0 {
	       compatible = "arm,idle-state";
	       entry-method-param = <0x1010000>;
	       entry-latency-us = <600>;
	       exit-latency-us = <1100>;
	       min-residency-us = <2700>;
	       power-domains = <&pd_clusters 0>;
	       substates = <&CPU_SLEEP_0>;
	};

	CLUSTER_SLEEP_1: cluster-sleep-1 {
	       compatible = "arm,idle-state";
	       entry-method-param = <0x1010000>;
	       entry-latency-us = <600>;
	       exit-latency-us = <1100>;
	       min-residency-us = <2700>;
	       power-domains = <&pd_clusters 1>;
	       substates = <&CPU_SLEEP_1>;
	};

	SYSTEM_SLEEP_0: system-sleep-0 {
	       compatible = "arm,idle-state";
	       entry-method-param = <0x2010000>;
	       entry-latency-us = <6000>;
	       exit-latency-us = <10000>;
	       min-residency-us = <30000>;
	       power-domains = <&pd_system 0>;
	       substates = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
	};
};
