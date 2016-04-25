From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 00:43:16 +0200
Subject: [RFC] Is /dev/port useful on arm64?
In-Reply-To: <571E9B98.4050505@redhat.com>
References: <571E9B98.4050505@redhat.com>
Message-ID: <4771157.GTXbP8MYg9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 16:35:04 Al Stone wrote:
> 
> However, /dev/port is used for both ISA and PCI IO ports.  So, this led me
> to what may be a dumb question: is there really a need for PCI support in
> /dev/port for arm64?
> 
> Supporting ISA just seems silly, at least from an ARMv8 server standpoint,
> but PCI is less clear to me.  Anyone have opinions one way or the other?

Hisilicon has an ISA-like bus in their system, in form of LPC.
 
> It seems like it would be a waste of time to do the work to make sure the
> PCI ports work correctly only to find out they will never be used, but I
> can't think of anyone that actually needs them.

I think we should change the /dev/port implementation to interact with
the architecture code so it knows which addresses have been registered
through pci_ioremap_io to ensure that accessing it at least doesn't
predictably crash the kernel.

Aside from that, most distros probably want to disable it anyway along
with /dev/mem, but an embedded user can access the two if they absolutely
need to.

	Arnd
