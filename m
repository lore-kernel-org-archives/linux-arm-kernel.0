From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 6 Jan 2017 23:34:24 +0200
Subject: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
In-Reply-To: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

On 01/05/2017 12:47 PM, Mike Looijmans wrote:
> The driver calls i2c_add_adapter before writing to config registers,
> resulting in dmesg output like this, where devices fail to initialize:
> 
> cdns-i2c ff030000.i2c: timeout waiting on completion
> pca953x 1-0041: failed reading register
> pca953x: probe of 1-0041 failed with error -110
> at24 1-0050: 512 byte 24c04 EEPROM, writable, 1 bytes/write
> cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197
> 
> The adapter is being used before it completed the "probe". To fix
> this, make "i2c_add_adapter" the last thing it calls in probe.
> It also makes sense to show the adapter initialization before
> the devices on the bus.

commonly "it also" in a commit message means a change, which should be done
separately, and this is the case here as well.

Because the adapter registration i2c_add_adapter() can fail, information
about the adapter initialization would be expected only in case of
successful registration.

The information sent to the kernel log buffer here is quite trivial,
probably dev_info() can be just removed, but in any case it should be
a separate change.

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

--
With best wishes,
Vladimir
