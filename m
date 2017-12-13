From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Dec 2017 15:01:55 -0800
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <1513189818-7384-4-git-send-email-timur@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
Message-ID: <20171213230155.GS7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, Timur Tabi wrote:
> Newer versions of the firmware for the Qualcomm Datacenter Technologies
> QDF2400 restricts access to a subset of the GPIOs on the TLMM.  To
> prevent older kernels from accidentally accessing the restricted GPIOs,
> we change the ACPI HID for the TLMM block from QCOM8001 to QCOM8002,
> and introduce a new property "gpios".  This property is an array of
> specific GPIOs that are accessible.  When an older kernel boots on
> newer (restricted) firmware, it will fail to probe.
> 
> To implement the sparse GPIO map, we register all of the GPIOs, but set
> the pin count for the unavailable GPIOs to zero.  The pinctrl-msm
> driver will block those unavailable GPIOs from being accessed.
> 
> To allow newer kernels to support older firmware, the driver retains
> support for QCOM8001.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 134 +++++++++++++++++++++++++--------
>  1 file changed, 103 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> index bb3ce5c3e18b..deb08e08e86d 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> @@ -38,68 +38,139 @@
>  /* maximum size of each gpio name (enough room for "gpioXXX" + null) */
>  #define NAME_SIZE	8
>  
> +enum {
> +	QDF2XXX_V1,
> +	QDF2XXX_V2,
> +};
> +
>  static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
>  {
> +	const struct acpi_device_id *id;
>  	struct pinctrl_pin_desc *pins;
>  	struct msm_pingroup *groups;
>  	char (*names)[NAME_SIZE];
>  	unsigned int i;
>  	u32 num_gpios;
> +	unsigned int avail_gpios; /* The number of GPIOs we support */
> +	u16 *gpios; /* An array of supported GPIOs */
>  	int ret;
>  
>  	/* Query the number of GPIOs from ACPI */
>  	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
>  	if (ret < 0) {
> -		dev_warn(&pdev->dev, "missing num-gpios property\n");
> +		dev_err(&pdev->dev, "missing 'num-gpios' property\n");
>  		return ret;
>  	}
> -
>  	if (!num_gpios || num_gpios > MAX_GPIOS) {

Given that we have MAX_GPIOS, it would be better to declare a
bitmap of available gpios of that size on the stack and then
iterate through the bitmap and set bits for the available ones.
In the QCOM8001 case, that would be setting all bits up to
num_gpios, and in the QCOM8002 case it would be iterating through
the list of gpios from the DSD property and setting the bit for
that gpio number.  This avoids explicitly allocating a list of
numbers that is freed almost immediately. Instead we just stack
256 / sizeof(unsigned long) words and set bits.

Hopefully we could lift the same logic into the core pinctrl msm
driver for usage on non-ACPI systems.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
