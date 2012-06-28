From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jun 2012 17:03:11 +0100
Subject: kernel boot stops with "zlib_deflate: version magic" ,
 "zlib_inflate: version magic"
In-Reply-To: <CACZ0kf9+=jXuqKSH1Rnnp2AvvoVUr7zmepOP_71_XQx8RU2BNw@mail.gmail.com>
References: <CACZ0kf9+=jXuqKSH1Rnnp2AvvoVUr7zmepOP_71_XQx8RU2BNw@mail.gmail.com>
Message-ID: <20120628160310.GA25660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 05:59:20PM +0530, K K wrote:
> <6>VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 1
> <5>RAMDISK: gzip image found at block 0
> VFS: Mounted root (ext2 filesystem) on device 1:0.
> <6>Freeing init memory: 104K

Good, so you've made it all the way through the kernel initialization.
Then your userspace is trying to load a module:

> --debug .@ <kernel/module.c>  <load_module>  <2186>
> <3>zlib_deflate: version magic '2.6.10 ARMv5 gcc-3.4' should be '2.6.32
> mod_unload ARMv5 '
> --debug .@ <kernel/module.c>  <load_module>  <2186>
> <3>zlib_inflate: version magic '2.6.10 ARMv5 gcc-3.4' should be '2.6.32
> mod_unload ARMv5 '*

where the module was:
1. built for a different version of the kernel
2. built with different module configuration options (your kernel supports
   module unloading, the 2.6.10 was built without that support.)
