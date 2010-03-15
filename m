From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 15 Mar 2010 06:20:41 +0000
Subject: QUERY: How to handle SOC Configuration (Peripheral
	Multiplexing) in linux
In-Reply-To: <4B9DB823.1040809@st.com>
References: <4B9DB823.1040809@st.com>
Message-ID: <20100315062041.GD31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 10:01:31AM +0530, Viresh KUMAR wrote:
> Hello everybody,
> 
> In our SOC's (SPEArxxx), we have many peripheral sharing PL_GPIO pins and so
> only few peripherals can be selected in a configuration. This is configurable
> using a set of registers. Now the problem is to make following work:
> 
> 1. How to do this selection in kernel in a simple way?
> 2. Based on this selection hardware registers needs to be configured.
> 
> I propose following solution to solve this issue, but i am not sure if it is
> acceptable by community.
> 
> Please see if it is fine. Or if there is any other way people may already be
> following for similar issues.
> 
> I have provided this selection from "make menuconfig", based on selection I
> configure hardware at initialization time. Basically these selections will
> decide which device is present in the system when it boots.

This is really bad idea, what happens if you have a selection of
boards with mutually-exclusive peripheral sets? Making these sorts of
decisions at compile time is always a bad idea, it leaves people making
distributitions a lot of extra work.

My first idea would be to add a function which is given a bitmap or
list of devices to register, and this function sorts out what hardware
bits to set as needed and then register if the selection is possible.


 
> There are modes in which SOC can be configured and in these modes
> peripherals can be selected.
> 
> 
> 
> file: arch/arm/mach-spear3xx/Kconfig300
> 
> #
> # SPEAr300 machine configuration file
> #
> if MACH_SPEAR300
> 
> choice
> 	prompt "SPEAr300 Boards"
> 	default BOARD_SPEAR300_EVB
> 
> config BOARD_SPEAR300_EVB
> 	bool "SPEAr300 Evaluation Board"
> 	help
> 	  Supports ST SPEAr300 Evaluation Board
> 
> endchoice
> 
> # SOC configuration for SPEAr 300 machine
> menu "SPEAr300 SOC Configuration"
> 
> # Operation modes
> choice
> 	prompt "Select Operation Mode"
> 	default PHOTO_FRAME_MODE
> 
> config NAND_MODE
> 	bool "NAND Mode"
> 	help
> 	  This mode will enable NAND Mode of SPEAr300 SOC.
> 
> config NOR_MODE
> 	bool "NOR Mode"
> 	help
> 	  This mode will enable NOR Mode of SPEAr300 SOC.
> 
> config PHOTO_FRAME_MODE
> 	bool "PHOTO FRAME Mode"
> 	help
> 	  This mode will enable PHOTO FRAME Mode of SPEAr300 SOC.
> 
> config LEND_IP_PHONE_MODE
> 	bool "LEND IP PHONE (LOW END IP PHONE mode)"
> 	help
> 	  This mode will enable LEND IP PHONE Mode of SPEAr300 SOC.
> 
> config HEND_IP_PHONE_MODE
> 	bool "HEND IP PHONE (HIGH END IP PHONE mode)"
> 	help
> 	  This mode will enable HEND IP PHONE Mode of SPEAr300 SOC.
> 
> config LEND_WIFI_PHONE_MODE
> 	bool "LEND WIFI PHONE (LOW END WI-FI PHONE mode)"
> 	help
> 	  This mode will enable LEND WIFI PHONE Mode of SPEAr300 SOC.
> 
> config HEND_WIFI_PHONE_MODE
> 	bool "HEND WIFI PHONE (HIGH END WI-FI PHONE mode)"
> 	help
> 	  This mode will enable HEND WIFI PHONE Mode of SPEAr300 SOC.
> 
> config ATA_PABX_wI2S_MODE
> 	bool "ATA PABX wI2S (ATA PABX without I2S) mode"
> 	help
> 	  This mode will enable ATA PABX wI2S Mode of SPEAr300 SOC.
> 
> config ATA_PABX_I2S_MODE
> 	bool "ATA PABX I2S (ATA PABX with I2S) Mode"
> 	help
> 	  This mode will enable ATA PABX I2S Mode of SPEAr300 SOC.
> 
> config CAMl_LCDw_MODE
> 	bool "CAMl LCDw (8 bit CAMERA without LCD) Mode"
> 	help
> 	  This mode will enable CAMl LCDw Mode of SPEAr300 SOC.
> 
> config CAMu_LCD_MODE
> 	bool "CAMu LCD (14 bit CAMERA with LCD) Mode"
> 	help
> 	  This mode will enable CAMu LCD Mode of SPEAr300 SOC.
> 
> config CAMu_wLCD_MODE
> 	bool "CAMu wLCD (14 bit CAMERA without LCD) Mode"
> 	help
> 	  This mode will enable CAMu wLCD Mode of SPEAr300 SOC.
> 
> config CAMl_LCD_MODE
> 	bool "CAMl LCD (8 bit CAMERA with LCD) Mode"
> 	help
> 	  This mode will enable CAMl LCD Mode of SPEAr300 SOC.
> 
> endchoice #Select Operation Mode
> 
> #mode specific peripherals
> #FSMC
> config FSMC_2_CHIPS
> 	bool "FSMC 2 CHIPS - Disables FIRDA"
> 	depends on NAND_MODE || NOR_MODE || PHOTO_FRAME_MODE || \
> 	ATA_PABX_wI2S_MODE || ATA_PABX_I2S_MODE
> 	depends on !FSMC_4_CHIPS
> 	default n
> 
> config FSMC_4_CHIPS
> 	bool "FSMC 4 CHIPS - Disables UART and FIRDA"
> 	depends on NAND_MODE || NOR_MODE || PHOTO_FRAME_MODE || \
> 	ATA_PABX_wI2S_MODE || ATA_PABX_I2S_MODE
> 	default n
> 
> #Keyboard
> config KEYBOARD
> 	bool "Keyboard"
> 	depends on LEND_IP_PHONE_MODE || HEND_IP_PHONE_MODE || \
> 	LEND_WIFI_PHONE_MODE || HEND_WIFI_PHONE_MODE || CAMl_LCDw_MODE || \
> 	CAMu_LCD_MODE || CAMu_wLCD_MODE || CAMl_LCD_MODE
> 	default y
> 
> #CLCD
> config CLCD_1
> 	bool "CLCD - Disables TIMER 1-2 and TIMER 3-4"
> 	depends on PHOTO_FRAME_MODE
> 	default n
> 
> config CLCD_2
> 	bool "CLCD - Disables TIMER 3-4"
> 	depends on HEND_IP_PHONE_MODE || HEND_WIFI_PHONE_MODE || \
> 	CAMu_LCD_MODE || CAMl_LCD_MODE
> 	default n
> 
> #Telecom_GPIO Combinations
> config TL_GPIO_1
> 	bool "Telecom GPIO - Disables GMAC"
> 	depends on PHOTO_FRAME_MODE || CAMu_LCD_MODE || CAMl_LCD_MODE
> 	default n
> 
> config TL_GPIO_2
> 	bool "Telecom GPIO - Disables TIMER 1-2, Timer 3-4 and GMAC"
> 	depends on LEND_IP_PHONE_MODE || LEND_WIFI_PHONE_MODE
> 	default n
> 
> config TL_GPIO_3
> 	bool "Telecom GPIO - Disables TIMER 3-4 and GMAC"
> 	depends on ATA_PABX_I2S_MODE || CAMl_LCDw_MODE || CAMu_wLCD_MODE
> 	default n
> 
> config TL_GPIO_4
> 	bool "Telecom GPIO - Disables TIMER 1-2 and GMAC"
> 	depends on HEND_IP_PHONE_MODE || HEND_WIFI_PHONE_MODE
> 	default n
> 
> config TL_GPIO_5
> 	bool "Telecom GPIO - Disables TIMER 1-2-3-4, UART MODEM and GMAC"
> 	depends on ATA_PABX_wI2S_MODE
> 	default n
> 
> #TL_TDM Combinations
> config TL_TDM
> 	bool "Telecom TDM - Disables UART MODEM and SSP CHIP SELECTS"
> 	depends on PHOTO_FRAME_MODE || LEND_IP_PHONE_MODE || \
> 	HEND_IP_PHONE_MODE || LEND_WIFI_PHONE_MODE || HEND_WIFI_PHONE_MODE || \
> 	ATA_PABX_wI2S_MODE || ATA_PABX_I2S_MODE || CAMl_LCDw_MODE || \
> 	CAMu_LCD_MODE || CAMu_wLCD_MODE || CAMl_LCD_MODE
> 	default n
> 
> #TL_SPI_I2C Combinations
> config TL_SPI_I2C
> 	bool "Telecom SPI-CS I2C-CLK - Disables TIMER 1-2 and TIMER 3-4"
> 	depends on LEND_IP_PHONE_MODE || HEND_IP_PHONE_MODE || \
> 	LEND_WIFI_PHONE_MODE || HEND_WIFI_PHONE_MODE || ATA_PABX_wI2S_MODE || \
> 	ATA_PABX_I2S_MODE || CAMl_LCDw_MODE || CAMl_LCD_MODE
> 	default n
> 
> #TL_CAMERA Combinations
> config TL_CAMERA_1
> 	bool "Telecom CAMERA - Disables GMAC"
> 	depends on CAMl_LCDw_MODE || CAMl_LCD_MODE
> 	default n
> 
> config TL_CAMERA_2
> 	bool "Telecom CAMERA - Disables TIMER 1-2, TIMER 3-4 and GMAC"
> 	depends on CAMu_LCD_MODE || CAMu_wLCD_MODE
> 	default n
> 
> #TL_DAC Combinations
> config TL_DAC
> 	bool "Telecom DAC - Disables Timer A"
> 	depends on ATA_PABX_I2S_MODE || CAMl_LCDw_MODE || \
> 	CAMu_LCD_MODE || CAMu_wLCD_MODE || CAMl_LCD_MODE
> 	default n
> 
> #TL_I2S Combinations
> config TL_I2S
> 	bool "Telecom I2S - Disables UART MODEM and SDIO"
> 	depends on LEND_IP_PHONE_MODE || HEND_IP_PHONE_MODE || \
> 	LEND_WIFI_PHONE_MODE || HEND_WIFI_PHONE_MODE || \
> 	ATA_PABX_I2S_MODE || CAMl_LCDw_MODE || CAMu_LCD_MODE || \
> 	CAMu_wLCD_MODE || CAMl_LCD_MODE
> 	depends on !SDIO_1_4 && !SDIO_8
> 	default n
> 
> #Boot Pins Combinations
> config BOOT_PINS
> 	bool "BOOT PINS - Disables UART MODEM, TIMER 1-2 and TIMER 3-4"
> 	depends on NAND_MODE || NOR_MODE
> 	default n
> 
> #SDIO Combinations
> config SDIO_1_4
> 	bool "SDIO 1-4 Bit - Enable GPIO1 and Disables GPIO0 Pin 0 TO 5 and I2S"
> 	depends on PHOTO_FRAME_MODE || LEND_IP_PHONE_MODE || \
> 	HEND_IP_PHONE_MODE || LEND_WIFI_PHONE_MODE || \
> 	HEND_WIFI_PHONE_MODE || CAMl_LCDw_MODE || \
> 	CAMu_LCD_MODE || CAMu_wLCD_MODE || CAMl_LCD_MODE || \
> 	ATA_PABX_wI2S_MODE || ATA_PABX_I2S_MODE
> 	depends on !SDIO_8
> 	select GPIO1
> 	default n
> 
> config SDIO_8
> 	bool "SDIO 8 bit - Enable GPIO1 and Disables GPIO0 Pin 0 TO 5, GMAC and I2S"
> 	depends on PHOTO_FRAME_MODE || LEND_IP_PHONE_MODE || \
> 	HEND_IP_PHONE_MODE || LEND_WIFI_PHONE_MODE || \
> 	HEND_WIFI_PHONE_MODE || CAMl_LCDw_MODE || \
> 	CAMu_LCD_MODE || CAMu_wLCD_MODE || CAMl_LCD_MODE
> 	select GPIO1
> 	default n
> 
> #GPIO Combinations
> config GPIO1
> 	bool "GPIO1 - Disables UART MODEM, TIMER 1-2 and TIMER 3-4"
> 	depends on PHOTO_FRAME_MODE
> 	default n
> 
> #peripherals available in all modes
> config FIRDA
> 	bool "FIRDA"
> 	depends on !FSMC_4_CHIPS && !FSMC_2_CHIPS
> 	default y
> 
> config I2C
> 	bool "I2C"
> 	default y
> 
> config SSP
> 	bool "SSP"
> 	default y
> 
> config SSP_CHIP_SELECTS
> 	bool "SSP CHIP SELECTS"
> 	depends on !TL_TDM
> 	default y
> 
> config GMAC
> 	bool "GMAC"
> 	depends on !TL_GPIO_1 && !TL_GPIO_2 && !TL_GPIO_3 && !TL_GPIO_4 && \
> 	!TL_GPIO_5 && !TL_CAMERA_1 && !TL_CAMERA_2 && !SDIO_8
> 	default y
> 
> config GPIO0_PIN_0_TO_5
> 	bool "GPIO0 Pin 0 TO 5"
> 	depends on !SDIO_1_4 && !SDIO_8
> 	default y
> 
> config UART
> 	bool "UART"
> 	depends on !FSMC_4_CHIPS
> 	default y
> 
> config UART_MODEM
> 	bool "UART MODEM"
> 	depends on !TL_GPIO_5 && !TL_TDM && !TL_I2S && !BOOT_PINS && !GPIO1
> 	default y
> 
> config TIMER_1_2
> 	bool "TIMER 1-2"
> 	depends on !CLCD_1 && !TL_GPIO_2 && !TL_GPIO_4 && !TL_GPIO_5 && \
> 	!TL_SPI_I2C && !TL_CAMERA_2 && !TL_DAC && !BOOT_PINS && !GPIO1
> 	default y
> 
> config TIMER_3_4
> 	bool "TIMER 3-4"
> 	depends on !CLCD_1 && !CLCD_2 && !TL_GPIO_2 && !TL_GPIO_3 && \
> 	!TL_GPIO_5 && !TL_SPI_I2C && !BOOT_PINS && !GPIO1 && !TL_CAMERA_2
> 	default y
> 
> endmenu #SOC Configuration
> 
> endif	#MACH_SPEAR300
> 
> 
> 
> 
> file: arch/arm/mach-spear3xx/spear300.c
> 
> /* macros with configuration values for modes */
> #define S300_NAND_MODE			1
> #define S300_NOR_MODE			2
> #define S300_PHOTO_FRAME_MODE		3
> #define S300_LEND_IP_PHONE_MODE		4
> #define S300_HEND_IP_PHONE_MODE		5
> #define S300_LEND_WIFI_PHONE_MODE	6
> #define S300_HEND_WIFI_PHONE_MODE	7
> #define S300_ATA_PABX_wI2S_MODE		8
> #define S300_ATA_PABX_I2S_MODE		9
> #define S300_CAMl_LCDw_MODE		10
> #define S300_CAMu_LCD_MODE		11
> #define S300_CAMu_LCDw_MODE		12
> #define S300_CAMl_LCD_MOD		13
> 
> /* macros with configuration values for peripherals */
> #define S300_FIRDA 		~0x00004000
> #define S300_I2C		~0x00002000
> #define S300_SSP_ENHANCED	~0x00001000
> #define S300_SSP_BASIC		~0x00000800
> #define S300_MII		~0x00000400
> #define S300_LEG_GPIO		~0x000003f0
> #define S300_UART_ENHANCED	~0x00000008
> #define S300_UART_BASIC		~0x00000004
> #define S300_TIMER_B		~0x00000002
> #define S300_TIMER_A		~0x00000000
> 
> void spear300_configure(void)
> {
> 	/* two variables to temporarily store values of two registers */
> 	volatile unsigned int *config_reg1;
> 	volatile unsigned int *config_reg2;
> 
> #ifndef CONFIG_FIRDA
> 	*config_reg1 &= FIRDA;
> #endif
> #ifndef CONFIG_I2C
> 	*config_reg1 &= I2C;
> #endif
> #ifndef CONFIG_SSP_CHIP_SELECTS
> 	*config_reg1 &= SSP_CHIP_SELECTS;
> #endif
> #ifndef CONFIG_SSP
> 	*config_reg1 &= SSP;
> #endif
> #ifndef CONFIG_GMAC
> 	*config_reg1 &= GMAC;
> #endif
> #ifndef CONFIG_GPIO0_PIN_0_TO_5
> 	*config_reg1 &= GPIO0_PIN_0_TO_5;
> #endif
> #ifndef CONFIG_UART_MODEM
> 	*config_reg1 &= UART_MODEM;
> #endif
> #ifndef CONFIG_UART
> 	*config_reg1 &= UART;
> #endif
> #ifndef CONFIG_TIMER_3_4
> 	*config_reg1 &= TIMER_3_4;
> #endif
> #ifndef CONFIG_TIMER_1_2
> 	*config_reg1 &= TIMER_1_2;
> #endif
> 
> #ifdef CONFIG_NAND_MODE
> 	*config_reg2 = NAND_MODE;
> #endif
> #ifdef CONFIG_NOR_MODE
> 	*config_reg2 = NOR_MODE;
> #endif
> #ifdef CONFIG_PHOTO_FRAME_MODE
> 	*config_reg2 = PHOTO_FRAME_MODE;
> #endif
> #ifdef CONFIG_LEND_IP_PHONE_MODE
> 	*config_reg2 = LEND_IP_PHONE_MODE;
> #endif
> #ifdef CONFIG_HEND_IP_PHONE_MODE
> 	*config_reg2 = HEND_IP_PHONE_MODE;
> #endif
> #ifdef CONFIG_LEND_WIFI_PHONE_MODE
> 	*config_reg2 = LEND_WIFI_PHONE_MODE;
> #endif
> #ifdef CONFIG_HEND_WIFI_PHONE_MODE
> 	*config_reg2 = HEND_WIFI_PHONE_MODE;
> #endif
> #ifdef CONFIG_ATA_PABX_wI2S_MODE
> 	*config_reg2 = ATA_PABX_wI2S_MODE;
> #endif
> #ifdef CONFIG_ATA_PABX_I2S_MODE
> 	*config_reg2 = ATA_PABX_I2S_MODE;
> #endif
> #ifdef CONFIG_CAMl_LCDw_MODE
> 	*config_reg2 = CAMl_LCDw_MODE;
> #endif
> #ifdef CONFIG_CAMu_LCD_MODE
> 	*config_reg2 = CAMu_LCD_MODE;
> #endif
> #ifdef CONFIG_CAMu_wLCD_MODE
> 	*config_reg2 = CAMu_LCDw_MODE;
> #endif
> #ifdef CONFIG_CAMl_LCD_MODE
> 	*config_reg2 = CAMl_LCD_MODE;
> #endif
> 
> 	/* At the end we can write these values to actual registers */
> }
> 
> regards,
> viresh kumar.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
