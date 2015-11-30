From: carl@cog.systems (Carl van Schaik)
Date: Mon, 30 Nov 2015 12:45:18 +1100
Subject: arm64 boot requirements
Message-ID: <565BAA2E.5090102@cog.systems>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit bd00cd5f8c8c3c282bb1e1eac6a6679a4f808091, the idmap_pg_dir and 
swapper_pg_dir where moved from before the kernel to after it.

The problem is that these symbols fall outside the range covered by the 
ELF file - outside of any section.

A bootloader which loads the kernel ELF file and dynamically determines 
where to place the DTB, may try place it after the kernel. We've just 
run into this problem and the DTB gets overwritten as soon as the 
pagetables are created.

I'd suggest that the kernel either:
  A. document this boot requirement for where not to load a DTB
  B. update the vmlinux.lds.S such that these symbols (and _end) are 
properly covered by a section in the ELF, and thus preventing this issue.

thanks,
Carl
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm64-place-initial-page-tables-in-ELF-section.patch
Type: text/x-patch
Size: 1323 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/9de49ebc/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4267 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/9de49ebc/attachment.p7s>
