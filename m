From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 May 2015 12:38:41 +0200
Subject: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
In-Reply-To: <20150526095924.GF1565@arm.com>
References: <1430791333-26013-1-git-send-email-jchandra@broadcom.com>
 <20150521063729.GB31418@jayachandranc.netlogicmicro.com>
 <20150526095924.GF1565@arm.com>
Message-ID: <4112847.4hqbDCX9Jk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 May 2015 10:59:24 Will Deacon wrote:
> > > Secondly, the hack to put pci_sys_data as the first member of gen_pci is ugly
> > > at best
> > 
> > On balance, it removes the problem of using hw_pci interface which has its own
> > ugliness (Arnd's mail on this http://www.spinics.net/lists/linux-pci/msg40703.html)
> 
> To me, that sounds like we should be disposing of the hw_pci interface
> altogether and moving arch/arm/ over to the new architecture-independent
> interface.

I'd like to do that for all drivers in drivers/pci/host, but leave the
ones for the legacy platforms in arch/arm alone, in particular the ones
that use nr_controllers != 1.

We should be able to remove pci_common_init_dev() and directly probe
all devices that are using that, while we keep pci_common_init()
around for the legacy case that also does not have a parent device.

	Arnd
