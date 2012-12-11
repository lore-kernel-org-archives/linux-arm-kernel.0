From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 11 Dec 2012 17:16:10 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211162647.GS14363@n2100.arm.linux.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de>
 <20121211162647.GS14363@n2100.arm.linux.org.uk>
Message-ID: <20121211171610.01c2de16@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Correct.  If HAS_IOPORT is not selected then we are potentially missing
> the dependent functions (because the platform has no IOPORT support) _or_
> it does have ISA/PCI IO spaces _but_ they're not mappable via the
> ioport_map() mechanism due to some non-linearity involved in the
> translation.
> 
> To make that second point clear, that's platforms where:
> 
> 	ioport_map(addr + 4) != ioport_map(addr) + 4.

For inb/inw and friends this shouldn't matter.

You can implement inl for example 

as

	if (unlikely(addr & 3))
		// or in fact BUG on this for almost all h/w
		uninlined_hard_slow_inl(addr);
	else
		return *(u32 *)iospace_map[addr];
