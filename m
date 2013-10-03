From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 3 Oct 2013 13:44:49 -0600
Subject: [PATCH v2 1/2] ARM: kirkwood: retain MAC address for DT ethernet
In-Reply-To: <20131003190437.GY31178@titan.lakedaemon.net>
References: <1380804294-13726-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1380826568-18587-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131003190201.GA2504@localhost>
 <20131003190437.GY31178@titan.lakedaemon.net>
Message-ID: <20131003194449.GB30298@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 03:04:37PM -0400, Jason Cooper wrote:

> > I'm wondering: is the clock really disabled if the device is not
> > available (i.e. status == 'ok')? In other words: isn't the
> > !of_device_is_available() test enough?
> 
> Well, this stemmed from JasonG's scenario where the second iface is
> shut off by the bootloader.  Although one could argue that the
> bootloader should then update the dtb to mark that node as disabled...

Right, that is what we do here, only the first eth is present in the
dt, the second is gated and powered down (noting that Linux doesn't
know how to power it up :()

This check is only to prevent CPU lockup if the firmware has included
a DT node for ethernet, not included the MAC address and turned off
the clock.

Sebastian, does __clk_enabled work properly for the mvebu clock
provider? I don't see a clk_ops.is_enabled for mvebu.. (don't know
much about clk)

Also, I think you should move the pr_err above the clock test, or make
a special pr_err for the clock test as well. Having the clock gated,
no mac address and a dt node is still a fw bug.

Regards,
Jason
