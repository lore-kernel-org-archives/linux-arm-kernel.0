From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Apr 2015 17:51:18 -0700
Subject: Allowing reset controllers before SMP initialization (on ARM)?
Message-ID: <552F0786.2000505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In order to support initialization of the secondary core on BCM63138
SoCs, I would want to utilize a reset controller to release the
secondary CPU from reset [1].

Here are multiple options:

- expose a custom function which registers the reset controller platform
driver as early as possible, which is probably acceptable, but also
requires the DT machine descriptor to populate the platform bus earlier,
which we could completely avoid

- have a OF_DECLARE_RESET_CONTROLLER() which is running fairly early
during boot, such that we can utilize reset controllers are early as
possible,  before any initcall level, and before SMP initialization is
kicking in

- since the code that boots secondary CPUs is relatively unique, even
within the scope of the reset controllers (sequence involves touching
multiple registers), pulling it outside of the reset controller might be
acceptable (there is still some level of sharing though for low-level
indirect read/write operations)

At this point I am leaning towards option 1) since it still allows the
reset controller abstraction to be used, however, option 3) might
wind-up being the cleanest approach to keep the reset controller small.
At any rate, here is the WIP implementation:

[1]:
https://github.com/ffainelli/linux/commit/133214be43b94b90fd580aa9467a5974ffd989ca

Thank you!
-- 
Florian
