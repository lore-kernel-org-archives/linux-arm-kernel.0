From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 11 Oct 2009 00:01:19 +0800
Subject: [RFC] Re-order of PXA-based platforms in Kconfig and Makefile
Message-ID: <f17812d70910100901m57999415mecc637a05921e78a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I've listed almost all the PXA based platforms currently existing in mainline
kernel as below. Due to the naming mess in Kconfig and Makefile, I'd like to
get them sorted in the following order:

  1. By category:
     Intel/Marvell Dev Platforms, followed by 3rd party platforms, followed
     by end-user products (this is to ensure the commonly referenced platforms
     will appear first)

  2. By vendor name in alphabetic within each category
     (this is to ensure code reuse and similar platforms can be grouped as
      much as possible)

Patch is attached, and any problems, please let me know.

- eric

Vendor		Board Name	Processor	Maintaneance Status
Intel/Marvell	Lubbock		PXA255		Eric Miao
Intel/Marvell	Mainstone	PXA27x		Eric Miao
Intel/Marvell	Zylonite	PXA3xx		Eric Miao
Intel/Marvell	Littleton	PXA3xx		Eric Miao
Intel/Marvell	TavorEVB	PXA93x		Eric Miao
Intel/Marvell	SAAR		PXA93x		Eric Miao
			
Accelent	IDP		PXA255		Cliff Brake <cliff.brake@gmail.com>
Arcom/Eurotech	VIPER		PXA255		Marc Zyngier <maz@misterjones.org>
Community	Balloon3	PXA27x		Jonathan McDowell <noodles@earth.li>
Cogent		CSB726		PXA25x		Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
CompuLab	EM_X270		PXA27x		Mike Rapoport <mike@compulab.co.il>
CompuLab	EXEDA		PXA27x		Mike Rapoport <mike@compulab.co.il>
CompuLab	ARMCORE		PXA25x/PXA27x	Mike Rapoport <mike@compulab.co.il>
CompuLab	CM_X300		PXA3xx		Mike Rapoport <mike@compulab.co.il>
Gumstix		Gumstix		PXA25x		Unknown (Jaya Kumar did some contribution)
Intel Research	MOTE2		PXA27x		Unknown (initial submission by Jonathan Cameron)
Intel research	Stargate2	PXA27x		Unknown (initial submission by
Jonathan Cameron)
Iskratel	XCEP		PXA25x		Unknown (initial submission by:
							Ale? Bardorfer <ales.bardorfer@i-tech.si>
							Michael Abbott <michael.abbott@diamond.ac.uk>
							Matej Kenda <matej.kenda@i-tech.si>)
Keith and Koep	Trizeps4	PXA27x		Jurgen Schindele (linux at schindele.name)
LogicPD		LPD270		PXA27x		Unknown
Phytec		PCM027		PXA27x		Penguitronix
Toradex		Colibri		PXA27x/PXA3xx	Daniel Mack <daniel@caiaq.de>
			
HP		HX4700		PXA27x		Philipp Zabel <philipp.zabel@gmail.com>
HP		H5000		PXA27x		Unknown (initial submission by:
							Anton Vorontsov <cbouatmailru@gmail.com>
							Milan Plzik <milan.plzik@gmail.com>)
HTC		Himalaya	PXA27x		Zbynek Michl <Zbynek.Michl@seznam.cz>
HTC		Magician	PXA27x		Philipp Zabel <philipp.zabel@gmail.com>
Mitac		MioA701		PXA27x		Robert Jarzmik <robert.jarzmik@free.fr>
Motorola	EZX		PXA27x		Daniel Ribeiro <drwyrm@gmail.com>
						Stefan Schmidt <stefan@openezx.org>
						Harald Welte <laforge@openezx.org>
NEC		MP900C		PXA27x		Initial submission by Kristoffer Ericson
<Kristoffer.Ericson@gmail.com>
Palm		Palm PDA	PXA25x/PXA27x	Marek Vasut <marek.vasut@gmail.com>
Palm		Palm GSM	PXA27x		Tomas Cech <sleep_walker@suse.cz>
Sharp		Zaurus		PXA25x/PXA27x	Many (Eric/Richard/Dmitry)
Toshiba		E-Series	PXA25x/PXA27x	Ian Molton <spyro@f2s.com>
-------------- next part --------------
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 28f0260..a0d7321 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -31,216 +31,144 @@ endmenu
 
 endif
 
-config ARCH_GUMSTIX
-	bool "Gumstix XScale 255 boards"
-	select PXA25x
-	help
-	  Say Y here if you intend to run this kernel on
-	  Basix, Connex, ws-200ax, ws-400ax systems
-
-choice
-	prompt "Gumstix Carrier/Expansion Board"
-	depends on ARCH_GUMSTIX
-
-config GUMSTIX_AM200EPD
-	bool "Enable AM200EPD board support"
-
-config GUMSTIX_AM300EPD
-	bool "Enable AM300EPD board support"
-
-endchoice
-
-config MACH_INTELMOTE2
-	bool "Intel Mote 2 Platform"
-	select PXA27x
-	select IWMMXT
-	select PXA_HAVE_BOARD_IRQS
-
-config MACH_STARGATE2
-	bool "Intel Stargate 2 Platform"
-	select PXA27x
-	select IWMMXT
-	select PXA_HAVE_BOARD_IRQS
+### Intel/Marvell Dev Platforms (sorted by hardware release date) ###
 
 config ARCH_LUBBOCK
-	bool "Intel DBPXA250 Development Platform"
+	bool "Intel DBPXA250 Development Platform (aka Lubbock)"
 	select PXA25x
 	select SA1111
 	select PXA_HAVE_BOARD_IRQS
 
-config MACH_LOGICPD_PXA270
-	bool "LogicPD PXA270 Card Engine Development Platform"
+config MACH_MAINSTONE
+	bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
 	select PXA27x
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
-config MACH_MAINSTONE
-	bool "Intel HCDDBBVA0 Development Platform"
-	select PXA27x
+config MACH_ZYLONITE
+	bool "PXA3xx Development Platform (aka Zylonite)"
+	select PXA3xx
+	select PXA_SSP
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
-config MACH_MP900C
-	bool "Nec Mobilepro 900/c"
+config MACH_LITTLETON
+	bool "PXA3xx Form Factor Platform (aka Littleton)"
+	select PXA3xx
+	select PXA_SSP
+
+config MACH_TAVOREVB
+	bool "PXA930 Evaluation Board (aka TavorEVB)"
+	select PXA3xx
+	select CPU_PXA930
+
+config MACH_SAAR
+	bool "PXA930 Handheld Platform (aka SAAR)"
+	select PXA3xx
+	select CPU_PXA930
+
+### Third Party Dev Platforms (sorted by vendor name) ###
+
+config ARCH_PXA_IDP
+	bool "Accelent Xscale IDP"
 	select PXA25x
 
+config ARCH_VIPER
+	bool "Arcom/Eurotech VIPER SBC"
+	select PXA25x
+	select ISA
+	select I2C_GPIO
+	select HAVE_PWM
+	select PXA_HAVE_BOARD_IRQS
+	select PXA_HAVE_ISA_IRQS
+
 config MACH_BALLOON3
 	bool "Balloon 3 board"
 	select PXA27x
 	select IWMMXT
 	select PXA_HAVE_BOARD_IRQS
 
-config ARCH_PXA_IDP
-	bool "Accelent Xscale IDP"
-	select PXA25x
-
-config PXA_SHARPSL
-	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
-	select SHARP_SCOOP
-	select SHARP_PARAM
+config MACH_CSB726
+	bool "Enable Cogent CSB726 System On a Module"
+	select PXA27x
+	select IWMMXT
 	help
-	  Say Y here if you intend to run this kernel on a
-	  Sharp Zaurus SL-5600 (Poodle), SL-C700 (Corgi),
-	  SL-C750 (Shepherd), SL-C760 (Husky), SL-C1000 (Akita),
-	  SL-C3000 (Spitz), SL-C3100 (Borzoi) or SL-C6000x (Tosa)
-	  handheld computer.
-
-config SHARPSL_PM
-	bool
-	select APM_EMULATION
+	  Say Y here if you intend to run this kernel on a Cogent
+	  CSB726 System On Module.
 
-config CORGI_SSP_DEPRECATED
-	bool
-	select PXA_SSP
-	help
-	  This option will include corgi_ssp.c and corgi_lcd.c
-	  that corgi_ts.c and other legacy drivers (corgi_bl.c
-	  and sharpsl_pm.c) may depend on.
+config CSB726_CSB701
+	bool "Enable supprot for CSB701 baseboard"
+	depends on MACH_CSB726
 
-config MACH_POODLE
-	bool "Enable Sharp SL-5600 (Poodle) Support"
-	depends on PXA_SHARPSL
+config MACH_ARMCORE
+	bool "CompuLab CM-X255/CM-X270 modules"
+	select PXA27x
+	select IWMMXT
 	select PXA25x
-	select SHARP_LOCOMO
 	select PXA_SSP
 
-config MACH_CORGI
-	bool "Enable Sharp SL-C700 (Corgi) Support"
-	depends on PXA_SHARPSL
-	select PXA25x
-	select PXA_SHARP_C7xx
-
-config MACH_SHEPHERD
-	bool "Enable Sharp SL-C750 (Shepherd) Support"
-	depends on PXA_SHARPSL
-	select PXA25x
-	select PXA_SHARP_C7xx
-
-config MACH_HUSKY
-	bool "Enable Sharp SL-C760 (Husky) Support"
-	depends on PXA_SHARPSL
-	select PXA25x
-	select PXA_SHARP_C7xx
-
-config MACH_AKITA
-	bool "Enable Sharp SL-1000 (Akita) Support"
-	depends on PXA_SHARPSL
-	select PXA27x
-	select PXA_SHARP_Cxx00
-	select MACH_SPITZ
-	select I2C
-	select I2C_PXA
-
-config MACH_SPITZ
-	bool "Enable Sharp Zaurus SL-3000 (Spitz) Support"
-	depends on PXA_SHARPSL
+config MACH_EM_X270
+	bool "CompuLab EM-x270 platform"
 	select PXA27x
-	select PXA_SHARP_Cxx00
 
-config MACH_BORZOI
-	bool "Enable Sharp Zaurus SL-3100 (Borzoi) Support"
-	depends on PXA_SHARPSL
+config MACH_EXEDA
+	bool "CompuLab eXeda platform"
 	select PXA27x
-	select PXA_SHARP_Cxx00
 
-config MACH_TOSA
-	bool "Enable Sharp SL-6000x (Tosa) Support"
-	depends on PXA_SHARPSL
-	select PXA25x
-	select PXA_HAVE_BOARD_IRQS
+config MACH_CM_X300
+	bool "CompuLab CM-X300 modules"
+	select PXA3xx
+	select CPU_PXA300
 
-config ARCH_VIPER
-	bool "Arcom/Eurotech VIPER SBC"
+config ARCH_GUMSTIX
+	bool "Gumstix XScale 255 boards"
 	select PXA25x
-	select ISA
-	select I2C_GPIO
-	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
-	select PXA_HAVE_ISA_IRQS
+	help
+	  Say Y here if you intend to run this kernel on
+	  Basix, Connex, ws-200ax, ws-400ax systems
 
-config ARCH_PXA_ESERIES
-	bool "PXA based Toshiba e-series PDAs"
-	select PXA25x
-	select PXA_HAVE_BOARD_IRQS
+choice
+	prompt "Gumstix Carrier/Expansion Board"
+	depends on ARCH_GUMSTIX
 
-config MACH_E330
-	bool "Toshiba e330"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e330 family PDA.
+config GUMSTIX_AM200EPD
+	bool "Enable AM200EPD board support"
 
-config MACH_E350
-	bool "Toshiba e350"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e350 family PDA.
+config GUMSTIX_AM300EPD
+	bool "Enable AM300EPD board support"
 
-config MACH_E740
-	bool "Toshiba e740"
-	default y
-	depends on ARCH_PXA_ESERIES
-	select FB_W100
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e740 family PDA.
+endchoice
 
-config MACH_E750
-	bool "Toshiba e750"
-	default y
-	depends on ARCH_PXA_ESERIES
-	select FB_W100
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e750 family PDA.
+config MACH_INTELMOTE2
+	bool "Intel Mote 2 Platform"
+	select PXA27x
+	select IWMMXT
+	select PXA_HAVE_BOARD_IRQS
 
-config MACH_E400
-	bool "Toshiba e400"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e400 family PDA.
+config MACH_STARGATE2
+	bool "Intel Stargate 2 Platform"
+	select PXA27x
+	select IWMMXT
+	select PXA_HAVE_BOARD_IRQS
 
-config MACH_E800
-	bool "Toshiba e800"
-	default y
-	depends on ARCH_PXA_ESERIES
-	select FB_W100
+config MACH_XCEP
+	bool "Iskratel Electronics XCEP"
+	select PXA25x
+	select MTD
+	select MTD_PARTITIONS
+	select MTD_PHYSMAP
+	select MTD_CFI_INTELEXT
+	select MTD_CFI
+	select MTD_CHAR
+	select SMC91X
+	select PXA_SSP
 	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e800 family PDA.
+	  PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
+	  Tuned for usage in Libera instruments for particle accelerators.
 
 config TRIZEPS_PXA
 	bool "PXA based Keith und Koep Trizeps DIMM-Modules"
 
-config MACH_H5000
-	bool "HP iPAQ h5000"
-	select PXA25x
-
 config MACH_TRIZEPS4
 	bool "Keith und Koep Trizeps4 DIMM-Module"
 	depends on TRIZEPS_PXA
@@ -274,13 +202,38 @@ config TRIZEPS_PCMCIA
 	help
 	  Enable PCMCIA support for Trizeps modules
 
-config MACH_EM_X270
-	bool "CompuLab EM-x270 platform"
+config MACH_LOGICPD_PXA270
+	bool "LogicPD PXA270 Card Engine Development Platform"
 	select PXA27x
+	select HAVE_PWM
+	select PXA_HAVE_BOARD_IRQS
 
-config MACH_EXEDA
-	bool "CompuLab eXeda platform"
+config MACH_PCM027
+	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
 	select PXA27x
+	select IWMMXT
+	select PXA_SSP
+	select PXA_HAVE_BOARD_IRQS
+
+config MACH_PCM990_BASEBOARD
+	bool "PHYTEC PCM-990 development board"
+	select HAVE_PWM
+	depends on MACH_PCM027
+
+choice
+	prompt "display on pcm990"
+	depends on MACH_PCM990_BASEBOARD
+
+config PCM990_DISPLAY_SHARP
+	bool "sharp lq084v1dg21 stn display"
+
+config PCM990_DISPLAY_NEC
+	bool "nec nl6448bc20_18d tft display"
+
+config PCM990_DISPLAY_NONE
+	bool "no display"
+
+endchoice
 
 config MACH_COLIBRI
 	bool "Toradex Colibri PXA270"
@@ -296,39 +249,7 @@ config MACH_COLIBRI320
 	select PXA3xx
 	select CPU_PXA320
 
-config MACH_ZYLONITE
-	bool "PXA3xx Development Platform (aka Zylonite)"
-	select PXA3xx
-	select PXA_SSP
-	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
-
-config MACH_LITTLETON
-	bool "PXA3xx Form Factor Platform (aka Littleton)"
-	select PXA3xx
-	select PXA_SSP
-
-config MACH_TAVOREVB
-	bool "PXA930 Evaluation Board (aka TavorEVB)"
-	select PXA3xx
-	select CPU_PXA930
-
-config MACH_SAAR
-	bool "PXA930 Handheld Platform (aka SAAR)"
-	select PXA3xx
-	select CPU_PXA930
-
-config MACH_ARMCORE
-	bool "CompuLab CM-X255/CM-X270 modules"
-	select PXA27x
-	select IWMMXT
-	select PXA25x
-	select PXA_SSP
-
-config MACH_CM_X300
-	bool "CompuLab CM-X300 modules"
-	select PXA3xx
-	select CPU_PXA300
+### End-user Products (sorted by vendor name) ###
 
 config MACH_H4700
 	bool "HP iPAQ hx4700"
@@ -338,6 +259,15 @@ config MACH_H4700
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
+config MACH_H5000
+	bool "HP iPAQ h5000"
+	select PXA25x
+
+config MACH_HIMALAYA
+	bool "HTC Himalaya Support"
+	select CPU_PXA26x
+	select FB_W100
+
 config MACH_MAGICIAN
 	bool "Enable HTC Magician Support"
 	select PXA27x
@@ -346,11 +276,6 @@ config MACH_MAGICIAN
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
-config MACH_HIMALAYA
-	bool "HTC Himalaya Support"
-	select CPU_PXA26x
-	select FB_W100
-
 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
 	select PXA27x
@@ -362,13 +287,47 @@ config MACH_MIOA701
 	  MIO A701. Currently there is only basic support
 	  for this PDA.
 
-config MACH_PCM027
-	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
+config PXA_EZX
+	bool "Motorola EZX Platform"
 	select PXA27x
 	select IWMMXT
-	select PXA_SSP
+	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
+config MACH_EZX_A780
+	bool "Motorola EZX A780"
+	default y
+	depends on PXA_EZX
+
+config MACH_EZX_E680
+	bool "Motorola EZX E680"
+	default y
+	depends on PXA_EZX
+
+config MACH_EZX_A1200
+	bool "Motorola EZX A1200"
+	default y
+	depends on PXA_EZX
+
+config MACH_EZX_A910
+	bool "Motorola EZX A910"
+	default y
+	depends on PXA_EZX
+
+config MACH_EZX_E6
+	bool "Motorola EZX E6"
+	default y
+	depends on PXA_EZX
+
+config MACH_EZX_E2
+	bool "Motorola EZX E2"
+	default y
+	depends on PXA_EZX
+
+config MACH_MP900C
+	bool "Nec Mobilepro 900/c"
+	select PXA25x
+
 config ARCH_PXA_PALM
 	bool "PXA based Palm PDAs"
 	select HAVE_PWM
@@ -421,6 +380,16 @@ config MACH_PALMZ72
 	  Say Y here if you intend to run this kernel on Palm Zire 72
 	  handheld computer.
 
+config MACH_PALMLD
+	bool "Palm LifeDrive"
+	default y
+	depends on ARCH_PXA_PALM
+	select PXA27x
+	select IWMMXT
+	help
+	  Say Y here if you intend to run this kernel on a Palm LifeDrive
+	  handheld computer.
+
 config PALM_TREO
 	bool
 	depends on ARCH_PXA_PALM
@@ -447,99 +416,136 @@ config MACH_TREO680
 	  Say Y here if you intend to run this kernel on Palm Treo 680
 	  smartphone.
 
-config MACH_PALMLD
-	bool "Palm LifeDrive"
-	default y
-	depends on ARCH_PXA_PALM
-	select PXA27x
-	select IWMMXT
+config PXA_SHARPSL
+	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
+	select SHARP_SCOOP
+	select SHARP_PARAM
 	help
-	  Say Y here if you intend to run this kernel on a Palm LifeDrive
+	  Say Y here if you intend to run this kernel on a
+	  Sharp Zaurus SL-5600 (Poodle), SL-C700 (Corgi),
+	  SL-C750 (Shepherd), SL-C760 (Husky), SL-C1000 (Akita),
+	  SL-C3000 (Spitz), SL-C3100 (Borzoi) or SL-C6000x (Tosa)
 	  handheld computer.
 
-config MACH_PCM990_BASEBOARD
-	bool "PHYTEC PCM-990 development board"
-	select HAVE_PWM
-	depends on MACH_PCM027
+config SHARPSL_PM
+	bool
+	select APM_EMULATION
 
-choice
-	prompt "display on pcm990"
-	depends on MACH_PCM990_BASEBOARD
+config CORGI_SSP_DEPRECATED
+	bool
+	select PXA_SSP
+	help
+	  This option will include corgi_ssp.c and corgi_lcd.c
+	  that corgi_ts.c and other legacy drivers (corgi_bl.c
+	  and sharpsl_pm.c) may depend on.
 
-config PCM990_DISPLAY_SHARP
-	bool "sharp lq084v1dg21 stn display"
+config MACH_POODLE
+	bool "Enable Sharp SL-5600 (Poodle) Support"
+	depends on PXA_SHARPSL
+	select PXA25x
+	select SHARP_LOCOMO
+	select PXA_SSP
 
-config PCM990_DISPLAY_NEC
-	bool "nec nl6448bc20_18d tft display"
+config MACH_CORGI
+	bool "Enable Sharp SL-C700 (Corgi) Support"
+	depends on PXA_SHARPSL
+	select PXA25x
+	select PXA_SHARP_C7xx
 
-config PCM990_DISPLAY_NONE
-	bool "no display"
+config MACH_SHEPHERD
+	bool "Enable Sharp SL-C750 (Shepherd) Support"
+	depends on PXA_SHARPSL
+	select PXA25x
+	select PXA_SHARP_C7xx
 
-endchoice
+config MACH_HUSKY
+	bool "Enable Sharp SL-C760 (Husky) Support"
+	depends on PXA_SHARPSL
+	select PXA25x
+	select PXA_SHARP_C7xx
 
-config MACH_CSB726
-	bool "Enable Cogent CSB726 System On a Module"
+config MACH_AKITA
+	bool "Enable Sharp SL-1000 (Akita) Support"
+	depends on PXA_SHARPSL
 	select PXA27x
-	select IWMMXT
-	help
-	  Say Y here if you intend to run this kernel on a Cogent
-	  CSB726 System On Module.
+	select PXA_SHARP_Cxx00
+	select MACH_SPITZ
+	select I2C
+	select I2C_PXA
 
-config CSB726_CSB701
-	bool "Enable supprot for CSB701 baseboard"
-	depends on MACH_CSB726
+config MACH_SPITZ
+	bool "Enable Sharp Zaurus SL-3000 (Spitz) Support"
+	depends on PXA_SHARPSL
+	select PXA27x
+	select PXA_SHARP_Cxx00
 
-config PXA_EZX
-	bool "Motorola EZX Platform"
+config MACH_BORZOI
+	bool "Enable Sharp Zaurus SL-3100 (Borzoi) Support"
+	depends on PXA_SHARPSL
 	select PXA27x
-	select IWMMXT
-	select HAVE_PWM
+	select PXA_SHARP_Cxx00
+
+config MACH_TOSA
+	bool "Enable Sharp SL-6000x (Tosa) Support"
+	depends on PXA_SHARPSL
+	select PXA25x
 	select PXA_HAVE_BOARD_IRQS
 
-config MACH_EZX_A780
-	bool "Motorola EZX A780"
-	default y
-	depends on PXA_EZX
+config ARCH_PXA_ESERIES
+	bool "PXA based Toshiba e-series PDAs"
+	select PXA25x
+	select PXA_HAVE_BOARD_IRQS
 
-config MACH_EZX_E680
-	bool "Motorola EZX E680"
+config MACH_E330
+	bool "Toshiba e330"
 	default y
-	depends on PXA_EZX
+	depends on ARCH_PXA_ESERIES
+	help
+	  Say Y here if you intend to run this kernel on a Toshiba
+	  e330 family PDA.
 
-config MACH_EZX_A1200
-	bool "Motorola EZX A1200"
+config MACH_E350
+	bool "Toshiba e350"
 	default y
-	depends on PXA_EZX
+	depends on ARCH_PXA_ESERIES
+	help
+	  Say Y here if you intend to run this kernel on a Toshiba
+	  e350 family PDA.
 
-config MACH_EZX_A910
-	bool "Motorola EZX A910"
+config MACH_E740
+	bool "Toshiba e740"
 	default y
-	depends on PXA_EZX
+	depends on ARCH_PXA_ESERIES
+	select FB_W100
+	help
+	  Say Y here if you intend to run this kernel on a Toshiba
+	  e740 family PDA.
 
-config MACH_EZX_E6
-	bool "Motorola EZX E6"
+config MACH_E750
+	bool "Toshiba e750"
 	default y
-	depends on PXA_EZX
+	depends on ARCH_PXA_ESERIES
+	select FB_W100
+	help
+	  Say Y here if you intend to run this kernel on a Toshiba
+	  e750 family PDA.
 
-config MACH_EZX_E2
-	bool "Motorola EZX E2"
+config MACH_E400
+	bool "Toshiba e400"
 	default y
-	depends on PXA_EZX
+	depends on ARCH_PXA_ESERIES
+	help
+	  Say Y here if you intend to run this kernel on a Toshiba
+	  e400 family PDA.
 
-config MACH_XCEP
-	bool "Iskratel Electronics XCEP"
-	select PXA25x
-	select MTD
-	select MTD_PARTITIONS
-	select MTD_PHYSMAP
-	select MTD_CFI_INTELEXT
-	select MTD_CFI
-	select MTD_CHAR
-	select SMC91X
-	select PXA_SSP
+config MACH_E800
+	bool "Toshiba e800"
+	default y
+	depends on ARCH_PXA_ESERIES
+	select FB_W100
 	help
-	  PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
-	  Tuned for usage in Libera instruments for particle accelerators.
+	  Say Y here if you intend to run this kernel on a Toshiba
+	  e800 family PDA.
 
 endmenu
 
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index e5d450c..cdaf888 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -24,33 +24,66 @@ obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 
-# Specific board support
-obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
-obj-$(CONFIG_GUMSTIX_AM200EPD)	+= am200epd.o
-obj-$(CONFIG_GUMSTIX_AM300EPD)	+= am300epd.o
+# NOTE: keep the order of boards in accordance to their order in Kconfig
+
+# Intel/Marvell Dev Platforms
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
-obj-$(CONFIG_MACH_LOGICPD_PXA270) += lpd270.o
 obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
-obj-$(CONFIG_MACH_BALLOON3)	+= balloon3.o
-obj-$(CONFIG_MACH_MP900C)	+= mp900.o
+ifeq ($(CONFIG_MACH_ZYLONITE),y)
+  obj-y				+= zylonite.o
+  obj-$(CONFIG_CPU_PXA300)	+= zylonite_pxa300.o
+  obj-$(CONFIG_CPU_PXA320)	+= zylonite_pxa320.o
+endif
+obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
+obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
+obj-$(CONFIG_MACH_SAAR)		+= saar.o
+
+# 3rd Party Dev Platforms
 obj-$(CONFIG_ARCH_PXA_IDP)	+= idp.o
+obj-$(CONFIG_ARCH_VIPER)	+= viper.o
+obj-$(CONFIG_MACH_BALLOON3)	+= balloon3.o
+obj-$(CONFIG_MACH_CSB726)	+= csb726.o
+obj-$(CONFIG_CSB726_CSB701)	+= csb701.o
+obj-$(CONFIG_MACH_ARMCORE)      += cm-x2xx.o cm-x255.o cm-x270.o
+ifeq ($(CONFIG_PCI),y)
+obj-$(CONFIG_MACH_ARMCORE)	+= cm-x2xx-pci.o
+endif
+obj-$(CONFIG_MACH_EM_X270)	+= em-x270.o
+obj-$(CONFIG_MACH_CM_X300)      += cm-x300.o
+obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
+obj-$(CONFIG_GUMSTIX_AM200EPD)	+= am200epd.o
+obj-$(CONFIG_GUMSTIX_AM300EPD)	+= am300epd.o
+obj-$(CONFIG_MACH_INTELMOTE2)   += imote2.o
+obj-$(CONFIG_MACH_STARGATE2)	+= stargate2.o
+obj-$(CONFIG_MACH_XCEP)         += xcep.o
 obj-$(CONFIG_MACH_TRIZEPS4)	+= trizeps4.o
+obj-$(CONFIG_MACH_LOGICPD_PXA270)	+= lpd270.o
+obj-$(CONFIG_MACH_PCM027)		+= pcm027.o
+obj-$(CONFIG_MACH_PCM990_BASEBOARD)	+= pcm990-baseboard.o
 obj-$(CONFIG_MACH_COLIBRI)	+= colibri-pxa270.o
 obj-$(CONFIG_MACH_COLIBRI300)	+= colibri-pxa3xx.o colibri-pxa300.o
 obj-$(CONFIG_MACH_COLIBRI320)	+= colibri-pxa3xx.o colibri-pxa320.o
+
+# End-user Products
+obj-$(CONFIG_MACH_H4700)	+= hx4700.o
 obj-$(CONFIG_MACH_H5000)	+= h5000.o
+obj-$(CONFIG_MACH_HIMALAYA)	+= himalaya.o
+obj-$(CONFIG_MACH_MAGICIAN)	+= magician.o
+obj-$(CONFIG_MACH_MIOA701)	+= mioa701.o mioa701_bootresume.o
+obj-$(CONFIG_PXA_EZX)           += ezx.o
+obj-$(CONFIG_MACH_MP900C)	+= mp900.o
+obj-$(CONFIG_MACH_PALMTE2)	+= palmte2.o
+obj-$(CONFIG_MACH_PALMTC)	+= palmtc.o
+obj-$(CONFIG_MACH_PALMT5)	+= palmt5.o
+obj-$(CONFIG_MACH_PALMTX)	+= palmtx.o
+obj-$(CONFIG_MACH_PALMZ72)	+= palmz72.o
+obj-$(CONFIG_MACH_PALMLD)	+= palmld.o
+obj-$(CONFIG_PALM_TREO)		+= palmtreo.o
 obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o sharpsl_pm.o corgi_pm.o
 obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o sharpsl_pm.o spitz_pm.o
 obj-$(CONFIG_CORGI_SSP_DEPRECATED)	+= corgi_ssp.o corgi_lcd.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
-obj-$(CONFIG_MACH_PCM027)	+= pcm027.o
-obj-$(CONFIG_MACH_PCM990_BASEBOARD)	+= pcm990-baseboard.o
 obj-$(CONFIG_MACH_TOSA)		+= tosa.o
-obj-$(CONFIG_MACH_EM_X270)	+= em-x270.o
-obj-$(CONFIG_MACH_H4700)	+= hx4700.o
-obj-$(CONFIG_MACH_MAGICIAN)	+= magician.o
-obj-$(CONFIG_MACH_HIMALAYA)	+= himalaya.o
-obj-$(CONFIG_MACH_MIOA701)	+= mioa701.o mioa701_bootresume.o
 obj-$(CONFIG_ARCH_PXA_ESERIES)	+= eseries.o
 obj-$(CONFIG_MACH_E330)		+= e330.o
 obj-$(CONFIG_MACH_E350)		+= e350.o
@@ -58,34 +91,6 @@ obj-$(CONFIG_MACH_E740)		+= e740.o
 obj-$(CONFIG_MACH_E750)		+= e750.o
 obj-$(CONFIG_MACH_E400)		+= e400.o
 obj-$(CONFIG_MACH_E800)		+= e800.o
-obj-$(CONFIG_MACH_PALMTE2)	+= palmte2.o
-obj-$(CONFIG_MACH_PALMTC)	+= palmtc.o
-obj-$(CONFIG_MACH_PALMT5)	+= palmt5.o
-obj-$(CONFIG_MACH_PALMTX)	+= palmtx.o
-obj-$(CONFIG_MACH_PALMLD)	+= palmld.o
-obj-$(CONFIG_MACH_PALMZ72)	+= palmz72.o
-obj-$(CONFIG_PALM_TREO)		+= palmtreo.o
-obj-$(CONFIG_ARCH_VIPER)	+= viper.o
-
-ifeq ($(CONFIG_MACH_ZYLONITE),y)
-  obj-y				+= zylonite.o
-  obj-$(CONFIG_CPU_PXA300)	+= zylonite_pxa300.o
-  obj-$(CONFIG_CPU_PXA320)	+= zylonite_pxa320.o
-endif
-obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
-obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
-obj-$(CONFIG_MACH_SAAR)		+= saar.o
-
-obj-$(CONFIG_MACH_ARMCORE)      += cm-x2xx.o cm-x255.o cm-x270.o
-obj-$(CONFIG_MACH_CM_X300)      += cm-x300.o
-obj-$(CONFIG_PXA_EZX)           += ezx.o
-
-obj-$(CONFIG_MACH_XCEP)         += xcep.o
-
-obj-$(CONFIG_MACH_INTELMOTE2)   += imote2.o
-obj-$(CONFIG_MACH_STARGATE2)	+= stargate2.o
-obj-$(CONFIG_MACH_CSB726)	+= csb726.o
-obj-$(CONFIG_CSB726_CSB701)	+= csb701.o
 
 # Support for blinky lights
 led-y := leds.o
@@ -95,8 +100,4 @@ led-$(CONFIG_ARCH_PXA_IDP)	+= leds-idp.o
 
 obj-$(CONFIG_LEDS)		+= $(led-y)
 
-ifeq ($(CONFIG_PCI),y)
-obj-$(CONFIG_MACH_ARMCORE) += cm-x2xx-pci.o
-endif
-
 obj-$(CONFIG_TOSA_BT)		+= tosa-bt.o
