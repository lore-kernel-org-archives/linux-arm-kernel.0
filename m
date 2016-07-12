From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 12 Jul 2016 13:25:11 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <87furf7ztv.fsf@x220.int.ebiederm.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org>
Message-ID: <50662781.Utjsnse3nb@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

I'm trying to understand your concerns leading to your nack. I hope you 
don't mind expanding your thoughts on them a bit.

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

I don't understand how the kernel signature will be invalidated. 

There are some types of boot images that can embed a device tree blob in 
them, but the kernel can also be handed a separate device tree blob from 
firmware, the boot loader, or kexec. This latter case is what we are 
discussing, so we are not talking about modifying an embedded blob in the 
kernel image.

> What x86 does is pass it's equivalent of the device tree blob from one
> kernel to another directly and behind the scenes.  It does not go
> through userspace for this.
> 
> Until a persuasive case can be made for going around the kernel and
> probably adding a feature (like code execution) that can be used to
> defeat the signature scheme I am going to nack this.

I also don't understand what you mean by code execution. How does passing a 
device tree blob via kexec enables code execution? How can the signature 
scheme be defeated?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
