From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 17 Nov 2015 16:32:50 +0000
Subject: [Xen-devel] [PATCH 05/13] Xen: ARM: Add support for mapping
 platform device mmio
In-Reply-To: <1447754231-7772-6-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-6-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B56B2.4030901@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 09:57, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a bus_notifier for platform bus device in order to map the device
> mmio regions when DOM0 booting with ACPI.
[...]
> --- /dev/null
> +++ b/drivers/xen/platform.c
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (c) 2015, Linaro Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> + * Place - Suite 330, Boston, MA 02111-1307 USA.

"You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>."

> + *
> + * Author: Shannon Zhao <shannon.zhao@linaro.org>

Omit this since it just becomes stale and git will know the correct
authorship.

> +static int xen_platform_notifier(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(data);
> +	int r = 0;
> +
> +	if (!acpi_disabled && (action == BUS_NOTIFY_ADD_DEVICE))
> +		r = xen_map_platform_device_mmio(pdev);

Why even register the notifier if acpi_disabled?

> +
> +	if (r)
> +	{
> +		dev_err(&pdev->dev, "Failed to add_to_physmap device (%s) mmio!\n",
> +			pdev->name);
> +		return NOTIFY_OK;

Return NOTIFY_BAD here?  The device will be unusable.

> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block platform_device_nb = {
> +	.notifier_call = xen_platform_notifier,
> +};
> +
> +static int __init register_xen_platform_notifier(void)
> +{
> +	if (!xen_initial_domain())
> +		return 0;
> +
> +	return bus_register_notifier(&platform_bus_type, &platform_device_nb);

Why only platform busses?  What about PCI devices?  Where will they get
added to dom0's physmap?

David
