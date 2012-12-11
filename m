From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Dec 2012 17:51:13 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions
 in CONFIG_HAS_IOPORT
In-Reply-To: <20121211174509.69c8c66e@pyramind.ukuu.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de>
 <20121211162647.GS14363@n2100.arm.linux.org.uk>
 <20121211171610.01c2de16@pyramind.ukuu.org.uk>
 <20121211173450.GW14363@n2100.arm.linux.org.uk>
 <20121211174509.69c8c66e@pyramind.ukuu.org.uk>
Message-ID: <20121211175113.GX14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 05:45:09PM +0000, Alan Cox wrote:
> > The problem comes when you end up trying to deal with stuff which
> > uses ioread{8,16} on ioport_map() cookies where it's assumed that
> > adding N to the cookie is the same as adding N to the port address.
> 
> It's a cookie - this isn't a problem, you can support it via the mapping
> approah. Whether you want to is another question.

We're drifting off the topic of whether these things should be provided
and whether the config symbols should be selected...

For a kernel configuration which includes platforms where there is are no
ISA peripherals, no PCI bridge present, and no PCMCIA support, there's
little point to having IO space support present.

However, the platform should still work correctly if IO space support is
configured into the kernel (in other words, it shouldn't cause a failure)
so that such a platform can co-operate with those platforms which do
require IO space support.

Now, there was an idea a while back about having a common virtual address
space to map PCI/ISA IO space to - which we have in the kernel - 1MB at
0xfee00000.

If PCI is disabled, the ends up being a 1:1 conversion between IO offset
and CPU virtual address - that's partly there because no one's fixed up
the soc-common PCMCIA stuff to dea with the PCMCIA socket IO spaces
there.  We really need to be fixing some of this stuff...

(Unfortunately, my SA11x0 platform with the dual PCMCIA/CF sockets is now
my firewall so its out of the question to mess around with it on an ad-hoc
basis.)
