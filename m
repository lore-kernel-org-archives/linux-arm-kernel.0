From: try2share@gmail.com (K K)
Date: Mon, 2 Jul 2012 17:31:55 +0530
Subject: kernel boot stops with "zlib_deflate: version magic" ,
 "zlib_inflate: version magic"
In-Reply-To: <20120628160310.GA25660@n2100.arm.linux.org.uk>
References: <CACZ0kf9+=jXuqKSH1Rnnp2AvvoVUr7zmepOP_71_XQx8RU2BNw@mail.gmail.com>
 <20120628160310.GA25660@n2100.arm.linux.org.uk>
Message-ID: <CACZ0kf_0PtF-iNqp-FFf0qU_paifCbWkUO+igrzd3U2cn1huoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

Thank you very much for your information.

> where the module was:
> 2. built with different module configuration options (your kernel supports
   module unloading, the 2.6.10 was built without that support.)

Yes, I built the modules in 2.6.32 ,i didn't include any of the module
objects, which were built for 2.6.10.

Actually, I have taken 2.6.32 vanilla kernel from kernel.org and added the
mach-lpc3180 directory in arch/arm/ directory for including LPC3180 machine
code. Then, I  build the 2.6.32 kernel uImage. Then, I have seen those
zlib_deflate and zlib_inflate version magic mismatch errors. After some
research, I have resolved these errors by selecting the MODULE VERSION
support option in the menuconfig.

Enable loadable module support  --->
      Module versioning support

After the above modifications, I didn't see any zlib mismatch errors or any
other errors. But,  I didn't get any login/command prompt yet. I am still
looking into this issue.

Could you please let me know, whether enabling the MODULE VERSIONING
SUPPORT to resolve ZLIB version magic mismatch errors is correct or not.

Regards,
KK

On Thu, Jun 28, 2012 at 9:33 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Wed, Jun 27, 2012 at 05:59:20PM +0530, K K wrote:
> > <6>VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev
> 1
> > <5>RAMDISK: gzip image found at block 0
> > VFS: Mounted root (ext2 filesystem) on device 1:0.
> > <6>Freeing init memory: 104K
>
> Good, so you've made it all the way through the kernel initialization.
> Then your userspace is trying to load a module:
>
> > --debug .@ <kernel/module.c>  <load_module>  <2186>
> > <3>zlib_deflate: version magic '2.6.10 ARMv5 gcc-3.4' should be '2.6.32
> > mod_unload ARMv5 '
> > --debug .@ <kernel/module.c>  <load_module>  <2186>
> > <3>zlib_inflate: version magic '2.6.10 ARMv5 gcc-3.4' should be '2.6.32
> > mod_unload ARMv5 '*
>
> where the module was:
> 1. built for a different version of the kernel
> 2. built with different module configuration options (your kernel supports
>    module unloading, the 2.6.10 was built without that support.)
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/dbd3c0fd/attachment-0001.html>
