From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Dec 2016 12:32:33 +0000
Subject: [PATCH linux v1 2/4] drivers: misc: Character device driver for
 seven segment display
In-Reply-To: <1481702104-8617-3-git-send-email-jaghu@google.com>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
 <1481702104-8617-3-git-send-email-jaghu@google.com>
Message-ID: <20161214123233.GF14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 11:55:02PM -0800, Jaghathiswari Rankappagounder Natarajan wrote:
> +int seven_seg_setup_cdev(struct seven_seg_disp_dev *disp_dev,
> +	void (*update_disp_data)(struct device *, u16 data))
> +{
> +	struct device *dev;
> +	int err;
> +
> +	dev = device_create(seven_seg_disp_class, &disp_dev->parent,
> +			seven_seg_devno,
> +			NULL, "seven_seg_disp_val");
> +	if (dev == NULL)
> +		return -1;

Do not use return -1 in kernel code.

> +	disp_dev->dev = dev;
> +	disp_dev->update_seven_seg_data = update_disp_data;
> +	disp_dev->disp_data_valid = false;
> +
> +	cdev_init(&disp_dev->cdev, &seven_seg_disp_fops);
> +	err = cdev_add(&disp_dev->cdev, seven_seg_devno, 1);
> +	if (err)
> +		device_destroy(seven_seg_disp_class, seven_seg_devno);
> +	return err;
> +}
> +
> +static int __init seven_seg_disp_init(void)
> +{
> +	if (alloc_chrdev_region(&seven_seg_devno, 0, 1, "disp_state") < 0)
> +		return -1;

Do not use return -1 in kernel code.

> +
> +	seven_seg_disp_class = class_create(THIS_MODULE, "disp_state");
> +	if (seven_seg_disp_class == NULL)
> +		goto unreg_chrdev;
> +
> +unreg_chrdev:
> +	unregister_chrdev_region(seven_seg_devno, 1);
> +	return -1;

Do not use return -1 in kernel code.

(Look up what an errno value of '1' means.  Negative values returned from
functions are interpreted as negated errno values.)

Always propagate error codes, or select an appropriate errno value to
return.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
