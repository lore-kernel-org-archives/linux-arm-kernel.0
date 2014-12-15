From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Mon, 15 Dec 2014 09:48:06 +0100
Subject: [PATCH 0/1] arm: Fix fallout from the access_once tree
Message-ID: <1418633287-5019-1-git-send-email-borntraeger@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

the access_once tree in Linux next addresses an issue discussed in
http://marc.info/?i=54611D86.4040306%40de.ibm.com and
http://lwn.net/Articles/624126/

There is one small fallout left for the arm tree with rpc_defconfig:
http://kisskb.ellerman.id.au/kisskb/buildresult/12322985/

font.c:(.text+0x34): undefined reference to `data_access_exceeds_word_size'
font.c:(.text+0x9c): undefined reference to `data_access_exceeds_word_size'
make[3]: *** [arch/arm/boot/compressed/vmlinux] Error 1
make[2]: *** [arch/arm/boot/compressed/vmlinux] Error 2
make[1]: *** [zImage] Error 2
make: *** [sub-make] Error 2

Turns out that arch/arm/boot/compressed/Makefile does use
-Dstatic= which breaks compiler.h (which gets somehow included)

Can you Ack this change (or propose an alternative)
Thanks

Christian


Christian Borntraeger (1):
  arm/rpc: avoid static keyword removal via define

 arch/arm/boot/compressed/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.5.5
