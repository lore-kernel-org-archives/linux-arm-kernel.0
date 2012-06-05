From: collinsd@codeaurora.org (David Collins)
Date: Tue, 05 Jun 2012 09:16:22 -0700
Subject: Supporting non-device tree consumers with device tree regulator
 drivers
Message-ID: <4FCE30D6.7060102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I was wondering if a mechanism currently exists which allows regulator
devices which have probed via device tree to support regulator consumer
drivers which have probed via a board file (and thus have no associated
device tree device_node).  It seems that the current setup is such that if
a regulator driver probes via a board file device, then it will be passed
a struct regulator_init_data pointer containing a consumer_supplies list
via platform_data.  This allows the regulator driver to support consumers
that are probed via device tree nodes or via a board file.  However, if a
regulator driver probes via a device tree node, then it will only be
accessible to consumer drivers which have nodes in device tree and which
specify their own foo-supply=<&regulator_phandle>; mappings.  When a
regulator device is probed via device tree, the consumer_supplies pointer
is left null by of_get_regulator_init_data().  This seems to make
regulators probed via device tree nodes inaccessible to non-device tree
consumers.

In the long term, this problem should go away of its own accord.  However,
in the short term, many systems are converting over to using device tree.
 Therefore, we are left with a situation currently where some regulator
consumer drivers are being probed via device tree and some are being
probed via board file devices within a single platform.  If the regulator
driver supporting the consumer drivers is converted to use device tree and
probed via device tree, then the non-device tree consumer drivers will not
be able to make use of the regulator devices.

Would it be possible to add a new binding that is handled inside of
of_get_regulator_init_data() or of_get_regulation_constraints() that
provides a means to directly specify regulator_init_data.consumer_supplies
entries?  Is there some other mechanism that could be used instead to
handle the mapping?

One potentially binding could be:
regulator-consumer-supplies = "supply_name1", "device_name1",
"supply_name2", "device_name2", ...

Thank you,
David Collins

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
