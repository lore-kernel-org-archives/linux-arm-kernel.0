From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Apr 2014 14:02:42 +0100
Subject: [PATCH 0/3] Make kexec work with CONFIG_DEBUG_RODATA enabled
In-Reply-To: <1398677507-6687-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1398677507-6687-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140430130241.GA15719@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolay,

On Mon, Apr 28, 2014 at 10:31:44AM +0100, Nikolay Borisov wrote:
> This patch makes kexec work on a kernel that has its .text section set to read
> only. The main reason of doing it is because there is a patch in the making 
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244779.html)
> which aims to make it possible to flag the kernel's code section as read-only,
> rendering kexec inoperable.
> 
> The first patch does the actual functional changes while the 2nd one is
> optional and is only to be used in case you have already applied the aforementioned
> CONFIG_DEBUG_RODATA patch
> 
> Patch 3 is also optional and tries to make the assembly code a bit more "sane"
> by introducing a .struct to describe the parameters for the kernel relocation
> stub. 
> 
> Those patches have been tested on linux 3.14 on THUMB-2/non-THUMB-2 host
> kernels. 
> 
> Patch 1 and 3 apply cleanly on 3.15-rc3 and Patch 2 applies cleanly, provided
> that Kees' patch is applied as well. 
> 
> Kees also managed to test that on a QEMU 2.0 based machine. 

Wouldn't it be far simpler to set_kernel_text_rw() on a kexec? At this
point, we've committed to replacing our image, so whether we can write to
the .text of the old image before we clobber it entirely seems somewhat
moot to me.

Will
