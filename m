From: vigneshr@ti.com (Vignesh R)
Date: Thu, 5 Nov 2015 17:59:36 +0530
Subject: [PATCH v2 1/5] spi: introduce mmap read support for spi flash
 devices
In-Reply-To: <20151104143915.GI1717@sirena.org.uk>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-2-git-send-email-vigneshr@ti.com>
 <20151104143915.GI1717@sirena.org.uk>
Message-ID: <563B4BB0.9020206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/04/2015 08:09 PM, Mark Brown wrote:
> On Tue, Nov 03, 2015 at 03:36:10PM +0530, Vignesh R wrote:
> 
>> +	}
>> +	mutex_lock(&master->mmap_lock_mutex);
>> +	ret = master->spi_mtd_mmap_read(spi, from, len, retlen, buf,
>> +					read_opcode, addr_width,
>> +					dummy_bytes);
>> +	mutex_unlock(&master->mmap_lock_mutex);
>> +	if (master->auto_runtime_pm)
>> +		pm_runtime_put(master->dev.parent);
> 
> It's a bit worrying that this doesn't sync with the message queue except
> via the mutex: this means that we might be out of order with respect to
> any asynchronous transfers that are happening on the device.  I'm not
> sure that this is a practical problem, though there is some risk of
> unfair scheduling that would have to be under extreme load and it might
> make sense to prioritise reads anyway.
> 

Since mmap interface is used only by mtd flash drivers and since almost
all mtd flash devices use synchronous transfers (spi_sync()), IMO, there
wont be out of order problem wrt mtd flashes.
But mmap read might delay transfers queued for non mtd flash devices. It
is difficult to wait for all transfers already queued to be pumped out
by __spi_pump_messages() and then do the mmap transfer. Do you have any
thoughts on how to sync with message queue?

-- 
Regards
Vignesh
