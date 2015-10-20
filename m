From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Oct 2015 14:37:26 +0200
Subject: [PATCH v3] regulator: Propagate voltage changes to supply regulators
Message-ID: <1445344649-9559-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now changing the voltage of a regulator only ever effected the
regulator itself, but never its supplies. It's a common pattern though
to put LDO regulators behind switching regulators. The switching
regulators efficiently drop the input voltage but have a high ripple on
their output. The output is then cleaned up by the LDOs. For higher
energy efficiency the voltage drop at the LDOs should be minimized. This
series adds support for such a scenario. Another case voltage
propagation is useful is simple switches which are abstracted as
regulators. These can now offer voltage settings to their consumers
which are transparently passed to the switches supply.

Please review, any input welcome.

Changes since v2:
- Skip already applied patches
- create regulator_map_voltage() and use it in favour of
  regulator_get_voltage_floor()

Changes since RFC (v1):
- split into more patches
- Only do voltage propagation when we have a supply and either a minimum
  dropout voltage is specified or the regulator is a switch (lacks a
  get_voltage operation)

Sascha
