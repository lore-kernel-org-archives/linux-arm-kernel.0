From: zonque@gmail.com (Daniel Mack)
Date: Fri, 20 May 2011 00:25:41 +0200
Subject: PXA3xx NAND controller support broken in 2.6.39
Message-ID: <BANLkTimos3-Ds4Y8FDfDZegqAhH7nSS4PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Somewhere between 2.6.38 and 2.6.39, support for PXA3xx NAND
controller was broken. I bisected it down, and the relevant commits
appear to be

  4332c11 mtd: pxa3xx_nand: clean the keep configure code
  401e67e mtd: pxa3xx_nand: mtd scan id process could be defined by
driver itself
  4eb2da8 mtd: pxa3xx_nand: unify prepare command
  38caf7f mtd: pxa3xx_nand: discard wait_for_event,write_cmd,__readid function
  f8155a4 mtd: pxa3xx_nand: rework irq logic
  e353a20 mtd: pxa3xx_nand: make scan procedure more clear
  52d039f mtd: pxa3xx_nand: NULL dereference in pxa3xx_nand_probe
  9d8b104 mtd: pxa3xx_nand: set oob length in the runtime
  18c81b1 mtd: pxa3xx_nand: remove the flash info in driver structure
  227a886 mtd: pxa3xx_nand: introduce default timing to reduce read id times
  c1f8247 mtd: pxa3xx_nand: condense the flash definition
  99d3896 mtd: pxa3xx: fix build error when CONFIG_MTD_PARTITIONS is not defined

Unfortunately, this series does not consist of atomic commits and is
hence not bisectable by itself, so I can't name a specific commit
which breaks it.

On a raumfeld board (which has its board support code in mainline),
the effect is:

[    1.803796] Wait time out!!!
[    2.003795] Wait time out!!!
[    2.203780] Wait time out!!!
[    2.403779] Wait time out!!!
[    2.406643] No NAND device found.
[    2.409939] pxa3xx-nand pxa3xx-nand: failed to scan nand
[    2.418850] UBI error: ubi_init: UBI error: cannot initialize UBI, error -19


With the code in 2.6.38, it works just fine. Any detailed debug output
you want me to provide in order to fix it?

Daniel
