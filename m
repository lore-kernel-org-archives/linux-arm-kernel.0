From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 26 Apr 2011 18:39:01 +0200
Subject: External serial 8250/16550
In-Reply-To: <4DB44883.3000608@nlink.com.br>
References: <4DB44883.3000608@nlink.com.br>
Message-ID: <BANLkTinMrZvO_bNcAKXvaa_pXE+jOxO2uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Paulo,

> I was called for help to add a external serial using a board based on
> at91sam9g45,

> ? ? ? ?at91_sys_write(AT91_SMC_CSR(1),
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?AT91_SMC_ACSS_STD
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| AT91_SMC_DBW_8
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| AT91_SMC_BAT
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| AT91_SMC_WSEN
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| AT91_SMC_NWS_(32) ? ? /* wait states */
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| AT91_SMC_RWSETUP_(6) ?/* setup time */
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| AT91_SMC_RWHOLD_(4) ? /* hold time */
>
> ? ? ? ?);

Those AT91_SMC  registers and bits only exist on the AT91RM9200,
whereas you're using a SAM9-based processor.

You should be configuring the memory controller by:
  #include <mach/at91sam9_smc.h>
  #include "sam9_smc.h"

and declaring a "struct sam9_smc_config" with all the setting &
timings, and then calling:
   sam9_smc_configure(CHIP_SELECT_NUMBER, &your_smc_config_struct);


> But doesn't work, how to map correctly external serial port?

If you specify UPF_IOREMAP in the "struct plat_serial8250_port" flags,
the serial-driver will automatically map the IO region for you.


> Is there any sample code for external uart using linux-2.6.36 and arm
> AT91SAM9?

Not for a SAM9-based board.  But for an AT91RM9200 example, look at
board-tms.c in the AT91 patches on http://maxim.org.za/at91_26.html .
SAM9 should be the same, except for the SMC memory-controller
configuration (as described above).


Regards,
  Andrew Victor
