From: mmarek@suse.cz (Michal Marek)
Date: Fri, 09 Sep 2011 14:30:56 +0200
Subject: [RFC] Kbuild: allow code re-use across different directories
In-Reply-To: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
References: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
Message-ID: <4E6A0700.9030401@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.8.2011 02:37, Arnaud Lacombe wrote:
> Hi folks,
> 
> The attached patch modify Kbuild to allow to directly re-use code in multiple
> directory without having to go through a copy. Technically, it changes Kbuild to
> use by default the VPATH feature of GNU make and provides accessors for Makefile
> to change it indirectly.
> 
> Considering:
> 
> arch/foo/lib:
> fancy.c
> 
> We want to be able to build it with -DPANTS=32 in the kernel, but the
> bootloader requires -DPANTS_SIZE=30.
> 
> Currently we would do, either:
> 
> arch/foo/lib/Makefile
> LDFLAGS_fancy.o := -DPANTS=32
> obj-y += fancy.o
> 
> and, either:
> 
> arch/foo/boot/Makefile:
> LDFLAGS_fancy.o := -DPANTS=30
> obj-y += fancy.o
> $(obj)/fancy.c: $(srctree)/arch/foo/lib/fancy.c
> 	$(call cmd,shipped)
> 
> or
> 
> arch/foo/boot/Makefile:
> LDFLAGS_fancy.o := -DPANTS=30
> obj-y += fancy.o
> $(obj)/fancy.o: $(srctree)/arch/foo/lib/fancy.c
> 	$(call cmd,cc_c_o)
> 
> The former implies an extra copy of the source file, the latter expose Kbuild
> internal function.
> 
> With the attached patch, we would do:
> 
> arch/foo/boot/Makefile:
> LDFLAGS_fancy.o := -DPANTS=30
> obj-y += fancy.o
> vpath-y += $(srctree)/arch/foo/lib
> 
> and let GNU make do the job.

I like this. The only issue I can think of right now, is that if you add
a large directory to vpath-y, then it would be easy to accidentally
reuse more files from that directory than intended. But that could be
easily prevented by isolating those reusable source files.

Michal
