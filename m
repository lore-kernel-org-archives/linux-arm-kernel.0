From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 13 Aug 2014 13:25:36 -0600
Subject: [PATCH v7 2/8] Documentation: arm: define DT idle states bindings
In-Reply-To: <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140813192533.GA32624@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Wed, Aug 13, 2014 at 04:52:01PM +0100, Lorenzo Pieralisi wrote:
>+===========================================
>+4 - Examples
>+===========================================
>+
>+Example 1 (ARM 64-bit, 16-cpu system, PSCI enable-method):
>+
>+cpus {
>+	#size-cells = <0>;
>+	#address-cells = <2>;
>+
>+	CPU0: cpu at 0 {
>+		device_type = "cpu";
>+		compatible = "arm,cortex-a57";
>+		reg = <0x0 0x0>;
>+		enable-method = "psci";
>+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
>+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
>+	};
Sorry for jumping in late. I havent gone through all the patches yet or
followed on previous discussions, if somebody could answer this or point
me to the discussion, it would be great.
Why is the cpu defining the possible cluster idle states? Would it be
better that cluster states form a separate node, something like this -

	CLUSTER0: cluster at 0 {
		...
		cpus = <&CPU0 &CPU1 &CPU2 &CPU3>;
		cluster-idle-states = <&CLUTER_RETENTION_0, &CLUSTER_SLEEP_0>;
		};
	};	
		
Allowing for something like this to be defined - 

	super_cluster0: cluster at 101 {
		...
		clusters = <&CLUSTER0  &CLUSTER1>;
		cluster-idle-states = <&SOC_RETENTION, &SOC_SLEEP>;
		};
	};

And each cluster-idle-state follows the general idle definition as
provided in this document, and an indicator what the compising
components should idle at, for this idle state to be available.

	CLUSTER_SLEEP_0: cluster-sleep at 0 {
		...
		/* sleep definition for cluster0's retention */
		min-idle-state = <CPU_SLEEP_0>;
	};

	SOC_SLEEP: cluster-sleep at 101 {
		...
		min-idle-state = <&CLUSTER_SLEEP_0>;
	};
		

Opens up the idle state for a lot of heirarchical possibilities, which
if you think, is generally how the SoC is. 


Thanks,
Lina
