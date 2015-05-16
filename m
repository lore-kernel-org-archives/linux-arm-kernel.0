From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 15 May 2015 18:50:46 -0700
Subject: [PATCH] regulator: Add SPMI regulator driver
In-Reply-To: <1431466787-32247-1-git-send-email-sboyd@codeaurora.org>
References: <1431466787-32247-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5556A276.700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/12/2015 2:39 PM, Stephen Boyd wrote:
> Add an SPMI regulator driver for Qualcomm's PM8941 and PM8916
> PMICs. This driver is based largely on code from
> codeaurora.org[1].
> 
> [1] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/qpnp-regulator.c?h=msm-3.10
> Cc: David Collins <collinsd@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.txt     |  225 +++
>  drivers/regulator/Kconfig                          |   11 +
>  drivers/regulator/Makefile                         |    1 +
>  drivers/regulator/qcom_spmi-regulator.c            | 1750 ++++++++++++++++++++
>  4 files changed, 1987 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
>  create mode 100644 drivers/regulator/qcom_spmi-regulator.c
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> new file mode 100644
> index 000000000000..b89744da62d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> @@ -0,0 +1,225 @@
> +Qualcomm SPMI Regulators
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be one of:
> +			"qcom,pm8841-regulators"
> +			"qcom,pm8916-regulators"
> +			"qcom,pm8941-regulators"
> +
> +- interrupts:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: List of OCP interrupts.
> +
> +- interrupt-names:
> +	Usage: required if 'interrupts' property present
> +	Value type: <string-array>
> +	Definition: List of strings defining the names of the
> +		    interrupts in the 'interrupts' property 1-to-1.
> +		    Supported values are "ocp-<regulator_name>", where
> +		    <regulator_name> corresponds to a voltage switch
> +		    type regulator.
> +
> +- vdd_s1-supply:
> +- vdd_s2-supply:
> +- vdd_s3-supply:
> +- vdd_s4-supply:
> +- vdd_s5-supply:
> +- vdd_s6-supply:
> +- vdd_s7-supply:
> +- vdd_s8-supply:
> +	Usage: optional (pm8841 only)
> +	Value type: <phandle>
> +	Definition: Reference to regulator supplying the input pin, as
> +		    described in the data sheet.
> +
> +- vdd_s1-supply:
> +- vdd_s2-supply:
> +- vdd_s3-supply:
> +- vdd_s4-supply:
> +- vdd_l1_l3-supply:
> +- vdd_l2-supply:
> +- vdd_l4_l5_l6-supply:
> +- vdd_l7-supply:
> +- vdd_l8_l11_l14_l15_l16-supply:
> +- vdd_l9_l10_l12_l13_l17_l18-supply:
> +	Usage: optional (pm8916 only)
> +	Value type: <phandle>
> +	Definition: Reference to regulator supplying the input pin, as
> +		    described in the data sheet.
> +
> +- vdd_s1-supply:
> +- vdd_s2-supply:
> +- vdd_s3-supply:
> +- vdd_l1_l3-supply:
> +- vdd_l2_lvs_1_2_3-supply:
> +- vdd_l4_l11-supply:
> +- vdd_l5_l7-supply:
> +- vdd_l6_l12_l14_l15-supply:
> +- vdd_l8_l16_l18_19-supply:
> +- vdd_l9_l10_l17_l22-supply:
> +- vdd_l13_l20_l23_l24-supply:
> +- vdd_l21-supply:
> +- vin_5vs-supply:
> +	Usage: optional (pm8941 only)
> +	Value type: <phandle>
> +	Definition: Reference to regulator supplying the input pin, as
> +		    described in the data sheet.
> +
> +
> +The regulator node houses sub-nodes for each regulator within the device. Each
> +sub-node is identified using the node's name, with valid values listed for each
> +of the PMICs below.
> +
> +pm8841:
> +	s1, s2, s3, s4, s5, s6, s7, s8
> +
> +pm8916:
> +	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
> +	l14, l15, l16, l17, l18
> +
> +pm8941:
> +	s1, s2, s3, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14,
> +	l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2, lvs3,
> +	mvs1, mvs2
> +
> +The content of each sub-node is defined by the standard binding for regulators -
> +see regulator.txt - with additional custom properties described below:
> +
> +- qcom,system-load:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: Load in uA present on regulator that is not captured by
> +		     any consumer request.
> +
> +- qcom,auto-mode-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable automatic hardware selection of regulator
> +			 mode (HPM vs LPM); not available on boost type
> +			 regulators. 0 = Disable auto mode selection.
> +
> +- qcom,bypass-mode-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable bypass mode for an LDO type regulator so that
> +		     it acts like a switch and simply outputs its input
> +		     voltage. 0 = Do not enable bypass mode.
> +
> +- qcom,ocp-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Allow over current protection (OCP) to be enabled for
> +		     voltage switch type regulators so that they latch off
> +		     automatically when over current is detected. OCP is
> +		     enabled when in HPM or auto mode.  0 = Disable OCP.
> +
> +- qcom,ocp-max-retries:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: Maximum number of times to try toggling a voltage switch
> +		     off and back on as a result of consecutive over current
> +		     events.
> +
> +- qcom,ocp-retry-delay:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: Time to delay in milliseconds between each voltage switch
> +		     toggle after an over current event takes place.
> +
> +- qcom,pull-down-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable output pull down resistor when the regulator
> +		     is disabled. 0 = Disable pull down resistor
> +
> +- qcom,soft-start-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable soft start for LDO and voltage switch type
> +		     regulators so that output voltage slowly ramps up when the
> +		     regulator is enabled. 0 = Disable soft start
> +
> +- qcom,boost-current-limit:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: This property sets the current limit of boost type
> +		     regulators; supported values are:
> +					0 =  300 mA
> +					1 =  600 mA
> +					2 =  900 mA
> +					3 = 1200 mA
> +					4 = 1500 mA
> +					5 = 1800 mA
> +					6 = 2100 mA
> +					7 = 2400 mA
> +
> +- qcom,pin-ctrl-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: Bit mask specifying which hardware pins should be used to
> +		     enable the regulator, if any; supported bits are:
> +			0 = ignore all hardware enable signals
> +			BIT(0) = follow HW0_EN signal
> +			BIT(1) = follow HW1_EN signal
> +			BIT(2) = follow HW2_EN signal
> +			BIT(3) = follow HW3_EN signal
> +
> +- qcom,pin-ctrl-hpm:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: Bit mask specifying which hardware pins should be used to
> +		     force the regulator into high power mode, if any;
> +		     supported bits are:
> +			0 = ignore all hardware enable signals
> +			BIT(0) = follow HW0_EN signal
> +			BIT(1) = follow HW1_EN signal
> +			BIT(2) = follow HW2_EN signal
> +			BIT(3) = follow HW3_EN signal
> +			BIT(4) = follow PMIC awake state
> +
> +- qcom,vs-soft-start-strength:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: This property sets the soft start strength for voltage
> +		     switch type regulators; supported values are:
> +			0 = 0.05 uA
> +			1 = 0.25 uA
> +			2 = 0.55 uA
> +			3 = 0.75 uA
> +
> +- qcom,hpm-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable high power mode (HPM), also referred
> +		     to as NPM.  HPM consumes more ground current than LPM, but
> +		     it can source significantly higher load current. HPM is
> +		     not available on boost type regulators. For voltage
> +		     switch type regulators, HPM implies that over current
> +		     protection and soft start are active all the time. This
> +		     configuration can be overwritten by changing the
> +		     regulator's mode dynamically. 0 = Do not enable HPM.
> +
> +Example:
> +
> +	regulators {
> +		compatible = "qcom,pm8941-regulators";
> +		vdd_l1_l3-supply = <&s1>;
> +
> +		s1: s1 {
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1400000>;
> +		};
> +
> +		...
> +
> +		l1: l1 {
> +			regulator-min-microvolt = <1225000>;
> +			regulator-max-microvolt = <1300000>;
> +			qcom,pull-down-enable = <1>;
> +		};
> +
> +		....
> +	};
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index a6f116aa5235..53b3e25a98a1 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -512,6 +512,17 @@ config REGULATOR_QCOM_RPM
>  	  Qualcomm RPM as a module. The module will be named
>  	  "qcom_rpm-regulator".
>  
> +config REGULATOR_QCOM_SPMI
> +	tristate "Qualcomm SPMI regulator driver"
> +	depends on SPMI || COMPILE_TEST
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  regulators found in Qualcomm SPMI PMICs.
> +
> +	  Say M here if you want to include support for the regulators on the
> +	  Qualcomm SPMI PMICs as a module. The module will be named
> +	  "qcom_spmi-regulator".
> +
>  config REGULATOR_RC5T583
>  	tristate "RICOH RC5T583 Power regulators"
>  	depends on MFD_RC5T583
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 2c4da15e1545..7152c979c935 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
>  obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
>  obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
> +obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
>  obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
>  obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
>  obj-$(CONFIG_REGULATOR_PWM) += pwm-regulator.o
> diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> new file mode 100644
> index 000000000000..f80d6fd940ff
> --- /dev/null
> +++ b/drivers/regulator/qcom_spmi-regulator.c
> @@ -0,0 +1,1750 @@
> +/*
> + * Copyright (c) 2012-2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/bitops.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/ktime.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/regmap.h>
> +#include <linux/list.h>
> +
> +/* Pin control enable input pins. */
> +#define SPMI_REGULATOR_PIN_CTRL_ENABLE_NONE		0x00
> +#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN0		0x01
> +#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN1		0x02
> +#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN2		0x04
> +#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN3		0x08
> +#define SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT	0x10
> +
> +/* Pin control high power mode input pins. */
> +#define SPMI_REGULATOR_PIN_CTRL_HPM_NONE		0x00
> +#define SPMI_REGULATOR_PIN_CTRL_HPM_EN0			0x01
> +#define SPMI_REGULATOR_PIN_CTRL_HPM_EN1			0x02
> +#define SPMI_REGULATOR_PIN_CTRL_HPM_EN2			0x04
> +#define SPMI_REGULATOR_PIN_CTRL_HPM_EN3			0x08
> +#define SPMI_REGULATOR_PIN_CTRL_HPM_SLEEP_B		0x10
> +#define SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT		0x20
> +
> +/*
> + * Used with enable parameters to specify that hardware default register values
> + * should be left unaltered.
> + */
> +#define SPMI_REGULATOR_DISABLE				0
> +#define SPMI_REGULATOR_ENABLE				1
> +#define SPMI_REGULATOR_USE_HW_DEFAULT			2
> +
> +/* Soft start strength of a voltage switch type regulator */
> +enum spmi_vs_soft_start_str {
> +	SPMI_VS_SOFT_START_STR_0P05_UA = 0,
> +	SPMI_VS_SOFT_START_STR_0P25_UA,
> +	SPMI_VS_SOFT_START_STR_0P55_UA,
> +	SPMI_VS_SOFT_START_STR_0P75_UA,
> +	SPMI_VS_SOFT_START_STR_HW_DEFAULT,
> +};
> +
> +/* Current limit of a boost type regulator */
> +enum spmi_boost_current_limit {
> +	SPMI_BOOST_CURRENT_LIMIT_300_MA = 0,
> +	SPMI_BOOST_CURRENT_LIMIT_600_MA,
> +	SPMI_BOOST_CURRENT_LIMIT_900_MA,
> +	SPMI_BOOST_CURRENT_LIMIT_1200_MA,
> +	SPMI_BOOST_CURRENT_LIMIT_1500_MA,
> +	SPMI_BOOST_CURRENT_LIMIT_1800_MA,
> +	SPMI_BOOST_CURRENT_LIMIT_2100_MA,
> +	SPMI_BOOST_CURRENT_LIMIT_2400_MA,
> +	SPMI_BOOST_CURRENT_LIMIT_HW_DEFAULT,
> +};
> +
> +/**
> + * struct spmi_regulator_init_data - spmi-regulator initialization data
> + * @pull_down_enable:       1 = Enable output pull down resistor when the
> + *			        regulator is disabled
> + *			    0 = Disable pull down resistor
> + *			    SPMI_REGULATOR_USE_HW_DEFAULT = do not modify
> + *			        pull down state
> + * @pin_ctrl_enable:        Bit mask specifying which hardware pins should be
> + *				used to enable the regulator, if any
> + *			    Value should be an ORing of
> + *				SPMI_REGULATOR_PIN_CTRL_ENABLE_* constants.  If
> + *				the bit specified by
> + *				SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT is
> + *				set, then pin control enable hardware registers
> + *				will not be modified.
> + * @pin_ctrl_hpm:           Bit mask specifying which hardware pins should be
> + *				used to force the regulator into high power
> + *				mode, if any
> + *			    Value should be an ORing of
> + *				SPMI_REGULATOR_PIN_CTRL_HPM_* constants.  If
> + *				the bit specified by
> + *				SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT is
> + *				set, then pin control mode hardware registers
> + *				will not be modified.
> + * @system_load:            Load in uA present on regulator that is not captured
> + *				by any consumer request
> + * @boost_current_limit:    This parameter sets the current limit of boost type
> + *				regulators.  Its value should be one of
> + *				SPMI_BOOST_CURRENT_LIMIT_*.  If its value is
> + *				SPMI_BOOST_CURRENT_LIMIT_HW_DEFAULT, then the
> + *				boost current limit will be left at its default
> + *				hardware value.
> + * @soft_start_enable:      1 = Enable soft start for LDO and voltage switch
> + *				type regulators so that output voltage slowly
> + *				ramps up when the regulator is enabled
> + *			    0 = Disable soft start
> + *			    SPMI_REGULATOR_USE_HW_DEFAULT = do not modify
> + *			        soft start state
> + * @vs_soft_start_strength: This parameter sets the soft start strength for
> + *				voltage switch type regulators.  Its value
> + *				should be one of SPMI_VS_SOFT_START_STR_*.  If
> + *				its value is SPMI_VS_SOFT_START_STR_HW_DEFAULT,
> + *				then the soft start strength will be left at its
> + *				default hardware value.
> + * @auto_mode_enable:       1 = Enable automatic hardware selection of regulator
> + *				mode (HPM vs LPM).  Auto mode is not available
> + *				on boost type regulators
> + *			    0 = Disable auto mode selection
> + *			    SPMI_REGULATOR_USE_HW_DEFAULT = do not modify
> + *			        auto mode state
> + * @bypass_mode_enable:     1 = Enable bypass mode for an LDO type regulator so
> + *				that it acts like a switch and simply outputs
> + *				its input voltage
> + *			    0 = Do not enable bypass mode
> + *			    SPMI_REGULATOR_USE_HW_DEFAULT = do not modify
> + *			        bypass mode state
> + * @hpm_enable:             1 = Enable high power mode (HPM), also referred to
> + *				as NPM.  HPM consumes more ground current than
> + *				LPM, but it can source significantly higher load
> + *				current.  HPM is not available on boost type
> + *				regulators.  For voltage switch type regulators,
> + *				HPM implies that over current protection and
> + *				soft start are active all the time.  This
> + *				configuration can be overwritten by changing the
> + *				regulator's mode dynamically.
> + *			    0 = Do not enable HPM
> + *			    SPMI_REGULATOR_USE_HW_DEFAULT = do not modify
> + *			        HPM state
> + */
> +struct spmi_regulator_init_data {
> +	int					pull_down_enable;
> +	unsigned				pin_ctrl_enable;
> +	unsigned				pin_ctrl_hpm;
> +	int					system_load;
> +	enum spmi_boost_current_limit		boost_current_limit;
> +	int					soft_start_enable;
> +	enum spmi_vs_soft_start_str		vs_soft_start_strength;
> +	int					auto_mode_enable;
> +	int					bypass_mode_enable;
> +	int					hpm_enable;
> +};
> +
> +/* These types correspond to unique register layouts. */
> +enum spmi_regulator_logical_type {
> +	SPMI_REGULATOR_LOGICAL_TYPE_SMPS,
> +	SPMI_REGULATOR_LOGICAL_TYPE_LDO,
> +	SPMI_REGULATOR_LOGICAL_TYPE_VS,
> +	SPMI_REGULATOR_LOGICAL_TYPE_BOOST,
> +	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS,
> +	SPMI_REGULATOR_LOGICAL_TYPE_BOOST_BYP,
> +	SPMI_REGULATOR_LOGICAL_TYPE_LN_LDO,
> +	SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS,
> +	SPMI_REGULATOR_LOGICAL_TYPE_ULT_HO_SMPS,
> +	SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO,
> +};
> +
> +enum spmi_regulator_type {
> +	SPMI_REGULATOR_TYPE_BUCK		= 0x03,
> +	SPMI_REGULATOR_TYPE_LDO			= 0x04,
> +	SPMI_REGULATOR_TYPE_VS			= 0x05,
> +	SPMI_REGULATOR_TYPE_BOOST		= 0x1b,
> +	SPMI_REGULATOR_TYPE_FTS			= 0x1c,
> +	SPMI_REGULATOR_TYPE_BOOST_BYP		= 0x1f,
> +	SPMI_REGULATOR_TYPE_ULT_LDO		= 0x21,
> +	SPMI_REGULATOR_TYPE_ULT_BUCK		= 0x22,
> +};
> +
> +enum spmi_regulator_subtype {
> +	SPMI_REGULATOR_SUBTYPE_GP_CTL		= 0x08,
> +	SPMI_REGULATOR_SUBTYPE_RF_CTL		= 0x09,
> +	SPMI_REGULATOR_SUBTYPE_N50		= 0x01,
> +	SPMI_REGULATOR_SUBTYPE_N150		= 0x02,
> +	SPMI_REGULATOR_SUBTYPE_N300		= 0x03,
> +	SPMI_REGULATOR_SUBTYPE_N600		= 0x04,
> +	SPMI_REGULATOR_SUBTYPE_N1200		= 0x05,
> +	SPMI_REGULATOR_SUBTYPE_N600_ST		= 0x06,
> +	SPMI_REGULATOR_SUBTYPE_N1200_ST		= 0x07,
> +	SPMI_REGULATOR_SUBTYPE_N300_ST		= 0x15,
> +	SPMI_REGULATOR_SUBTYPE_P50		= 0x08,
> +	SPMI_REGULATOR_SUBTYPE_P150		= 0x09,
> +	SPMI_REGULATOR_SUBTYPE_P300		= 0x0a,
> +	SPMI_REGULATOR_SUBTYPE_P600		= 0x0b,
> +	SPMI_REGULATOR_SUBTYPE_P1200		= 0x0c,
> +	SPMI_REGULATOR_SUBTYPE_LN		= 0x10,
> +	SPMI_REGULATOR_SUBTYPE_LV_P50		= 0x28,
> +	SPMI_REGULATOR_SUBTYPE_LV_P150		= 0x29,
> +	SPMI_REGULATOR_SUBTYPE_LV_P300		= 0x2a,
> +	SPMI_REGULATOR_SUBTYPE_LV_P600		= 0x2b,
> +	SPMI_REGULATOR_SUBTYPE_LV_P1200		= 0x2c,
> +	SPMI_REGULATOR_SUBTYPE_LV100		= 0x01,
> +	SPMI_REGULATOR_SUBTYPE_LV300		= 0x02,
> +	SPMI_REGULATOR_SUBTYPE_MV300		= 0x08,
> +	SPMI_REGULATOR_SUBTYPE_MV500		= 0x09,
> +	SPMI_REGULATOR_SUBTYPE_HDMI		= 0x10,
> +	SPMI_REGULATOR_SUBTYPE_OTG		= 0x11,
> +	SPMI_REGULATOR_SUBTYPE_5V_BOOST		= 0x01,
> +	SPMI_REGULATOR_SUBTYPE_FTS_CTL		= 0x08,
> +	SPMI_REGULATOR_SUBTYPE_FTS2p5_CTL	= 0x09,
> +	SPMI_REGULATOR_SUBTYPE_BB_2A		= 0x01,
> +	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL1	= 0x0d,
> +	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL2	= 0x0e,
> +	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL3	= 0x0f,
> +	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL4	= 0x10,
> +};
> +
> +enum spmi_common_regulator_registers {
> +	SPMI_COMMON_REG_DIG_MAJOR_REV		= 0x01,
> +	SPMI_COMMON_REG_TYPE			= 0x04,
> +	SPMI_COMMON_REG_SUBTYPE			= 0x05,
> +	SPMI_COMMON_REG_VOLTAGE_RANGE		= 0x40,
> +	SPMI_COMMON_REG_VOLTAGE_SET		= 0x41,
> +	SPMI_COMMON_REG_MODE			= 0x45,
> +	SPMI_COMMON_REG_ENABLE			= 0x46,
> +	SPMI_COMMON_REG_PULL_DOWN		= 0x48,
> +	SPMI_COMMON_REG_STEP_CTRL		= 0x61,
> +};
> +
> +enum spmi_ldo_registers {
> +	SPMI_LDO_REG_SOFT_START			= 0x4c,
> +};
> +
> +enum spmi_vs_registers {
> +	SPMI_VS_REG_OCP				= 0x4a,
> +	SPMI_VS_REG_SOFT_START			= 0x4c,
> +};
> +
> +enum spmi_boost_registers {
> +	SPMI_BOOST_REG_CURRENT_LIMIT		= 0x4a,
> +};
> +
> +enum spmi_boost_byp_registers {
> +	SPMI_BOOST_BYP_REG_CURRENT_LIMIT	= 0x4b,
> +};
> +
> +/* Used for indexing into ctrl_reg.  These are offets from 0x40 */
> +enum spmi_common_control_register_index {
> +	SPMI_COMMON_IDX_VOLTAGE_RANGE		= 0,
> +	SPMI_COMMON_IDX_VOLTAGE_SET		= 1,
> +	SPMI_COMMON_IDX_MODE			= 5,
> +	SPMI_COMMON_IDX_ENABLE			= 6,
> +};
> +
> +/* Common regulator control register layout */
> +#define SPMI_COMMON_ENABLE_MASK			0x80
> +#define SPMI_COMMON_ENABLE			0x80
> +#define SPMI_COMMON_DISABLE			0x00
> +#define SPMI_COMMON_ENABLE_FOLLOW_HW_EN3_MASK	0x08
> +#define SPMI_COMMON_ENABLE_FOLLOW_HW_EN2_MASK	0x04
> +#define SPMI_COMMON_ENABLE_FOLLOW_HW_EN1_MASK	0x02
> +#define SPMI_COMMON_ENABLE_FOLLOW_HW_EN0_MASK	0x01
> +#define SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK	0x0f
> +
> +/* Common regulator mode register layout */
> +#define SPMI_COMMON_MODE_HPM_MASK		0x80
> +#define SPMI_COMMON_MODE_AUTO_MASK		0x40
> +#define SPMI_COMMON_MODE_BYPASS_MASK		0x20
> +#define SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK	0x10
> +#define SPMI_COMMON_MODE_FOLLOW_HW_EN3_MASK	0x08
> +#define SPMI_COMMON_MODE_FOLLOW_HW_EN2_MASK	0x04
> +#define SPMI_COMMON_MODE_FOLLOW_HW_EN1_MASK	0x02
> +#define SPMI_COMMON_MODE_FOLLOW_HW_EN0_MASK	0x01
> +#define SPMI_COMMON_MODE_FOLLOW_ALL_MASK	0x1f
> +
> +/* Common regulator pull down control register layout */
> +#define SPMI_COMMON_PULL_DOWN_ENABLE_MASK	0x80
> +
> +/* LDO regulator current limit control register layout */
> +#define SPMI_LDO_CURRENT_LIMIT_ENABLE_MASK	0x80
> +
> +/* LDO regulator soft start control register layout */
> +#define SPMI_LDO_SOFT_START_ENABLE_MASK		0x80
> +
> +/* VS regulator over current protection control register layout */
> +#define SPMI_VS_OCP_OVERRIDE			0x01
> +#define SPMI_VS_OCP_NO_OVERRIDE			0x00
> +
> +/* VS regulator soft start control register layout */
> +#define SPMI_VS_SOFT_START_ENABLE_MASK		0x80
> +#define SPMI_VS_SOFT_START_SEL_MASK		0x03
> +
> +/* Boost regulator current limit control register layout */
> +#define SPMI_BOOST_CURRENT_LIMIT_ENABLE_MASK	0x80
> +#define SPMI_BOOST_CURRENT_LIMIT_MASK		0x07
> +
> +#define SPMI_VS_OCP_DEFAULT_MAX_RETRIES		10
> +#define SPMI_VS_OCP_DEFAULT_RETRY_DELAY_MS	30
> +#define SPMI_VS_OCP_FALL_DELAY_US		90
> +#define SPMI_VS_OCP_FAULT_DELAY_US		20000
> +
> +#define SPMI_FTSMPS_STEP_CTRL_STEP_MASK		0x18
> +#define SPMI_FTSMPS_STEP_CTRL_STEP_SHIFT	3
> +#define SPMI_FTSMPS_STEP_CTRL_DELAY_MASK	0x07
> +#define SPMI_FTSMPS_STEP_CTRL_DELAY_SHIFT	0
> +
> +/* Clock rate in kHz of the FTSMPS regulator reference clock. */
> +#define SPMI_FTSMPS_CLOCK_RATE		19200
> +
> +/* Minimum voltage stepper delay for each step. */
> +#define SPMI_FTSMPS_STEP_DELAY		8
> +
> +/*
> + * The ratio SPMI_FTSMPS_STEP_MARGIN_NUM/SPMI_FTSMPS_STEP_MARGIN_DEN is used to
> + * adjust the step rate in order to account for oscillator variance.
> + */
> +#define SPMI_FTSMPS_STEP_MARGIN_NUM	4
> +#define SPMI_FTSMPS_STEP_MARGIN_DEN	5
> +
> +/*
> + * This voltage in uV is returned by get_voltage functions when there is no way
> + * to determine the current voltage level.  It is needed because the regulator
> + * framework treats a 0 uV voltage as an error.
> + */
> +#define VOLTAGE_UNKNOWN 1
> +
> +/* VSET value to decide the range of ULT SMPS */
> +#define ULT_SMPS_RANGE_SPLIT 0x60
> +
> +/**
> + * struct spmi_voltage_range - regulator set point voltage mapping description
> + * @min_uV:		Minimum programmable output voltage resulting from
> + *			set point register value 0x00
> + * @max_uV:		Maximum programmable output voltage
> + * @step_uV:		Output voltage increase resulting from the set point
> + *			register value increasing by 1
> + * @set_point_min_uV:	Minimum allowed voltage
> + * @set_point_max_uV:	Maximum allowed voltage.  This may be tweaked in order
> + *			to pick which range should be used in the case of
> + *			overlapping set points.
> + * @n_voltages:		Number of preferred voltage set points present in this
> + *			range
> + * @range_sel:		Voltage range register value corresponding to this range
> + *
> + * The following relationships must be true for the values used in this struct:
> + * (max_uV - min_uV) % step_uV == 0
> + * (set_point_min_uV - min_uV) % step_uV == 0*
> + * (set_point_max_uV - min_uV) % step_uV == 0*
> + * n_voltages = (set_point_max_uV - set_point_min_uV) / step_uV + 1
> + *
> + * *Note, set_point_min_uV == set_point_max_uV == 0 is allowed in order to
> + * specify that the voltage range has meaning, but is not preferred.
> + */
> +struct spmi_voltage_range {
> +	int					min_uV;
> +	int					max_uV;
> +	int					step_uV;
> +	int					set_point_min_uV;
> +	int					set_point_max_uV;
> +	unsigned				n_voltages;
> +	u8					range_sel;
> +};
> +
> +/*
> + * The ranges specified in the spmi_voltage_set_points struct must be listed
> + * so that range[i].set_point_max_uV < range[i+1].set_point_min_uV.
> + */
> +struct spmi_voltage_set_points {
> +	struct spmi_voltage_range		*range;
> +	int					count;
> +	unsigned				n_voltages;
> +};
> +
> +struct spmi_regulator {
> +	struct regulator_desc			desc;
> +	struct device				*dev;
> +	struct delayed_work			ocp_work;
> +	struct regmap				*regmap;
> +	struct spmi_voltage_set_points		*set_points;
> +	enum spmi_regulator_logical_type	logical_type;
> +	int					ocp_enable;
> +	int					ocp_irq;
> +	int					ocp_count;
> +	int					ocp_max_retries;
> +	int					ocp_retry_delay_ms;
> +	int					system_load;
> +	int					hpm_min_load;
> +	int					slew_rate;
> +	ktime_t					vs_enable_time;
> +	u16					base;
> +	struct list_head			node;
> +};
> +
> +struct spmi_regulator_mapping {
> +	enum spmi_regulator_type		type;
> +	enum spmi_regulator_subtype		subtype;
> +	enum spmi_regulator_logical_type	logical_type;
> +	u32					revision_min;
> +	u32					revision_max;
> +	struct regulator_ops			*ops;
> +	struct spmi_voltage_set_points		*set_points;
> +	int					hpm_min_load;
> +};
> +
> +struct spmi_regulator_data {
> +	const char			*name;
> +	u16				base;
> +	const char			*supply;
> +	const char			*ocp;
> +	u16				force_type;
> +};
> +
> +#define VREG_MAP(_type, _subtype, _dig_major_min, _dig_major_max, \
> +		      _logical_type, _ops_val, _set_points_val, _hpm_min_load) \
> +	{ \
> +		.type		= SPMI_REGULATOR_TYPE_##_type, \
> +		.subtype	= SPMI_REGULATOR_SUBTYPE_##_subtype, \
> +		.revision_min	= _dig_major_min, \
> +		.revision_max	= _dig_major_max, \
> +		.logical_type	= SPMI_REGULATOR_LOGICAL_TYPE_##_logical_type, \
> +		.ops		= &spmi_##_ops_val##_ops, \
> +		.set_points	= &_set_points_val##_set_points, \
> +		.hpm_min_load	= _hpm_min_load, \
> +	}
> +
> +#define VREG_MAP_VS(_subtype, _dig_major_min, _dig_major_max) \
> +	{ \
> +		.type		= SPMI_REGULATOR_TYPE_VS, \
> +		.subtype	= SPMI_REGULATOR_SUBTYPE_##_subtype, \
> +		.revision_min	= _dig_major_min, \
> +		.revision_max	= _dig_major_max, \
> +		.logical_type	= SPMI_REGULATOR_LOGICAL_TYPE_VS, \
> +		.ops		= &spmi_vs_ops, \
> +	}
> +
> +#define VOLTAGE_RANGE(_range_sel, _min_uV, _set_point_min_uV, \
> +			_set_point_max_uV, _max_uV, _step_uV) \
> +	{ \
> +		.min_uV			= _min_uV, \
> +		.max_uV			= _max_uV, \
> +		.set_point_min_uV	= _set_point_min_uV, \
> +		.set_point_max_uV	= _set_point_max_uV, \
> +		.step_uV		= _step_uV, \
> +		.range_sel		= _range_sel, \
> +	}
> +
> +#define DEFINE_SET_POINTS(name) \
> +struct spmi_voltage_set_points name##_set_points = { \
> +	.range	= name##_ranges, \
> +	.count	= ARRAY_SIZE(name##_ranges), \
> +}
> +
> +/*
> + * These tables contain the physically available PMIC regulator voltage setpoint
> + * ranges.  Where two ranges overlap in hardware, one of the ranges is trimmed
> + * to ensure that the setpoints available to software are monotonically
> + * increasing and unique.  The set_voltage callback functions expect these
> + * properties to hold.
> + */
> +static struct spmi_voltage_range pldo_ranges[] = {
> +	VOLTAGE_RANGE(2,  750000,  750000, 1537500, 1537500, 12500),
> +	VOLTAGE_RANGE(3, 1500000, 1550000, 3075000, 3075000, 25000),
> +	VOLTAGE_RANGE(4, 1750000, 3100000, 4900000, 4900000, 50000),
> +};
> +
> +static struct spmi_voltage_range nldo1_ranges[] = {
> +	VOLTAGE_RANGE(2,  750000,  750000, 1537500, 1537500, 12500),
> +};
> +
> +static struct spmi_voltage_range nldo2_ranges[] = {
> +	VOLTAGE_RANGE(0,  375000,       0,       0, 1537500, 12500),
> +	VOLTAGE_RANGE(1,  375000,  375000,  768750,  768750,  6250),
> +	VOLTAGE_RANGE(2,  750000,  775000, 1537500, 1537500, 12500),
> +};
> +
> +static struct spmi_voltage_range nldo3_ranges[] = {
> +	VOLTAGE_RANGE(0,  375000,  375000, 1537500, 1537500, 12500),
> +	VOLTAGE_RANGE(1,  375000,       0,       0, 1537500, 12500),
> +	VOLTAGE_RANGE(2,  750000,       0,       0, 1537500, 12500),
> +};
> +
> +static struct spmi_voltage_range ln_ldo_ranges[] = {
> +	VOLTAGE_RANGE(1,  690000,  690000, 1110000, 1110000, 60000),
> +	VOLTAGE_RANGE(0, 1380000, 1380000, 2220000, 2220000, 120000),
> +};
> +
> +static struct spmi_voltage_range smps_ranges[] = {
> +	VOLTAGE_RANGE(0,  375000,  375000, 1562500, 1562500, 12500),
> +	VOLTAGE_RANGE(1, 1550000, 1575000, 3125000, 3125000, 25000),
> +};
> +
> +static struct spmi_voltage_range ftsmps_ranges[] = {
> +	VOLTAGE_RANGE(0,       0,  350000, 1275000, 1275000,  5000),
> +	VOLTAGE_RANGE(1,       0, 1280000, 2040000, 2040000, 10000),
> +};
> +
> +static struct spmi_voltage_range ftsmps2p5_ranges[] = {
> +	VOLTAGE_RANGE(0,   80000,  350000, 1355000, 1355000,  5000),
> +	VOLTAGE_RANGE(1,  160000, 1360000, 2200000, 2200000, 10000),
> +};
> +
> +static struct spmi_voltage_range boost_ranges[] = {
> +	VOLTAGE_RANGE(0, 4000000, 4000000, 5550000, 5550000, 50000),
> +};
> +
> +static struct spmi_voltage_range boost_byp_ranges[] = {
> +	VOLTAGE_RANGE(0, 2500000, 2500000, 5200000, 5650000, 50000),
> +};
> +
> +static struct spmi_voltage_range ult_lo_smps_ranges[] = {
> +	VOLTAGE_RANGE(0,  375000,  375000, 1562500, 1562500, 12500),
> +	VOLTAGE_RANGE(1,  750000,       0,       0, 1525000, 25000),
> +};
> +
> +static struct spmi_voltage_range ult_ho_smps_ranges[] = {
> +	VOLTAGE_RANGE(0, 1550000, 1550000, 2325000, 2325000, 25000),
> +};
> +
> +static struct spmi_voltage_range ult_nldo_ranges[] = {
> +	VOLTAGE_RANGE(0,  375000,  375000, 1537500, 1537500, 12500),
> +};
> +
> +static struct spmi_voltage_range ult_pldo_ranges[] = {
> +	VOLTAGE_RANGE(0, 1750000, 1750000, 3337500, 3337500, 12500),
> +};
> +
> +static DEFINE_SET_POINTS(pldo);
> +static DEFINE_SET_POINTS(nldo1);
> +static DEFINE_SET_POINTS(nldo2);
> +static DEFINE_SET_POINTS(nldo3);
> +static DEFINE_SET_POINTS(ln_ldo);
> +static DEFINE_SET_POINTS(smps);
> +static DEFINE_SET_POINTS(ftsmps);
> +static DEFINE_SET_POINTS(ftsmps2p5);
> +static DEFINE_SET_POINTS(boost);
> +static DEFINE_SET_POINTS(boost_byp);
> +static DEFINE_SET_POINTS(ult_lo_smps);
> +static DEFINE_SET_POINTS(ult_ho_smps);
> +static DEFINE_SET_POINTS(ult_nldo);
> +static DEFINE_SET_POINTS(ult_pldo);
> +
> +static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
> +				 int len)
> +{
> +	return regmap_bulk_read(vreg->regmap, vreg->base + addr, buf, len);
> +}
> +
> +static inline int spmi_vreg_write(struct spmi_regulator *vreg, u16 addr,
> +				u8 *buf, int len)
> +{
> +	return regmap_bulk_write(vreg->regmap, vreg->base + addr, buf, len);
> +}
> +
> +static int spmi_vreg_update_bits(struct spmi_regulator *vreg, u16 addr, u8 val,
> +		u8 mask)
> +{
> +	return regmap_update_bits(vreg->regmap, vreg->base + addr, mask, val);
> +}
> +
> +static int spmi_regulator_common_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
> +	u8 reg;
> +
> +	reg = spmi_vreg_read(vreg, SPMI_COMMON_REG_ENABLE, &reg, 1);

        ^^^                                                 ^^^
You probably did not mean to use reg in both places.

Most other places the return value of spmi_vreg_read() is ignored.


> +
> +	return (reg & SPMI_COMMON_ENABLE_MASK) == SPMI_COMMON_ENABLE;
> +}

< snip >

I did not read the driver in detail, just happened to notice the above detail.

-Frank
