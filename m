From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 May 2018 11:14:55 +0100
Subject: linux-next: manual merge of the userns tree with the arm tree
Message-ID: <20180525101455.GI4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Yesterday's linux-next merge of the userns tree got a conflict in:

  arch/arm/mm/fault.c

between commit:

  8d9267cedb9e1d8edb8 ("ARM: spectre-v2: harden user aborts in kernel space")

from the arm tree and commit:

  3eb0f5193b497083391 ("signal: Ensure every siginfo we send has all bits initialized")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm/mm/fault.c
index 3b1ba003c4f9,32034543f49c..000000000000
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@@ -163,9 -163,8 +163,11 @@@ __do_user_fault(struct task_struct *tsk
  {
  	struct siginfo si;
  
+ 	clear_siginfo(&si);
+ 
 +	if (addr > TASK_SIZE)
 +		harden_branch_predictor();
 +
  #ifdef CONFIG_DEBUG_USER
  	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
  	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180525/38d71e1f/attachment.sig>
