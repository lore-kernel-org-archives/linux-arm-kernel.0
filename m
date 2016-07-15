From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 15 Jul 2016 18:03:35 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <3489461.zQnV5C1bXR@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715134209.GF1041@n2100.armlinux.org.uk> <3489461.zQnV5C1bXR@wuerfel>
Message-ID: <1808359.GMbkTHC4O6@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15 Juli 2016, 22:26:09 schrieb Arnd Bergmann:
> On Friday, July 15, 2016 2:42:10 PM CEST Russell King - ARM Linux wrote:
> > On other architectures, DT can also contain open-firmware "functions"
> > but I don't think there's much support in the kernel for that - maybe
> > the PPC folk can reply on that point.
> 
> The open firmware runtime interface are shut down by the time we have
> a flattened device tree, so those are not accessible any more. IIRC
> SPARC leaves the open firmware interface live, but it doesn't use
> fdt, so that's not relevant here.
> 
> However, the powerpc specific RTAS runtime services provide a similar
> interface to the UEFI runtime support and allow to call into
> binary code from the kernel, which gets mapped from a physical
> address in the "linux,rtas-base" property in the rtas device node.
> 
> Modifying the /rtas node will definitely give you a backdoor into
> priviledged code, but modifying only /chosen should not let you get
> in through that specific method.

Except that arch/powerpc/kernel/rtas.c looks for any node in the tree called 
"rtas", so it will try to use /chosen/rtas, or /chosen/foo/rtas.

We can forbid subnodes in /chosen in the dtb passed to kexec_file_load, 
though that means userspace can't use the simple-framebuffer binding via 
this mechanism.

We also have to blacklist the device_type and compatible properties in 
/chosen to avoid the problem Mark mentioned.

Still doable, but not ideal. :-/

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
