From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Jun 2010 12:30:05 -0400 (EDT)
Subject: [PATCH 3/3] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <AANLkTinQ_DdwRrjwtzrTXqtoeQxh87qAjSXDd6O4cPba@mail.gmail.com>
References: <1275404968-12258-1-git-send-email-saeed@marvell.com>
	<1275404968-12258-2-git-send-email-saeed@marvell.com>
	<1275404968-12258-3-git-send-email-saeed@marvell.com>
	<alpine.LFD.2.00.1006011447410.24526@xanadu.home>
	<AANLkTinQ_DdwRrjwtzrTXqtoeQxh87qAjSXDd6O4cPba@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006031224180.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jun 2010, saeed bishara wrote:

> On Tue, Jun 1, 2010 at 10:55 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 1 Jun 2010, Saeed Bishara wrote:
> >> +void __init kirkwood_pcie_init(int init_port0, int init_port1)
> >
> > And instead of having (int init_port0, int init_port1), this should be
> > (int port) which is much less error prone as demonstrated by your own
> > kirkwood_pcie_init(0, 1) usage. ?Those machines with both PCIe ports
> > would simply have to call this twice.
> nico, this is different from other controller,  we can't have multiple
> registrations as the pci_commont_init() can't be called multiple
> times.

OK. In that case that would be better to have only one argument and 
define some flag bits for it:

#define KW_PCIE0	(1 << 0)
#define KW_PCIE1	(1 << 1)

void __init kirkwood_pcie_init(int portmask)

And usage would be:

	kirkwood_pcie_init(KW_PCIE0 | KW_PCIE1);

This is much easier to review, and less prone to errors.


Nicolas
