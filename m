From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Feb 2011 10:40:48 +0000
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <1297882866.20252.20.camel@hornet.cambridge.arm.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<1297882866.20252.20.camel@hornet.cambridge.arm.com>
Message-ID: <20110217104048.GD24627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 07:01:06PM +0000, Pawel Moll wrote:
> / # dd if=/dev/mmcblk0 of=/dev/null bs=128k count=10
> 10+0 records in
> 10+0 records out
> 1310720 bytes (1.3MB) copied, 46.539866 seconds, 27.5KB/s
> / # sleep 30
> / # dd if=/dev/mmcblk0 of=/dev/null bs=128k count=10
> 10+0 records in
> 10+0 records out
> 1310720 bytes (1.3MB) copied, 46.540215 seconds, 27.5KB/s
> 
> 
> So it does the right thing with decreasing the clock rate in face of
> problems, I just can't see it clocking it back up...

You need at least 100 requests before it'll consider clocking back up.
Once it has 100 requests, no more than 5% of them at the current clock
rate must have failed for it to consider clocking up.  I found with
fewer requests, it was forever clocking down, up, down very frequently.
