From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Nov 2013 20:34:00 +0100
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <20131105191230.GA20600@obsidianresearch.com>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <201311051948.11992.arnd@arndb.de>
 <20131105191230.GA20600@obsidianresearch.com>
Message-ID: <201311052034.01114.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 November 2013, Jason Gunthorpe wrote:
> The issue is sysfs, the TPM core attaches attributes to the driver's
> struct device, which means it has to convert from struct device * to
> its own private data. It is totally wrong, but that is the way
> it has been for ever. :(

I've just had a very brief look at that subsystem, and the first driver
I looked at (tpm_atmel) actually creates a child platform_device for
the sole purpose of registering that with the tpm subsystem, which seems
to avoid this problem. Maybe the same can be done for the other drivers
as well. Unfortunately, that will change the sysfs structure, which might
break user space relying on the current path to the device. The TPM
subsystem definely seems a bit unusual in this regard, so I hope not too
many other parts of the kernel have this particular problem.

(side note: another unusual aspect of the TPM subsystem is the use of a
 custom 'release' function override. Seems harmless, but very weird).	

	Arnd
