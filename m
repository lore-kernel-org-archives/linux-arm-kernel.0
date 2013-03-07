From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 7 Mar 2013 16:05:16 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307222004.GA2450@localhost>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
Message-ID: <20130307230516.GA28975@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 07:20:05PM -0300, Ezequiel Garcia wrote:
> Now that the Device Bus driver is posted I think we have a nice example
> on how address decoding windows would be allocated through the mbus
> driver, *without* touching the child driver (i.e. NOR driver).

No, that isn't the case. Your device bus driver *is* the child driver,
and you have touched it by adding mbus window code :)

In fact, looking at what you've done - with the DTs you've proposed
your driver does *nothing* but make a call to the mbus driver to setup
the windows for its children. Without timing parameters from the DT the
driver does nothing else!

So what is the point of that? Get rid of your driver, have the mbus
driver set up its own windows and put cfi-flash directly under
mbus. Smaller, simpler, clearer, better.

What you've done is *exactly* the sort of thing I was warning against
:)

BTW, I've made the same basic choice on our Kirkwood systems. The NAND
timing pameters are set by the bootloader and the kernel doesn't touch
them. The bootloader knows which flash chip is placed on the board so
only it knows the correct timing parameters. There is not any reason
to communicate them to the kernel.

I do see a fine use for your driver for non-boot devices, but the
window stuff needs to be removed so it isn't mandatory to use your
driver in the NOP case.

> In conclusion: there is absolutely no need to change the NOR driver,
> and there is no need to explictly add an explicit description of the
> NOR window in the device tree.

As I've said, a DT that has child nodes without an associated address
map is broken.

Jason
