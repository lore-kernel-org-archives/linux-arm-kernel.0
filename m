From: rjui@broadcom.com (Ray Jui)
Date: Sat, 17 Jan 2015 16:30:33 -0800
Subject: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150117224021.GA26493@n2100.arm.linux.org.uk>
References: <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de> <54B98C18.4080807@broadcom.com>
 <20150117160113.GA22880@pengutronix.de> <54BABEE9.8070801@broadcom.com>
 <20150117201849.GC22880@pengutronix.de> <54BACB66.6040909@broadcom.com>
 <20150117211017.GD22880@pengutronix.de> <54BAD391.9080909@broadcom.com>
 <20150117224021.GA26493@n2100.arm.linux.org.uk>
Message-ID: <54BAFEA9.9040900@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/17/2015 2:40 PM, Russell King - ARM Linux wrote:
> On Sat, Jan 17, 2015 at 01:26:41PM -0800, Ray Jui wrote:
>> 	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
>>
>> 	/* disable all interrupts */
>> 	writel(0, iproc_i2c->base + IE_OFFSET);
>>
>> 	if (!time_left && !atomic_read(&iproc_i2c->transfer_is_successful)) {
> 
> Why are you using atomic_read() here?
> 
transfer_is_successful 1) will be reset to 0 in this function (before
kick start the I2C transfer), 2) will be set to 1 in the ISR (to signal
completion of the I2C transfer), and 3) will be checked in this function
here. I thought that means I should declare it volatile, because it can
be modified in both the process context and interrupt context (and I use
atomic because I remember Linux checkpatch warns against using volatile)?
