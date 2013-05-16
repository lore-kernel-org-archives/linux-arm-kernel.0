From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 May 2013 21:29:21 +0100
Subject: [PATCH 0/9] Fix Marvell mv63xxx I2C driver
Message-ID: <20130516202921.GW18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes a whole chunk of problems with this driver,
discovered with the Marvell Armada 510 chip on the Solid-run cubox.

Most notable of these is the I2C driver aborting a transaction
because a signal is pending - which might be SIGPIPE or SIGALRM
for the process.  Meanwhile, the calling driver may be in the
middle of a critical read-modify-write cycle on a device register,
causing it to fail.

Other problems are race conditions in the handling of multi-part
messages, where we end up sending multiple start conditions -
sometimes more times than we have i2c_msg's to send.

Lastly is the rather poor probe error handling, which ranges from
non-existent to lacking propagating the provided error code.
