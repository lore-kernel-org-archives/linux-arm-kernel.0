From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 8 Aug 2017 18:22:00 -0500
Subject: [PATCH v9 1/4] PCI: Add new PCIe Fabric End Node flag,
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING
In-Reply-To: <1501917313-9812-2-git-send-email-dingtianhong@huawei.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <1501917313-9812-2-git-send-email-dingtianhong@huawei.com>
Message-ID: <20170808232200.GO16580@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 05, 2017 at 03:15:10PM +0800, Ding Tianhong wrote:
> From: Casey Leedom <leedom@chelsio.com>
> 
> The patch adds a new flag PCI_DEV_FLAGS_NO_RELAXED_ORDERING to indicate that
> Relaxed Ordering (RO) attribute should not be used for Transaction Layer
> Packets (TLP) targetted towards these affected root complexes. Current list
> of affected parts include some Intel Xeon processors root complex which suffers from
> flow control credits that result in performance issues. On these affected
> parts RO can still be used for peer-2-peer traffic. AMD A1100 ARM ("SEATTLE")
> Root complexes don't obey PCIe 3.0 ordering rules, hence could lead to
> data-corruption.

This needs to include a link to the Intel spec
(https://software.intel.com/sites/default/files/managed/9e/bc/64-ia-32-architectures-optimization-manual.pdf,
sec 3.9.1).

It should also include a pointer to the AMD erratum, if available, or
at least some reference to how we know it doesn't obey the rules.

Ashok, thanks for chiming in.  Now that you have, I have a few more
questions for you:

  - Is the above doc the one you mentioned as being now public?
  
  - Is this considered a hardware erratum?
  
  - If so, is there a pointer to that as well?
  
  - If this is not considered an erratum, can you provide any guidance
    about how an OS should determine when it should use RO?
    
Relying on a list of device IDs in an optimization manual is OK for an
erratum, but if it's *not* an erratum, it seems like a hole in the
specs because as far as I know there's no generic way for the OS to
discover whether to use RO.

Bjorn
