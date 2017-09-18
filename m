From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Mon, 18 Sep 2017 15:04:34 -0500
Subject: [[RESEND]PATCHv6 2/2] i2c: altera: Add Altera I2C Controller
 driver
In-Reply-To: <20170913205038.ndlkaivkdgxa3ee2@ninjato>
References: <1505164640-26413-1-git-send-email-thor.thayer@linux.intel.com>
 <1505164640-26413-2-git-send-email-thor.thayer@linux.intel.com>
 <20170913205038.ndlkaivkdgxa3ee2@ninjato>
Message-ID: <3f9fe0a6-0e8d-7038-28e6-eacc6ed2e7ad@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2017 03:50 PM, Wolfram Sang wrote:
> On Mon, Sep 11, 2017 at 04:17:20PM -0500, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add driver support for the Altera I2C Controller. The I2C
>> controller is soft IP for use in FPGAs.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
> 
> Applied to for-next (will be in v4.14), thanks!
> 
>> +	if (finish) {
>> +		/* Wait for the Core to finish */
>> +		ret = readl_poll_timeout_atomic(idev->base + ALTR_I2C_STATUS,
> 
> I wonder a bit about polling in an interrupt handler (maybe threaded
> irqs?) but we can fix that later, I think.
> 

Yes, based on your previous feedback, I changed to a threaded IRQ as 
shown below. The altr_i2c_isr_quick wakes up this IRQ handler if the 
status is non-zero.

+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, altr_i2c_isr_quick,
+					altr_i2c_isr, IRQF_ONESHOT,
+					pdev->name, idev);

Thanks for the review and applying the patch!
