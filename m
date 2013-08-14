From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Wed, 14 Aug 2013 15:38:00 +0200
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-13 at 15:20 -0700, Russ Dill wrote:
> The purpose and method of executing these sequences is left up to each
> platform. In the case of the am33xx, the CM3 firmware writes out the
> simple I2C sequences.
> 
> Each sequence is a series of I2C write commands. The first byte is the
> length of the write, the second byte the I2C device to address, and
> the following bytes are the message.

>         /* Set OPP100 (1.10V) for VDD core */
>         wake_sequence = /bits/ 8 <
>                 0x02 0x2d 0x25 0x2b /* Set VDD2 to 1.1V */
>         >;
> 
>         tps: tps at 2d {
>                 reg = <0x2d>;
>         };

> In the above example, the sequence "0x25 0x1f" is written to the I2C
> device at address 0x2d (the TPS65910 PMIC). The PMIC interprets that
> as a write to a register at address 0x25.

> I'd really like to get some feedback on the devicetree bindings. 

Shouldn't the TPS driver know how to generate this sequence? It seems
fragile to do voltage adjustments behind the back of the regulator
framework and the TPS driver. The wake-sequence values should match the
(in-memory) regulator configuration on resume (which may have been
changed by DVFS).

The CM3 driver needs to figure out where the core regulator is connected
using using either DT or the regulator framework and ask the TPS (via a
new interface) for register writes for sleep/wake sequences. Then those
sequences will actually match the correct voltages configured using
DT/DVFS.

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
