From: panand@redhat.com (Pratyush Anand)
Date: Mon, 19 Dec 2016 12:43:45 +0530
Subject: [PATCH V2 0/2] kexec-tools: arm64: Enable D-cache in purgatory
Message-ID: <cover.1482129830.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
is around 13MB and initramfs is around 30MB. It takes more than 20 second
even when we have -O2 optimization enabled. However, if dcache is enabled
during purgatory execution then, it takes just a second in SHA
verification.

Therefore, these patches adds support for dcache enabling facility during
purgatory execution.

Although I have simplified the logic a bit now, however I understand that
there are reservations for introducing this complexity for gaining few
seconding of execution time during kexec or crash reboot.  But, I believe
if d-cache enabling code is stable enough then there should not be any
hindrances to accept it. So, please give it a try with your platform and
let me know if you see any issue or it does not work. I am still open to
improve it further if needed.

Changes since V1:
	- Moved page table creation logic from purgatory to kexec code.
	- Only 4K page table is supported, with 48 bit VA and 2M block size
	- if platform supports a 4K page size, then D-cache is always
	  enabled now.
 
Pratyush Anand (2):
  kexec: arm64: create identity page table to be used in purgatory
  arm64: enable d-cache support during purgatory sha verification

 kexec/arch/arm64/kexec-arm64.c         | 152 ++++++++++++++++++
 purgatory/arch/arm64/Makefile          |   1 +
 purgatory/arch/arm64/cache.S           | 281 +++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/purgatory-arm64.c |   5 +
 4 files changed, 439 insertions(+)
 create mode 100644 purgatory/arch/arm64/cache.S

-- 
2.7.4
