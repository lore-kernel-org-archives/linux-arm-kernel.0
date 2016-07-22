From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu, 21 Jul 2016 21:09:48 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <1808359.GMbkTHC4O6@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <3489461.zQnV5C1bXR@wuerfel> <1808359.GMbkTHC4O6@hactar>
Message-ID: <4197460.etrDupniY8@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15 Juli 2016, 18:03:35 schrieb Thiago Jung Bauermann:
> Am Freitag, 15 Juli 2016, 22:26:09 schrieb Arnd Bergmann:
> > However, the powerpc specific RTAS runtime services provide a similar
> > interface to the UEFI runtime support and allow to call into
> > binary code from the kernel, which gets mapped from a physical
> > address in the "linux,rtas-base" property in the rtas device node.
> > 
> > Modifying the /rtas node will definitely give you a backdoor into
> > priviledged code, but modifying only /chosen should not let you get
> > in through that specific method.
> 
> Except that arch/powerpc/kernel/rtas.c looks for any node in the tree
> called "rtas", so it will try to use /chosen/rtas, or /chosen/foo/rtas.
> 
> We can forbid subnodes in /chosen in the dtb passed to kexec_file_load,
> though that means userspace can't use the simple-framebuffer binding via
> this mechanism.
> 
> We also have to blacklist the device_type and compatible properties in
> /chosen to avoid the problem Mark mentioned.
> 
> Still doable, but not ideal. :-/

So even if not ideal, the solution above is desirable for powerpc. We would 
like to preserve the ability of allowing userspace to pass parameters to the 
OS via the DTB, even if secure boot is enabled.

I would like to turn the above into a proposal:

Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
accepting a complete DTB from userspace, the syscall accepts a DTB 
containing only a /chosen node. If the DTB contains any other node, the 
syscall fails with EINVAL. If the DTB contains any subnode in /chosen, or if 
there's a compatible or device_type property in /chosen, the syscall fails 
with EINVAL as well.

The kernel can then add the properties in /chosen to the device tree that it 
will pass to the next kernel.

What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
