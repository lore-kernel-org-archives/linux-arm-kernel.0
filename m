From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Thu, 3 Mar 2011 16:42:58 +0530
Subject: [PATCH v2 02/13] da850: pruss platform specific additions.
In-Reply-To: <4102429DCB2B4B47A4F51ED0B9A62E2B@subhasishg>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-3-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF35DEE@dbde02.ent.ti.com>
	<4102429DCB2B4B47A4F51ED0B9A62E2B@subhasishg>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C008825@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Subhasish Ghosh [mailto:subhasish at mistralsolutions.com]
> Sent: Tuesday, March 01, 2011 12:29 PM
> Hello,
> 
> Can we not have the PRU UIO also as a part of the MFD framework.
> I know that the UIO is not really a device, but I feel its incorrect to
> register the same device twice.
> Instead we can have a single entry as the MFD framework and the UIO, as a
> child device, based upon the MFD driver APIs.
> 
> All that we need to do is add an entry into the da8xx_pruss_devices
> structure
> and the MFD driver will do the rest to get the UIO probe called.
> 
Well I see the need for MFD for in-kernel PRUSS based drivers like UART/CAN, 
but UIO use cases are typically mutually exclusive to this. UIO driver 
exports whole PRUSS I/O region and Interrupts to user space application and 
all the tasks including PRUSS INTC setup, loading firmware and
enable/disable PRUs are handled by PRUSS user driver.
I feel it will be a nightmare to make them co-exist unless say we have
2 instances of PRUSS in a SOC. Think about kernel driver setting up PRUSS, PINTC and loading firmware and user land overriding and vice versa. Things are much simpler if we make the usage model mutually exclusive.
Also I don't see any overlap in functionality and reuse UIO can gain from
MFD driver.  
Since we can't register device twice - I would prefer KConfig based check
for the same. 

Also can you point me where you add UART and CAN driver as children to PRUSS
MFD driver - I can't seem to find this in patches.

Thanks,
Pratheesh
