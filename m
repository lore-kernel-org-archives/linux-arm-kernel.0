From: john.garry@huawei.com (John Garry)
Date: Fri, 6 Jan 2017 11:15:22 +0000
Subject: [QUESTION] Early Write Acknowledge for PCIe configuration space
Message-ID: <df407f39-ee05-d74d-6e5e-c5e502372032@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[apologies if this has been queried before]

Hi ARM guys,

I have a question about the device memory attributes we assign for PCIe 
config space for arm64. Currently we use ioremap to map in the config 
space; this uses nGnRE, which means we enable Early Write Acknowledge.

The ARMv8 ARM states that "ARM recommend that No Early Write Acknowledge 
Hint is used for PCIe configuration writes".

I understand a problem with using E is in that configuration write is a 
non-post operation, which means the RP requires to get the completion 
ack from the EP The problem here is if CPU writes data to ECAM by E, 
complete will go back to CPU directly, and maybe at this point the write 
has not reached the EP.

I believe that this may cause ordering issues in PCI read/write. In 
practice we use non-relaxed readl/writel to access config space, which 
include the synchronization barriers, which, *as I understand*, even if 
for full system domain, may be negated by the E attribute for PCIe.

So a question: why is the recommendation in the ARMv8 ARM ignored?

Thanks in advance,
John
