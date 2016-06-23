From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:20:50 +0200
Subject: Thermal regulation for Orange Pi PC and Orange Pi One
Message-ID: <20160623192104.18720-1-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements thermal regulation on Orange Pi PC
and Orange Pi One. For that purpose I've taken over the work on THS
of Josef Gajdusek, and cleaned up his patches according to the
previous review on the mailing list.

The patch series also contains:
- Regulator driver for sy8106a I2C connected regulator
- DTS setup for gpio regulator used on Orange Pi One  
- Operating points and thermal zone setup for both SBCs

Fixes/cleanups in the THS driver:
- Return EBUSY until thermal data are available to prevent incorrect
  readings early during boot, which caused critical temperature
  shutdowns.
- Remove unused infrastructure for support of other future SoCs.
  The driver is for sun8i only ATM.
- Make readings quicker (once per 330ms) for faster regulation
  loop.
- Remove some magic numbers from the code, and calculate parameters
  automatically, based on required readout period.  

Enabling frequency scaling lead to kernel crashes/lockups. I revrse
engineered arisc firmware from the BSP kernel to identify how it changes
PLL1 frequency and it uses algorithm that sets clock factors progressively.

This series also includes proposed patch to sunxi clk-factors code,
to allow for more complicated clock factors application algorithms.

regards,
  Ond?ej Jirman
