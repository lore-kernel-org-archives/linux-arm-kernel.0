From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 13 Sep 2018 18:29:54 +0800
Subject: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
In-Reply-To: <20180913091534.GB32721@e107981-ln.cambridge.arm.com>
References: <20180829110408.556c3622@xhacker.debian>
 <20180910165722.38218779@xhacker.debian>
 <20180913091534.GB32721@e107981-ln.cambridge.arm.com>
Message-ID: <20180913182926.365d155b@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Thu, 13 Sep 2018 10:15:34 +0100 Lorenzo Pieralisi wrote:

> On Mon, Sep 10, 2018 at 04:57:22PM +0800, Jisheng Zhang wrote:
> > Hi all,
> > 
> > On Wed, 29 Aug 2018 11:04:08 +0800 Jisheng Zhang wrote:
> >   
> > > When programming inbound/outbound atu, we call usleep_range() after
> > > each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> > > can be called in atomic context:
> > > 
> > > inbound atu programming could be called through
> > > pci_epc_write_header()  
> > >   =>dw_pcie_ep_write_header()
> > >     =>dw_pcie_prog_inbound_atu()    
> > > 
> > > outbound atu programming could be called through
> > > pci_bus_read_config_dword()  
> > >   =>dw_pcie_rd_conf()
> > >     =>dw_pcie_prog_outbound_atu()    
> > > 
> > > Fix this issue by calling mdelay() instead.  
> > 
> > Any comments about this patch?
> > 
> > Thanks,
> > Jisheng
> >   
> > > 
> > > Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> > > Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")  
> 
> Can you split it into two patches and repost it please ? It will make
> everyone's life easier to backport it if there is need, I will apply
> then.

IIUC, the purpose of this split is to make the backport to stable easier. If
so, I realise that the Fixes tags were not enough, we missed:

Fixes: edd45e396829 ("PCI: dwc: designware: Move _unroll configurations to a
separate function")

I'm not sure how to handle this case. From another side, the issue to be
fixed is the same: call sleep in atomic context in the same driver, is it
better to use one patch?

As for stable tree, I could send out separate patches instead. What do you
think?

Thanks,
Jisheng
