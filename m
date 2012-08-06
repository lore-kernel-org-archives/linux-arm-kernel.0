From: klightspeed@killerwolves.net (Ben Peddell)
Date: Mon,  6 Aug 2012 19:32:51 +1000 (EST)
Subject: [PATCH] initramfs: handle trailing junk after valid image
In-Reply-To: <501F8D75.8070108@killerwolves.net>
References: <CAB9O=CMADa26benQCkEoLOKKTGNeExjvFeVkFe4HLVi-W=o=Jg@mail.gmail.com>,
 <501F8D75.8070108@killerwolves.net>
Message-ID: <20120806093251.0528E77A0D@aristotle.killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initramfs handling since commit df37bd15 has been rejecting
valid images that have garbage after them.  For example, on an
architecture where the initramfs address and size are specified
as a kernel parameter (specifically unicore32 and arm), specifying
e.g. initrd=0x01000000,4M will not work unless the image is padded
with nulls to 4MiB.  This is unlikely to occur if the user is using
this parameter to work around a bug in the bootloader.

---
 init/initramfs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 84c6bf1..26c2cb1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -467,6 +467,9 @@ static char * __init unpack_to_rootfs(char *buf, unsigned len)
 					 compress_name);
 				message = msg_buf;
 			}
+		} else if (state == Reset) {
+			my_inptr = len;
+			pr_warn("%s: junk at end of compressed archive\n", __func__);
 		} else
 			error("junk in compressed archive");
 		if (state != Reset)
-- 
1.7.3.4
