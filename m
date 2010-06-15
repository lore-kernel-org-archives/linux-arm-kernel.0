From: clagix@gmail.com (Guido Classen)
Date: Tue, 15 Jun 2010 20:26:24 +0200
Subject: [PATCH] at91rm9200 static memory controller initialization
Message-ID: <AANLkTinIPD1tceqoONbpfDmvnJI7Q1F765kQQvMaqgPO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello mailing list,

This patch adds AT91RM9200 static memory controller initialization based
on a structure 'at91rm9200_smc_config'. It is simlar to a patch provided
by Andrew Victor for the AT91SAM9 family (sam9_smc.[ch]).

The code can be used like this:

        /*
         * Setup static memory controller chip select for external quad UART
         *
         */
        static const struct __initdata at91rm9200_smc_config
                quad_uart_cs_config = {
                .wait_states          = 16,
                .data_float_time      = 0,
                .byte_access_type     = AT91RM9200_BAT_8_BIT,
                .data_bus_width       = AT91RM9200_DATA_BUS_WIDTH_8,
                .data_read_protocol   = AT91RM9200_DRP_STANDARD,
                .address_to_cs_setup  = AT91RM9200_ACSS_STANDARD,
                .rw_setup             = 2,
                .rw_hold              = 2
        };

        if (at91rm9200_smc_configure(CCM2200_QUAD_UART_CS,
                                     &quad_uart_cs_config ) != 0 ) {
                printk( KERN_ERR
                        "Unable to configure static memory controller\n" );
                return -EIO;
	}


I am new at ARM linux and not familiar with the naming conventions.
Please review the patch and give comments.

Best regards

  Guido Classen

Signed-off-by: Guido Classen <clagix@gmail.com>

diff -Nrub '--exclude=*~'
linux-2.6.35-ccm2200/arch/arm/mach-at91/at91rm9200_smc.c
linux-2.6.35-rm9200_smc//arch/arm/mach-at91/at91rm9200_smc.c
--- linux-2.6.35-ccm2200/arch/arm/mach-at91/at91rm9200_smc.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.35-rm9200_smc//arch/arm/mach-at91/at91rm9200_smc.c	2010-06-14
19:58:48.000000000 +0200
@@ -0,0 +1,88 @@
+/*
+ * linux/arch/arm/mach-at91/at91rm9200_smc.c
+ *
+ * Copyright (C) 2010 Guido Classen
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307	 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include <mach/at91rm9200_mc.h>
+#include <mach/at91_pio.h>
+
+#include "at91rm9200_smc.h"
+
+int __init at91rm9200_smc_configure(int chip_select,
+				    struct at91rm9200_smc_config *config)
+{
+	unsigned int mask;
+
+	/* check parameters */
+	if (chip_select < 0 || chip_select > 7
+	    || config->wait_states > 128
+	    || config->data_float_time > 15
+	    || (config->byte_access_type != AT91RM9200_BAT_TWO_8_BIT
+		&& config->byte_access_type != AT91RM9200_BAT_16_BIT)
+	    || (config->data_read_protocol != AT91RM9200_DRP_STANDARD
+		&& config->data_read_protocol != AT91RM9200_DRP_EARLY)
+	    || config->address_to_cs_setup < AT91RM9200_ACSS_STANDARD
+	    || config->address_to_cs_setup > AT91RM9200_ACSS_3_CYCLES
+	    || config->rw_setup > 7
+	    || config->rw_hold > 7)
+		return -EINVAL;
+
+
+	// configure gpios, if necessary
+	if (chip_select > 3)
+	{
+#define AT91C_PC10_NCS4_CFCS  (1<<10)
+#define AT91C_PC11_NCS5_CFCE1 (1<<11)
+#define AT91C_PC12_NCS6_CFCE2 (1<<12)
+#define AT91C_PC13_NCS7	      (1<<13)
+		switch (chip_select)
+		{
+		case 4:	mask = AT91C_PC10_NCS4_CFCS;	break;
+		case 5:	mask = AT91C_PC11_NCS5_CFCE1;	break;
+		case 6:	mask = AT91C_PC12_NCS6_CFCE2;	break;
+		case 7:	mask = AT91C_PC13_NCS7;		break;
+		default: mask = 0;
+		}
+		/* select peripheral a function */
+		at91_sys_write(AT91_PIOC + PIO_ASR, mask);
+
+		/* disable pio controller and enable peripheral */
+		at91_sys_write(AT91_PIOC + PIO_PDR, mask);
+	}
+
+	/* write the new configuration to SMC chip select register */
+	at91_sys_write(AT91_SMC_CSR(chip_select),
+		       (config->wait_states > 0
+			? (AT91_SMC_NWS & (config->wait_states-1))
+			| AT91_SMC_WSEN
+			: 0)
+		       | AT91_SMC_TDF_(config->data_float_time)
+		       | (config->byte_access_type == AT91RM9200_BAT_16_BIT
+			  ? AT91_SMC_BAT : 0)
+		       | ((int)config->data_bus_width << 13)
+		       | (config->data_read_protocol == AT91RM9200_DRP_EARLY
+			  ? AT91_SMC_DPR : 0)
+		       | ((int)config->address_to_cs_setup << 16)
+		       | AT91_SMC_RWSETUP_(config->rw_setup)
+		       | AT91_SMC_RWHOLD_(config->rw_hold) );
+	return 0;
+}
diff -Nrub '--exclude=*~'
linux-2.6.35-ccm2200/arch/arm/mach-at91/at91rm9200_smc.h
linux-2.6.35-rm9200_smc//arch/arm/mach-at91/at91rm9200_smc.h
--- linux-2.6.35-ccm2200/arch/arm/mach-at91/at91rm9200_smc.h	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.35-rm9200_smc//arch/arm/mach-at91/at91rm9200_smc.h	2010-06-14
19:51:15.000000000 +0200
@@ -0,0 +1,66 @@
+/*
+ * linux/arch/arm/mach-at91/at91rm9200_smc.h
+ *
+ * Copyright (C) 2010 Guido Classen
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307	 USA
+ *
+ */
+
+struct at91rm9200_smc_config {
+	/* wait states 0...128 (0 = no wait states) */
+	u8 wait_states;
+	/* 0...15 wait states after memory read cycle */
+	u8 data_float_time;
+
+	/* only valid for data_bus_width=AT91RM9200_DATA_BUS_WIDTH_16 */
+	enum byte_access_type {
+		/* dummy value for 8 bit device (ignored) */
+		AT91RM9200_BAT_8_BIT = 0,
+		/* chip select is connected to two/four 8-bit
+		 * devices */
+		AT91RM9200_BAT_TWO_8_BIT = 0,
+		/* chip select is connected too a 16 bit device */
+		AT91RM9200_BAT_16_BIT = 1
+	} byte_access_type;
+
+	enum data_bus_width {
+		AT91RM9200_DATA_BUS_WIDTH_8 = 2,  /* 8 bit data bus */
+		AT91RM9200_DATA_BUS_WIDTH_16 = 1, /* 16 bit data bus */
+	} data_bus_width;
+	enum data_read_protocol {
+		AT91RM9200_DRP_STANDARD = 0, /* standard data read protocol */
+		AT91RM9200_DRP_EARLY	= 1  /* early data read protocol */
+	} data_read_protocol;
+
+	enum address_to_cs_setup {
+		/* standard: address asserted at the beginning of the
+		 * access and deasserted at the end */
+		AT91RM9200_ACSS_STANDARD   = 0,
+		/* one cycle less at the beginning and end */
+		AT91RM9200_ACSS_1_CYCLE	   = 1,
+		/* two cycles less at the beginning and end */
+		AT91RM9200_ACSS_2_CYCLES   = 2,
+		/* three cycles less at the beginning and end */
+		AT91RM9200_ACSS_3_CYCLES   = 3
+	} address_to_cs_setup;
+	/* 0...7 number of read/write setup cycles */
+	u8 rw_setup;
+	/* 0...7 number of read/write hold cycles */
+	u8 rw_hold;
+};
+
+extern int __init at91rm9200_smc_configure(int chip_select,
+					   struct at91rm9200_smc_config *config);
diff -Nrub '--exclude=*~'
linux-2.6.35-ccm2200/arch/arm/mach-at91/Makefile
linux-2.6.35-rm9200_smc//arch/arm/mach-at91/Makefile
--- linux-2.6.35-ccm2200/arch/arm/mach-at91/Makefile	2010-06-14
16:31:35.000000000 +0200
+++ linux-2.6.35-rm9200_smc//arch/arm/mach-at91/Makefile	2010-06-14
19:45:24.000000000 +0200
@@ -10,7 +10,7 @@
 obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o

 # CPU-specific support
-obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o
at91rm9200_devices.o
+obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o
at91rm9200_devices.o at91rm9200_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam926x_time.o
at91sam9260_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam926x_time.o
at91sam9261_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9G10)	+= at91sam9261.o at91sam926x_time.o
at91sam9261_devices.o sam9_smc.o
