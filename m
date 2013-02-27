From: Jonas.Oester@de.bosch.com (Oester Jonas (CM-AI/PJ-CF31))
Date: Wed, 27 Feb 2013 18:10:16 +0100
Subject: perf top running with 4 v7 cores (i.MX6q)?
In-Reply-To: <512E1F18.3040807@de.bosch.com>
References: <512E1F18.3040807@de.bosch.com>
Message-ID: <294B28951EBE8146839AF99A61CB5FCE6DC3FC42D1@SI-MBX17.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> has anybody running 'perf top' on a quad ARM v7 system with PMU enabled?
> 
> Running 'perf top' on a quad Cortex A9 based Freescale i.MX6 SabreLite
> (maxcpus=4) with PMU enabled [1] and kernel 3.8 the system freezes
> completely and after some time the system detects a RCU stall [2].
> 
> 'perf top' works well using only 1 core (maxcpus=1) on the same system.
> 
> Any idea?

One important difference between the i.MX6 and other processors may be that the 
i.MX6 has one interrupt line for the PMUs of all the cores (the i.MX6 manual is terse here: 
"Logical OR of Performance Unit interrupts" is all it has to say on the subject). Compare 
this to e.g. a Tegra 30:

	pmu {
		compatible = "arm,cortex-a9-pmu";
		interrupts = <0 144 0x04
			      0 145 0x04
			      0 146 0x04
			      0 147 0x04>;
	};

So, does the PMU driver support this IRQ wiring at all? Are there any other SoCs that have 
*one* IRQ line for several PMUs? At least, I didn't find any by grepping for cortex-a9-pmu 
in arch/arm/boot/dts.

Jonas
