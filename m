From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 28 Apr 2013 11:29:26 +1200
Subject: Array subscript above array bounds warning
Message-ID: <517C5F56.7040106@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Could someone clarify for me what I am missing here?


in drivers/net/ethernet/via/velocity.h is the following definition:

struct mac_regs {
volatile u8 PAR[6]; /* 0x00 */
...
}

I am trying to add the following function but it keeps giving array 
bounds warnings:

static void velocity_set_power_state(struct velocity_info *vptr, char state)
{
struct mac_regs __iomem *regs = vptr->mac_regs;

if (vptr->bustype == BUS_PCI) {
pci_set_power_state(vptr->pdev, state);
} else {
writeb(state, (&regs->PAR[0]) + 0x154);
}
}

gives:

/home/sentient/linux-git/server/arch/arm/include/asm/io.h:83:2: warning: 
array subscript is above array bounds [-Warray-bounds]


If I change the function to:

static void velocity_set_power_state(struct velocity_info *vptr, char state)
{
void __iomem *addr;
struct mac_regs __iomem *regs = vptr->mac_regs;

if (vptr->bustype == BUS_PCI)
pci_set_power_state(vptr->pdev, state);
else {
addr = &regs->PAR[0];
writeb(state, addr + 0x154);
}
}

I get the following warning:

drivers/net/ethernet/via/via-velocity.c:99:8: warning: assignment 
discards ?volatile? qualifier from pointer target type [enabled by default]


What is the correct way to go about this?

Regards
Tony Prisk
