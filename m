From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 12 Jul 2016 10:58:09 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <87furf7ztv.fsf@x220.int.ebiederm.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org>
Message-ID: <2675986.6AfrV5PCe0@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

Am Dienstag, 12 Juli 2016, 08:25:48 schrieb Eric W. Biederman:
> AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
> > Device tree blob must be passed to a second kernel on DTB-capable
> > archs, like powerpc and arm64, but the current kernel interface
> > lacks this support.
> > 
> > This patch extends kexec_file_load system call by adding an extra
> > argument to this syscall so that an arbitrary number of file descriptors
> > can be handed out from user space to the kernel.
> > 
> > See the background [1].
> > 
> > Please note that the new interface looks quite similar to the current
> > system call, but that it won't always mean that it provides the "binary
> > compatibility."
> > 
> > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
> 
> So this design is wrong.  The kernel already has the device tree blob,
> you should not be extracting it from the kernel munging it, and then
> reinserting it in the kernel if you want signatures and everything to
> pass.
> 
> What x86 does is pass it's equivalent of the device tree blob from one
> kernel to another directly and behind the scenes.  It does not go
> through userspace for this.
> 
> Until a persuasive case can be made for going around the kernel and
> probably adding a feature (like code execution) that can be used to
> defeat the signature scheme I am going to nack this.

There are situations where userspace needs to change things in the device 
tree to be used by the next kernel.

For example, Petitboot (the boot loader used in OpenPOWER machines) is a 
userspace application running in an intermediary Linux instance and uses 
kexec to load the target OS. It has to modify the device tree that will be 
used by the next kernel so that the next kernel uses the same console that 
petitboot was configured to use (i.e., set the /chosen/linux,stdout-path 
property). It also modifies the device tree to allow the kernel to inherit 
Petitboot's Openfirmware framebuffer.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
