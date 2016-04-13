From: stano@meduna.org (Stanislav Meduna)
Date: Thu, 14 Apr 2016 00:18:52 +0200
Subject: i.MX53 + MC34708 working setup?
Message-ID: <570EC5CC.2020606@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

before I start digging deeper: anyone got the MC34708 PMIC
touchscreen driver working on an i.MX53 board (I am
using a custom board with a TQMa53 module)?

First: the mc13783-ts input driver does not support the
device tree so after changing to module_platform_driver_probe
somewhere in 3.10 it is not going to get started. For now
I reverted this driver to a 3.9 version to get back
the module_init/exit.

This resulted in this driver starting and trying to do
mc13xxx_adc_do_conversion every time the touchscreen is
touched, so here the interrupts are processed as expected.
mc13xxx_adc_do_conversion however times out in
wait_for_completion_interruptible_timeout.

Trying to bluntly revert this code to 3.9 as well did not work,
so I am not sure whether the code is the problem or the
device tree which was changed for imx53-tqma53.dtsi as well
(for example the 3.9 lists
  interrupts = <6 8>; /* PDATA_DATA6, low active */
whereas the 4.4 has <6 4> high active).

I am using a 4.4 kernel with some ported TQ patches, none
of them touching the PMIC.

If anyone has this setup (i.MX53 + MC34708, recent kernel)
working, I would appreciate a pointer to the code.

Thanks
-- 
                                 Stano
