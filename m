From: dan.sneddon@gmail.com (Dan Sneddon)
Date: Wed, 22 Feb 2017 14:08:10 -0700
Subject: SPI fix needed in kernel (DragonBoard 410c)
In-Reply-To: <6857de0f674548d09ecad023211b3d1f@NASANEXM01D.na.qualcomm.com>
References: <6857de0f674548d09ecad023211b3d1f@NASANEXM01D.na.qualcomm.com>
Message-ID: <CACceFXeoV5DjekfDSbEhGOKrztwqSa9jLQ-pknCVaXQMkPOyqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>

> I have been using SPI on the Dragonboard 410c and found some issues. Specifically Hardware Chip Select is not working on the Debian kernel from Linaro (Build #202). It turns out that the SPI_IO_C_MX_CS_MODE bit in the SPI_IO_CONTROL register needs to be set. My 'patch' is very simplistic, and I certainly haven't tested it against all cases of DMA/non-DMA and various transfer lengths, but it does fix my one case.

Since the spi-qup driver used the generic spi transfer_one_message I would keep
the CS pin as a GPIO function rather than the blsp_spi5 function and let the
framework assert/deassert it.

> First I changed only the dtsi files to enable a spidev driver with hardware chip select (and set the drive strength correctly):
>
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index f6d2bcb6dbd1..874150a412a2 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -208,8 +208,14 @@
>                 /* On Low speed expansion */
>                         label = "LS-SPI0";
> +/*                        cs-gpios = <&msmgpio 18 0> */
>                         status = "okay";
> +                       spidev at 0 {
> +                               compatible = "spidev";
> +                               spi-max-frequency = <100000>;
> +                               reg = <0>;
> +                       };
>                 };
>
>                 leds {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> index 899f2b28a9c9..1c22b4414edf 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> @@ -208,7 +208,7 @@
>                         pins = "gpio16", "gpio17", "gpio19";
>                 };
>                 pinmux_cs {
> -                       function = "gpio";
> +                       function = "blsp_spi5";
>                         pins = "gpio18";
>                 };
>                 pinconf {
> @@ -218,7 +218,7 @@
>                 };
>                 pinconf_cs {
>                         pins = "gpio18";
> -                       drive-strength = <2>;
> +                       drive-strength = <12>;
>                         bias-disable;
>                         output-high;
>                 };
>
> Here is what my 3-byte transactions end up looking like (Yellow - Clock, Green ? Data Out, Magenta- Chip Select) :
>
>
> As you can see the chip select is going high between each byte of data. This violates the SPI protocol and I am unable to transfer data from the device.
>
> Next I changed the SPI driver:
>
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 68f95acf7971..aed71ef7e3fd 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -580,6 +580,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
>         else
>                 control &= ~SPI_IO_C_CLK_IDLE_HIGH;
>
> +       config |= SPI_IO_C_MX_CS_MODE;
>         writel_relaxed(control, controller->base + SPI_IO_CONTROL);
>
>         config = readl_relaxed(controller->base + SPI_CONFIG);
> @@ -928,7 +929,7 @@ static int spi_qup_probe(struct platform_device *pdev)
>                         base + QUP_ERROR_FLAGS_EN);
>
>         writel_relaxed(0, base + SPI_CONFIG);
> -       writel_relaxed(SPI_IO_C_NO_TRI_STATE, base + SPI_IO_CONTROL);
> +       writel_relaxed(SPI_IO_C_NO_TRI_STATE|SPI_IO_C_MX_CS_MODE, base + SPI_IO_CONTROL);
>
>         ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
>                                IRQF_TRIGGER_HIGH, pdev->name, controller);
>
> This sets the SPI_IO_C_MX_MODE bit in the SPI_IO_CONTROL register. Once this is done the SPI transactions look like this:
>
>
>
> As you can see the Chip Select stays low for the entire transaction and the device successfully transfers data.
>
> I have NOT tested this change very carefully and I have not covered all of the possible cases (different processors, DMA vs non-DMA, etc). This ?patch? is only known to work with MSM8916/APQ8016, and only with 3-byte transfers at 100kHz.
>
> Lawrence King
> Senior Staff Eng./mgr
> Qualcomm Canada Inc.
> Suite 100, 105 Commerce Valley Drive West
> Markham Ontario Canada L3T 7W3
> +1(905)482-5403 ? office
> +1(416)627-7302 - cell
>
>
> -----Original Message-----
> From: Andy Gross [mailto:andy.gross at linaro.org]
> Sent: Tuesday, February 14, 2017 4:21 PM
> To: King, Lawrence <lking@qti.qualcomm.com>
> Cc: Fradkin, Alex <alexf@qti.qualcomm.com>; nicolas.dechesne at linaro.org; Bjorn Andersson <bjorn.andersson@linaro.org>; Srinivas Kandagatla <srinivas.kandagatla@linaro.org>; Elster, Constantine <celster@qti.qualcomm.com>; Sedlak Grinbaum, Anna Hanna <c_asedla@qti.qualcomm.com>
> Subject: Re: SPI fix needed in kernel
>
> On 14 February 2017 at 14:37, King, Lawrence <lking@qti.qualcomm.com> wrote:
>> Dear All:
>>
>>
>>
>> I am back on the case of the SPI driver for the APQ8016. This time I
>> am using the 'latest' build #202 of Debian.
>>
>>
>>
>> In order to get the hardware Chip Select to operate correctly I tried
>> the same 'trick' I had been doing before, I added the line of code
>> that sets the SPI_IO_C_MX_CS_MODE bit in the SPI_IO_CONTROL register
>> in the function spi_qup_io_config(). But to my annoyance it didn't fix the problem.
>
> Looking at the spi_qsd.c in 3.18, there is a pretty complex dance involved with deciding whether or not to set the MX_CS.  Probably because of the weird transfer coalescing they do.
>
> In addition, they are doing a FORCE_CS when the spi core calls set_cs.
>
>>
>>
>> In order to get hardware CS control to work I also had to change the
>> SPI_IO_CONTROL in the function spi_qup_probe()  from
>>
>> writel_relaxed(SPI_IO_C_NO_TRI_STATE, base + SPI_IO_CONTROL);
>>
>> to
>>
>> writel_relaxed(SPI_IO_C_NO_TRI_STATE|SPI_IO_C_MX_CS_MODE, base +
>> SPI_IO_CONTROL);
>>
>>
>>
>> I would have thought that the spi_qup_io_config() ran after the
>> spi_qup_probe(), but this is apparently not the case.
>
> The spi_qup_io_config() is run every time there is a spi transaction.
> It is called from spi_qup_transfer_one().
>
>>
>>
>> Why is the SPI_IO_C_MX_CS_MODE bit still not set in the code? Without
>> this bit set hardware CS will never work properly. Now that you have
>> separated out the old controller from the new controller with the
>> qup_v1 flag it should be easy?
>
> I presume no one sent a patch to the mailing list for this.  If you do, please CC linux-msm.  But due to the details above, it might be a good idea to ask someone in Boulder about all the different states where you need some flags set and others not set if you want to use auto chip select.  Sagar Dharia might be a good starting point.
>
>
> Regards,
>
> Andy
