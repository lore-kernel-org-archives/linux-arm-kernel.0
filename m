From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 19 Jul 2016 11:18:04 -0700
Subject: SOC-specific action for irq_set_wake
Message-ID: <20160719181804.GX3847@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

we are working on the PM solution for Zynq MPSOC and ran into some
problem when setting the wake source.

The situation is that when the A53 is in suspend, the GIC(v2) may be
powered down. In that state a companion core is handling wake
events/IRQs, but we expect the OS/Linux to notify the companion core
about what device/IRQ is a wake up source. Hence, my idea was to capture
enabling/disabling wake IRQs in our platform PM code and then
communicate with the FW as needed during suspend operations. The problem
is: I don't see a good way to notify the platform code about these
events.

My ideas were:
1. Use the irq_chip irq_set_wake function
  My thought was to implement the irq_set_wake function in a
  SOC-specific way (could even be generic and call some notifier chain or
  similar) to notify the platform PM code when a device/IRQ is
  enabled/disabled as wake up source.
  My problem is that the SKIP_IRQ_SET_WAKE flag is set in the generic
  driver (drivers/irqchip/irq-gic.c) and platforms cannot implement
  irq_set_wake without changes in the common code.
2. Stuff things into the secure monitor
  I guess we could read the GIC registers once we enter the secure
  monitor and do the communication with the companion core from there by
  identifying unmasked IRQs as wake IRQs. My concern here is that it
  might introduce additional hardcoded mappings that are much more
  dynamic in Linux thanks to the DT description.

Does anybody have similar problems and probably already solved it?
Any other suggestions for approaching the problem? Any preferred
solution?

	Thanks,
	S?ren
