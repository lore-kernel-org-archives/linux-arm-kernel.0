From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 27 Feb 2012 15:26:38 +0100
Subject: [PATCH v5 2/3] arm:davinci: move emif driver to mfd framework
In-Reply-To: <1330005504-25321-3-git-send-email-prakash.pm@ti.com>
References: <y>
 <1330005504-25321-3-git-send-email-prakash.pm@ti.com>
Message-ID: <20120227142638.GN27687@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prakash,

On Thu, Feb 23, 2012 at 07:28:23PM +0530, Manjunathappa, Prakash wrote:
> +static int __init davinci_aemif_probe(struct platform_device *pdev)
> +{
> +	struct davinci_aemif_devices *davinci_aemif_devices =
> +		pdev->dev.platform_data;
> +	struct platform_device *devices;
> +	struct mfd_cell *cells;
> +	int i, ret, count;
> +
> +	devices = davinci_aemif_devices->devices;
> +
> +	cells = kzalloc(sizeof(struct mfd_cell) *
> +			davinci_aemif_devices->num_devices, GFP_KERNEL);
> +
> +	for (i = 0, count = 0; i < davinci_aemif_devices->num_devices; i++) {
> +		if (!strcmp(devices[i].name, "davinci_nand")) {
> +			cells[count].pdata_size =
> +				sizeof(struct davinci_nand_pdata);
> +		} else if (!strcmp(devices[i].name, "physmap-flash")) {
> +			cells[count].pdata_size =
> +				sizeof(struct physmap_flash_data);
> +		} else
> +			continue;
> +
> +		cells[count].name = devices[i].name;
> +		cells[count].platform_data =
> +			devices[i].dev.platform_data;
> +		cells[count].id = devices[i].id;
> +		cells[count].resources = devices[i].resource;
> +		cells[count].num_resources = devices[i].num_resources;
> +		count++;
> +	}
So it seems you're passing a platform devices array through your mfd aemif
platform data pointer. And from what I can see, it's mostly a 1 entry array
(for the NAND case) or a 2 entries array (for the NAND and NOR case).
In that case, adding an MFD driver in the middle brings basically nothing but
confusion and overhead (and 200+ lines of code).
So unless someone explains to me how this is doing any good to the kernel in
general, I'm not going to take this patchset.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
