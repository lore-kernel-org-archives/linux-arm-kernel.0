From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 15:52:16 +0000
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <AANLkTi=29LB66j123ufMHQk=46hGYdmR4nZZQFnN=Tku@mail.gmail.com>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
	<20110111104051.GA11039@n2100.arm.linux.org.uk>
	<20110111153630.GB2707@angua.secretlab.ca>
	<20110111154833.GF11039@n2100.arm.linux.org.uk>
	<AANLkTi=29LB66j123ufMHQk=46hGYdmR4nZZQFnN=Tku@mail.gmail.com>
Message-ID: <20110112155215.GB11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 08:46:44AM -0700, Grant Likely wrote:
> Looks like I've hit a hiccup though.  When I remove the first call to
> __lookup_machine_type, then it is only called after the MMU is turned
> on and the kernel is no longer able to output the list of configured
> machine ids when it doesn't recognize the value in r1 (tested with
> qemu versatile emulation).  I'm still investigating, so I'll defer
> reposting the patch until I've got this issue solved.

It only does this when DEBUG_LL is enabled - at which point you have
printascii, printhex8, etc available (although there's no prototype
for them.)

You could use snprintf() to format a message and then use printascii()
(conditional on CONFIG_DEBUG_LL as the existing code does) as well as
printk("%s", buffer).  That means if you have a debugger you can dump
the kernel ring buffer and see the message, or see it via the serial
port/debugging channel if DEBUG_LL is enabled.
