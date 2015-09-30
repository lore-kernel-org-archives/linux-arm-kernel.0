From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Sep 2015 16:05:40 +0200
Subject: [RFC] regulator: Propagate voltage changes to supply regulators
Message-ID: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now changing the voltage of a regulator only ever effected the
regulator itself, but never its supplies. It's a common pattern though
to put LDO regulators behind switching regulators. The switching
regulators efficiently drop the input voltage but have a high ripple on
their output. The output is then cleaned up by the LDOs. For higher
energy efficiency the voltage drop at the LDOs should be minimized. This
patch adds support for such a scenario.

A new min_dropout_uv field is added to struct regulator_desc. Regulators
can specify the minimun dropout voltage they need for proper function
here. Now when the voltage is changed on a regulator the regulator core
makes sure that
a) before increasing the voltage on the current regulator the supply
   provides at least the desired voltage plus the minimum dropout
b) after decreasing the voltage on the current regulator the supply
   is optimized to the minimum required voltage within the needs of
   the consumers of the supply.

Calculating the optimum voltage for the supply regulator is a bit tricky
since the simple approach of just adding the desired minimum voltage and
the minimum dropout is not enough. It may happen that the current
regulator does not support the desired minimum voltage, but only a
higher one. This means we have to figure out the lowest voltage
supported by the regulator that is higher than the minimum desired
voltage. The regulator_get_voltage_floor introduced with this series
does
exactly that.

This is a first RFC for this series which probably has some rough edges,
but it was already tested successfully on a Phytec PFLA02 i.MX6 board.

Please review, any input welcome.

Sascha
