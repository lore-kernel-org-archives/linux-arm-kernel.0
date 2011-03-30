From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 30 Mar 2011 14:45:16 +0530
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <201103111628.57549.arnd@arndb.de>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-2-git-send-email-subhasish@mistralsolutions.com>
	<201103111628.57549.arnd@arndb.de>
Message-ID: <9E9CA0E03AAF4C9AA18DDD7CDE5168A8@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I am using a .setup to initialize pin mux etc. To use the mfd_cells directly 
should I
use .enable and .disable of the mfd_cells instead of the .setup.

>> +static int pruss_mfd_add_devices(struct platform_device *pdev)
>> +{
>> + struct da8xx_pruss_devices *dev_data = pdev->dev.platform_data;
>> + struct device *dev = &pdev->dev;
>> + struct mfd_cell cell;
>> + u32 err, count;
>> +
>> + for (count = 0; dev_data[count].dev_name != NULL; count++) {
>> + memset(&cell, 0, sizeof(struct mfd_cell));
>> + cell.id = count;
>> + cell.name = dev_data[count].dev_name;
>> + cell.platform_data = dev_data[count].pdata;
>> + cell.data_size = dev_data[count].pdata_size;
>> + cell.resources = dev_data[count].resources;
>> + cell.num_resources = dev_data[count].num_resources;
>> +
>> + err = mfd_add_devices(dev, 0, &cell, 1, NULL, 0);
>> + if (err) {
>> + dev_err(dev, "cannot add mfd cells\n");
>> + return err;
>> + }
>> + dev_info(dev, "mfd: added %s device\n",
>> + dev_data[count].dev_name);
>> + }
>> +
>> + return err;
>> +}
>
> This would get much simpler if you just replaced the da8xx_pruss_devices
> array with an mfd_cell array. 
