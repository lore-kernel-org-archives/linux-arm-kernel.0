From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 8 Mar 2013 09:10:52 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307230516.GA28975@obsidianresearch.com>
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
 <20130307230516.GA28975@obsidianresearch.com>
Message-ID: <20130308091052.18612729@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 7 Mar 2013 16:05:16 -0700, Jason Gunthorpe wrote:

> So what is the point of that? Get rid of your driver, have the mbus
> driver set up its own windows and put cfi-flash directly under
> mbus. Smaller, simpler, clearer, better.

No, we will still need the Device Bus driver to set up the timings.

> What you've done is *exactly* the sort of thing I was warning against
> :)
> 
> BTW, I've made the same basic choice on our Kirkwood systems. The NAND
> timing pameters are set by the bootloader and the kernel doesn't touch
> them. The bootloader knows which flash chip is placed on the board so
> only it knows the correct timing parameters. There is not any reason
> to communicate them to the kernel.

That's _your_ choice, and it's entirely inconsistent with most kernel
practices. For example, we have the pinctrl subsystem, which precisely
aims at empowering the kernel in terms of pin muxing, while previously,
it was a mix of custom kernel APIs, or reliance on the bootloader for
having setting up the pin muxing.

Sorry, but we _do_ want the kernel to be able to set those timings
parameters, and therefore, a Device Bus driver will be needed,
regardless of whether it creates the address window or not.

> > In conclusion: there is absolutely no need to change the NOR driver,
> > and there is no need to explictly add an explicit description of the
> > NOR window in the device tree.
> 
> As I've said, a DT that has child nodes without an associated address
> map is broken.

That's a statement without any arguments. How can we have a serious
technical discussion if what you bring is just "this is broken", with no
arguments?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
