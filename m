From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 22 Jul 2016 17:41:40 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <878twutmaj.fsf@concordia.ellerman.id.au>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <4197460.etrDupniY8@hactar> <878twutmaj.fsf@concordia.ellerman.id.au>
Message-ID: <1732711.nTAkJm8nA3@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22 Juli 2016, 12:54:28 schrieb Michael Ellerman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > So even if not ideal, the solution above is desirable for powerpc. We
> > would like to preserve the ability of allowing userspace to pass
> > parameters to the OS via the DTB, even if secure boot is enabled.
> > 
> > I would like to turn the above into a proposal:
> > 
> > Extend the syscall as shown in this RFC from Takahiro AKASHI, but
> > instead of accepting a complete DTB from userspace, the syscall accepts
> > a DTB containing only a /chosen node. If the DTB contains any other
> > node, the syscall fails with EINVAL. If the DTB contains any subnode in
> > /chosen, or if there's a compatible or device_type property in /chosen,
> > the syscall fails with EINVAL as well.
> > 
> > The kernel can then add the properties in /chosen to the device tree
> > that it will pass to the next kernel.
> > 
> > What do you think?
> 
> I think we will inevitably have someone who wants to pass something
> other than a child of /chosen.
> 
> At that point we would be faced with adding yet another syscall, or at
> best a new flag.
> 
> I think we'd be better allowing userspace to pass a DTB, and having an
> explicit whitelist (in the kernel) of which nodes & properties are
> allowed in that DTB.

Sounds good to me.

> For starters it would only contain /chosen/stdout-path (for example).
> But we would be able to add new nodes & properties in future.

If we allow things outside of chosen, we can keep the offb.c hook in 
Petitboot and whitelist the framebuffer properties it adds to the vga node.

> The downside is userspace would have no way of detecting the content of
> the white list, other than trial and error. But in practice I'm not sure
> that would be a big problem.

For our use case in OpenPower I don't think it would be a problem, since the 
userspace and the kernel are developed together.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
