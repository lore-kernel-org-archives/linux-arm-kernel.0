From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 10:19:53 +0100
Subject: [PATCH v2 00/25] add support for AXP20X and AXP22X power supply
 drivers
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Message-ID: <20170127091953.i3nhfsekzycmlefu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 09:54:33AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
> information and data of the various power supplies they support such as
> ACIN, battery and VBUS. For example, they expose the current battery
> voltage, charge or discharge, as well as ACIN and VBUS current voltages
> and currents, internal PMIC temperature and ADC on 2 different GPIOs
> when in the right mode (for the AXP209 only).
> 
> The ACIN power supply driver is added by this patch. The AXP20X and
> AXP22X can both read the status and the "usability" of the power supply
> but only the AXP209 will be able to tell the current current and voltage
> of the power supply by reading ADC channels. It is simply not supported
> by the AXP22X PMICs.
> 
> The battery power supply driver is also added by this patch. The AXP20X
> and AXP22X share most of their behaviour but have slight variations. The
> allowed target voltages for battery charging are not the same, the
> AXP22X PMIC are able to tell if the battery percentage computed by the
> PMIC is trustworthy and they have different formulas for computing max
> current for battery power supply. The driver is able to give the current
> voltage and current of the battery (be it charging or discharging), the
> maximal and minimal voltage and maximal current allowed for the battery,
> whether the battery is present and usable and its capacity. It will get
> the battery current current and voltage by reading the ADC channels. The
> PMIC allows maximal voltages (4.36V for AXP20X and 4.22V and 4.24V for
> AXP22X) that should not be used with Lithium-based batteries and since
> this PMIC is supposed to be used with Lithium-based batteries, they have
> been disabled. The values returned by the ADC driver are multipled by
> 1000 to scale from the mV returned by the ADC to the uV expected by the
> power supply framework.
> 
> This series of patch adds DT bindings for ACIN power supply, ADC and
> battery power supply drivers for AXP20X and AXP22X PMICs and their
> documentation. It also enables the supported power supplies for the
> Nextthing Co. CHIP and Sinlinx SinA33 boards.
> 
> The different drivers are also added to the MFD cells of the AXP20X and
> AXP22X cells and the writeable and volatile regs updated to work with
> the newly added drivers.
> 
> VBUS driver has intentionally not been modified to use the ADC channels
> because a DT binding already exists for this driver. Migrating the
> driver would mean to add an iio_map to map the ADC channels to the VBUS
> driver (so we can use iio_channel_get and iio_read_channel_processed
> functions). This slightly complexifies the VBUS driver only for
> "cosmetic" changes. Feel free to give your two cents on the matter.
> 
> This series of patch is based on a previous upstreaming attempt done by
> Bruno Pr?mont few months ago. It differs in three points: the ADC
> driver does not tell the battery temperature (TS_IN) as I do not have a
> board to test it with, it does not tell the instantaneous battery power
> as it returns crazy values for me and finally no support for OCV curves
> for the battery.
> 
> You can test these patches from this repo and branch:
> https://github.com/QSchulz/linux/tree/axp2xx_adc_batt_ac_v2

For the whole serie,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/d7c6225b/attachment.sig>
