From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 13 Aug 2014 23:11:01 +0100
Subject: [PATCH v7 2/8] Documentation: arm: define DT idle states bindings
In-Reply-To: <20140813192533.GA32624@ilina-mac.local>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140813192533.GA32624@ilina-mac.local>
Message-ID: <20140813221101.GA32697@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 08:25:36PM +0100, Lina Iyer wrote:
> Hi Lorenzo,
> 
> On Wed, Aug 13, 2014 at 04:52:01PM +0100, Lorenzo Pieralisi wrote:
> >+===========================================
> >+4 - Examples
> >+===========================================
> >+
> >+Example 1 (ARM 64-bit, 16-cpu system, PSCI enable-method):
> >+
> >+cpus {
> >+	#size-cells = <0>;
> >+	#address-cells = <2>;
> >+
> >+	CPU0: cpu at 0 {
> >+		device_type = "cpu";
> >+		compatible = "arm,cortex-a57";
> >+		reg = <0x0 0x0>;
> >+		enable-method = "psci";
> >+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
> >+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
> >+	};
> Sorry for jumping in late. I havent gone through all the patches yet or
> followed on previous discussions, if somebody could answer this or point
> me to the discussion, it would be great.
> Why is the cpu defining the possible cluster idle states? Would it be
> better that cluster states form a separate node, something like this -
> 
> 	CLUSTER0: cluster at 0 {
> 		...
> 		cpus = <&CPU0 &CPU1 &CPU2 &CPU3>;
> 		cluster-idle-states = <&CLUTER_RETENTION_0, &CLUSTER_SLEEP_0>;
> 		};
> 	};	
> 		
> Allowing for something like this to be defined - 
> 
> 	super_cluster0: cluster at 101 {
> 		...
> 		clusters = <&CLUSTER0  &CLUSTER1>;
> 		cluster-idle-states = <&SOC_RETENTION, &SOC_SLEEP>;
> 		};
> 	};
> 
> And each cluster-idle-state follows the general idle definition as
> provided in this document, and an indicator what the compising
> components should idle at, for this idle state to be available.
> 
> 	CLUSTER_SLEEP_0: cluster-sleep at 0 {
> 		...
> 		/* sleep definition for cluster0's retention */
> 		min-idle-state = <CPU_SLEEP_0>;
> 	};
> 
> 	SOC_SLEEP: cluster-sleep at 101 {
> 		...
> 		min-idle-state = <&CLUSTER_SLEEP_0>;
> 	};
> 		
> 
> Opens up the idle state for a lot of heirarchical possibilities, which
> if you think, is generally how the SoC is. 

We have been thinking for 7 patch versions + some more for this specific
document, which is ready to go after extensive debate.

It is probably better to have a look at archives first since honestly it
is impossible to summarize 6 months worth of discussions in few lines.

I think the hierarchy you mention should be implemented using power
domains, which is how the SoC implements power management and that's
what defines idle states hierarchy.

To be 100% precise, I would like to detect what cpus are affected by an
idle state entry by defining for each idle state what power domain
(which can be hierarchical) is affected, not by grouping them under
a tag "cluster" "supercluster" or whatchamacallit.

I removed power domains to simplify the current proposal which is sufficient
as a starting point, but they are next on my TODO list and were part of the
initial bindings, consider yourself welcome to help us define the way forward
keeping this document as a starting point.

Lorenzo
