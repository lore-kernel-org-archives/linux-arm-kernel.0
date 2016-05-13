From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 13 May 2016 13:55:15 +0900
Subject: [PATCH v16 00/20] arm64 kexec kernel patches v16
In-Reply-To: <5734CA48.7040706@arm.com>
References: <cover.1460668521.git.geoff@infradead.org>
 <5734CA48.7040706@arm.com>
Message-ID: <20160513045501.GC8417@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+Ard]

Hi Julien,

Thank you for reporting this issue.

On Thu, May 12, 2016 at 07:24:08PM +0100, Julien Grall wrote:
> Hello Geoff,
> 
> On 14/04/16 22:21, Geoff Levand wrote:
> >This series adds the core support for kexec re-boot and kdump on ARM64.  This
> >version of the series combines Takahiro's kdump patches with my kexec patches.
> >Please consider all patches for inclusion.
> >
> >To load a second stage kernel and execute a kexec re-boot or to work with kdump
> >on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
> >merged upstream, are needed.  Please update to the latest if you have been using
> >an older version.
> >
> >To examine vmcore (/proc/vmcore), you should use
> >   - gdb v7.7 or later
> >   - crash v7.1.1 or later
> 
> I have been trying to use crash dump with your branch without much
> success on juno-r2:
> 
> WARNING: could not find MAGIC_START!
> crash: cannot determine base kernel version
> crash: /root/vmlinux and /root/coredump.kernel do not match!
> 
> Looking at the debug log (-p 5), the translation va -> pa computed
> by crash is wrong.
> 
> The physical address expected is 0x80a76b28, but crash return 0x88a76b28.

Yeah, this is due to Ard's KASLR patches (especially, f9040773b7bb: "arm64:
move kernel image to base of vmalloc area").
Now that the kernel image (and so all the kernel symbols) is located
in the vmalloc area, which is below PAGE_OFFSET, we can't use liner mapping
conversion for va -> pa in order to access kernel data in the core image.

I'm sure that the image (/proc/vmcore) is still sane, and we will have
to fix a user-space tool, i.e. crash.
The good news is that I've already confirmed that we could read the core
image successfully by adding a bit nasty hack to the tool.

I'll let you know once a refined patch gets ready.

Thanks for your patience,
-Takahiro AKASHI

> I am using crash built from [1] and the panic has been created using
> /proc/sysrq-trigger.
> 
> Also, crash dump seems to always report that Xen is running even
> when KVM was in used (see logs [2]) below.
> 
> Lastly, crash fails with an error after a couple of minutes (see logs [2]).
>
> How you seen such errors during your testing?
> 
> Regards,
> 
> [1] https://github.com/crash-utility/crash
> [2] http://pastebin.com/wC8w44SN
> 
> -- 
> Julien Grall
