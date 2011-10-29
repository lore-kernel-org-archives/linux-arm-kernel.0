From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Oct 2011 13:53:42 +0100
Subject: [PATCH] ramoops appears geared to not support ARM
In-Reply-To: <4EABF4C2.7000104@gmail.com>
References: <1319844110-23062-1-git-send-email-bfreed@chromium.org>
	<4EABBBD3.5030700@gmail.com>
	<20111029093458.GX19187@n2100.arm.linux.org.uk>
	<4EABDDBE.5080407@gmail.com>
	<20111029115507.GA19187@n2100.arm.linux.org.uk>
	<4EABF4C2.7000104@gmail.com>
Message-ID: <20111029125342.GB19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 02:42:42PM +0200, Marco Stornelli wrote:
> Ok, I understand, but other question: isn't there any way to reserve  
> normal memory? Or at least, hasn't the mem kernel option any effect from  
> that point of view?

mem= can be used to redefine the available memory to the kernel, but
then you have to have some way to define a region of the memory you've
excluded to the kernel to use for ramoops.

A platform can also use the memblock stuff to extract some memory
dynamically from the information passed from the firmware - by using
memblock_alloc + memblock_remove + memblock_free.  The memblock_remove
call will take the memory out of the available memory to the kernel,
and thus will prevent it being mapped.

This must be done via the ->reserve callback in the ARM board/SoC
record (it can't be done later because the memory will have already
been mapped.)
