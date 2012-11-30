From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 30 Nov 2012 12:17:39 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
Message-ID: <20121130121738.GA1960@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 02:38:14AM +0100, Marko Kati? wrote:
> I recently tried to boot v3.7-rc7 on my akita (Sharp Zaurus C-1000,
> PXA270 machine).
> Backlight never turned on but the kernel booted just fine.
> After some investigation i determined that the gpio expander (max7310,
> i2c chip) is not even
> registered and thus not present in /sys/bus/i2c/devices.
> Backlight gpio controls are hooked to this chip thus, no backlight.
> 
> I thought that too many things could have caused this so i went
> straight to bisecting.
> Bisection pointed me to this commit:
> 
>  commit 424e5994e63326a42012f003f1174f3c363c7b62
> Author: Dave Martin <dave.martin@linaro.org>
> Date:   Fri Feb 10 18:07:07 2012 -0800
> 
>     ARM: zImage/virt: hyp mode entry support for the zImage loader
> 
>     The zImage loader needs to turn on the MMU in order to take
>     advantage of caching while decompressing the zImage.  Running this
>     in hyp mode would require the LPAE pagetable format to be
>     supported; to avoid this complexity, this patch switches out of hyp
>     mode, and returns back to hyp mode just before booting the kernel.
> 
>     This implementation assumes that the Hyp mode view of memory and the
>     PL1 view of memory are coherent, providing that the MMU and caches
>     are off in both, as required by the boot protocol.  The zImage
>     decompression code must drain the write buffer on completion anyway, and
>     entry into Hyp mode should flush any prefetch buffer, avoiding hazards
>     associated with local write buffers and the pipeline.
> 
>     Signed-off-by: Dave Martin <dave.martin@linaro.org>
>     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> This commit was merged in v3.7-rc1. And indeed, if i
> revert this single commit, my gpio expander reappears and
> so does my backlight.
> I made no other changes to the vanilla 3.7-rc7
> except this revert.
> 
> This seems very strange to me because i, with my limited knowledge,
> cannot see any correlation between this commit and the bug i am experiencing.
> 
> Does anyone know what exactly is happening here?

This is indeed strange, since there is not much difference to the kernel
if CONFIG_ARM_VIRT_EXT is not set.

Unless a bug is causing the kernel to trample on some random memory,
there is no reason for this to cause I2C devices to disappear.

It could be something unrelated, like additional and removal of code
changing the position or alignment of other parts of the kernel image.

Have you could try undoing parts of the patch to narrow the bug down
further?

Cheers
---Dave
