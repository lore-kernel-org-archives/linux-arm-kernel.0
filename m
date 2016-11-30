From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 30 Nov 2016 10:59:41 -0800
Subject: [PATCH v3 3/3] fpga manager: Add cyclone-ps-spi driver for Altera
 FPGAs
In-Reply-To: <alpine.DEB.2.10.1611301122470.2617@atull-730U3E-740U3E>
References: <cover.1480467185.git.stillcompiling@gmail.com>
 <e193572d7746e6f6b8666da7ac0f54031fed5214.1480467185.git.stillcompiling@gmail.com>
 <alpine.DEB.2.10.1611301122470.2617@atull-730U3E-740U3E>
Message-ID: <6989b2ee-9caf-81b3-2328-9d4e287794cb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On 11/30/2016 09:45 AM, atull wrote:
> On Wed, 30 Nov 2016, Joshua Clayton wrote:
>
> Hi Clayton,
>
> I just have a few minor one line changes below.  Only one
> is operational, I should have caught that earlier.
>
Thanks for the speedy review.
>> +};
>> +MODULE_DEVICE_TABLE(of, of_ef_match);
>> +
>> +static enum fpga_mgr_states cyclonespi_state(struct fpga_manager *mgr)
>> +{
>> +	return mgr->state;
>> +}
> This function gets called once to initialize mgr->state in
> fpga_mgr_register().  So it should at least return the state the FPGA
> is at then.  If it is unknown, it can just return
> FPGA_MGR_STATE_UNKNOWN.
>
I guess I didn't understand the purpose of this function.
The driver has access to the status pin at this phase, so I can return
FPGA_MGR_STATE_UNKNOWN or FPGA_MGR_STATE_RESET depending
on the state of that pin.

>> +
>> +static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
>> +				 const char *buf, size_t count)
> Minor, but please fix the indentation of 'const' to match that of
> 'struct' above.  checkpatch.pl is probably issuing warnings
> about that.
I double checked. The indentation is correct here. It only has
The appearance of being off by one due to the diff format.
>> +{
>> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
>> +	int i;
>> +
>> +	if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
>> +		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	gpiod_set_value(conf->config, 0);
>> +	usleep_range(FPGA_RESET_TIME, FPGA_RESET_TIME + 20);
>> +	if (gpiod_get_value(conf->status) == 1) {
>> +		dev_err(&mgr->dev, "Status pin should be low.\n");
>> +		return -EIO;
>> +	}
>> +
>> +	gpiod_set_value(conf->config, 1);
>> +	for (i = 0; i < (FPGA_MAX_DELAY / FPGA_MIN_DELAY); i++) {
>> +		usleep_range(FPGA_MIN_DELAY, FPGA_MIN_DELAY + 20);
>> +		if (gpiod_get_value(conf->status))
>> +			return 0;
>> +	}
>> +
>> +	dev_err(&mgr->dev, "Status pin not ready.\n");
>> +	return -EIO;
>> +}
>> +
>> +static void rev_buf(void *buf, size_t len)
>> +{
>> +	u32 *fw32 = (u32 *)buf;
>> +	const u32 *fw_end = (u32 *)(buf + len);
>> +
>> +	/* set buffer to lsb first */
>> +	while (fw32 < fw_end) {
>> +		*fw32 = bitrev8x4(*fw32);
>> +		fw32++;
>> +	}
>> +}
>> +
>> +static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
>> +			    size_t count)
> Please fix alignment here also.
Same as above. Indentation is OK.


I'll get a v4 turned around soon.
Thanks,
Joshua
