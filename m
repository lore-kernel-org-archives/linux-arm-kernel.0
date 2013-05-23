From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 09:41:26 +0100
Subject: [PATCH 2/2] ARM: move VFP init to an earlier boot stage
In-Reply-To: <1369294104-3849-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1369294104-3849-1-git-send-email-ard.biesheuvel@linaro.org>
 <1369294104-3849-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20130523084126.GI18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 09:28:24AM +0200, Ard Biesheuvel wrote:
> In order to use the NEON/VFP unit in the kernel, we should
> initialize it a bit earlier in the boot process so NEON users
> that like to do a quick benchmark at load time (like the
> xor_blocks or RAID-6 code) find the NEON/VFP unit already
> enabled.

So what are the results of those benchmarks that the RAID-6 code does?

This isn't something which will get accepted without there being a very
strong case for it; firstly, we've always said "no FP in the kernel".
Secondly, it makes it too easy for people to start thinking that FP is
safe in the kernel.  It isn't - this will go horribly wrong if the VFP
hardware bounces an instruction to the support code.

Lastly, what happens if you sleep between kernel_vfp_start() and
kernel_vfp_end() ?  That's a context switch which will mess up your
VFP state.  I think you need to take a spinlock (not _bh nor _irqsave
versions) in here to ensure that people don't get the idea that they
_can_ sleep between these two.

So, good attempt, but I think you need to think about this more, and
also justify the need for it.
