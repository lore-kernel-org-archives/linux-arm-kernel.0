From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Apr 2014 11:58:46 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <6414220.SShvCHLvZQ@wuerfel>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk>
 <6414220.SShvCHLvZQ@wuerfel>
Message-ID: <20140424105846.GE19564@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Apr 23, 2014 at 07:58:05PM +0100, Arnd Bergmann wrote:
> Another problem is MSI processing. MSI was specifically invented to avoid
> having to check an MMIO register for a DMA completion that as a side-effect
> flushes pending DMAs from the same device. This breaks down if the MSI
> packet gets turned into a level interrupt before it reaches the CPU's
> coherency domain, which is likely the case on the dw-pcie controller that
> comes with its own MSI block.

I'm not sure there's anything special about MSI which helps with this
problem. For GICv3, the MSI write will target the ITS (a slave device),
whereas the data produced is assumedly targetting main memory. That still
requires careful ordering by the producer, in the same way as if it was
signalling a legacy interrupt.

Will
