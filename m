From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 29 Nov 2010 19:25:37 +0300
Subject: [GIT PULL] ARM: CNS3xxx fixes for 2.6.37
Message-ID: <20101129162537.GA26916@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

It's actually just a fix, not fixes. I don't seem to have anything
urgent for 2.6.37 except a small fixup for PCI=y builds.

Thanks!

The following changes since commit 3561d43fd289f590fdae672e5eb831b8d5cf0bf6:
  Linus Torvalds (1):
        Linux 2.6.37-rc3

are available in the git repository at:

  git://git.infradead.org/users/cbou/linux-cns3xxx.git for-rmk-fixes

Anton Vorontsov (1):
      ARM: cns3xxx: Fix build with CONFIG_PCI=y

 arch/arm/mach-cns3xxx/pcie.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


commit 44266416f786514ec43a0d15ad951c34566b99c9
Author: Anton Vorontsov <cbouatmailru@gmail.com>
Date:   Mon Nov 29 18:46:22 2010 +0300

    ARM: cns3xxx: Fix build with CONFIG_PCI=y
    
    commit 6338a6aa7c082f11d55712251e14178c68bf5869 ("ARM: 6269/1: Add 'code'
    parameter for hook_fault_code()") breaks CNS3xxx build:
    
      CC      arch/arm/mach-cns3xxx/pcie.o
    pcie.c: In function 'cns3xxx_pcie_init':
    pcie.c:373: warning: passing argument 4 of 'hook_fault_code' makes integer from pointer without a cast
    pcie.c:373: error: too few arguments to function 'hook_fault_code'
    
    This commit fixes the small issue.
    
    Cc: stable at kernel.org [36]
    Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 38088c3..78defd7 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -369,7 +369,7 @@ static int __init cns3xxx_pcie_init(void)
 {
 	int i;
 
-	hook_fault_code(16 + 6, cns3xxx_pcie_abort_handler, SIGBUS,
+	hook_fault_code(16 + 6, cns3xxx_pcie_abort_handler, SIGBUS, 0,
 			"imprecise external abort");
 
 	for (i = 0; i < ARRAY_SIZE(cns3xxx_pcie); i++) {
