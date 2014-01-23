From: w@1wt.eu (Willy Tarreau)
Date: Thu, 23 Jan 2014 12:09:14 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87sisfjeba.fsf@natisbad.org>
References: <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140121211741.GA12657@xanatos> <87bnz364h0.fsf@natisbad.org>
 <20140122222641.GD29184@titan.lakedaemon.net> <87mwin4ozf.fsf@natisbad.org>
 <20140122235620.GC20359@xanatos> <87sisfjeba.fsf@natisbad.org>
Message-ID: <20140123110914.GA22913@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 09:24:41AM +0100, Arnaud Ebalard wrote:
> Hi Sarah,
> 
> Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> 
> >> > Can you pinpoint the commit that introduced the regression?
> >> 
> >> f5182b4155b9d686c5540a6822486400e34ddd98 "xhci: Disable MSI for some Fresco Logic hosts."
> >> 
> >> Technically, this is not per se the commit which introduced the
> >> regression but the one that *partially* fixed it by introducing the XHCI
> >> quirk to skip MSI enabling for Fresco Logic chips. The thing is it
> >> should have included the FL1009 in the targets. Sarah, can you confirm
> >> this?
> >
> > I don't know if it should have included FL1009, it was just a guess,
> > based on the fact that the 0x1000 and 0x1400 devices did need MSI
> > disabled.  I can attempt to ask the Fresco Logic folks I know, but I'm
> > not sure if/when I'll get a response back.
> >
> > That still doesn't necessarily rule out MSI issues in the Marvell PCI
> > host controller code.  Can you attach another PCI device with MSI
> > support under the host and see if it works?
> 
> The various Armada-based devices I have are NAS which do not have PCIe
> slots to plug additional devices (everything is soldered). I don't know
> which device Thomas used for its tests. Just in case, I also added Willy
> in CC: who have various boards and may also have done more test with
> additional PCIe devices and CONFIG_PCI_MSI enabled on 3.13 kernel.

I've been running an intel i350 dual-port NIC (igb driver) supporting
MSI on the mirabox, and it used to work in 3.10+many of the patches
coming from the Free-electrons team. Some recent changes to the PCI
code introduced a regression preventing this driver from correctly
registering an MSI interrupt, and I did not have enough time to
investigate it deep enough to fix it. That said, I know how to hack
it to work again, so if it can be of any use, I can run a test on
the mirabox (armada370) and on the XPGP board (armadaXP).

Willy
