From: john.stultz@linaro.org (John Stultz)
Date: Tue, 17 Jun 2014 06:57:10 -0700
Subject: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
In-Reply-To: <CAPDyKFry7_=-3kmydz7ikfDW5vMi512gC3Bj35PmuWT2z70GvQ@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
 <CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
 <CALAqxLXQeYA8jt_hLrJSuWtt7j3t2iZSZjEVAX7ScODAgrmVbA@mail.gmail.com>
 <CALAqxLX8TcFNDLvA1XozEZ_kf58jX0_SeDETfK9UcXVYajVVRQ@mail.gmail.com>
 <CAPDyKFry7_=-3kmydz7ikfDW5vMi512gC3Bj35PmuWT2z70GvQ@mail.gmail.com>
Message-ID: <CALAqxLWmrJn2NEGJ9hSOzsS6zFtFqE_ZWKKp+bW0oKmBFX95WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 12:33 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> It seems like you want to debug the mmci host driver and unfortunate
> the debug utilities available are only dev_dbg prints. I wouldn't be
> surprised if the problem goes away when you enable them. :-)
>
> I have some other locally stored debug patches for mmci, but those are
> not re-based and I am not sure you want to deal with them as is.
>
> I guess I need to set up the QEMU environment and run the tests
> myself, unless we go for the revert path.

Again, a simple revert *doesn't* seem to work. There's something else
in the 3.14->3.15-rc1 series that is also causing problems. Reverting
the patch only seems to work very close to the point that the commit
was made. I'm trying to redo the bisection reverting the first
problematic change each step to see if I can narrow the second problem
(but I've had some interruptions so I've not made much progress there
yet).

> How do you perform the tests, is just a simple mounting/un-mounting
> that triggers the problem?
> Any specific things that I need to think of when running QEMU?

Unfortunately its not quite so simple as mounting/unmounting.

My environment is the Linaro Android image:
http://releases.linaro.org/14.04/android/images/armv7-lsk/vexpress.img.bz2
(using the initrd in
http://releases.linaro.org/14.04/android/images/armv7-lsk/boot.tar.bz2).

My qemu line is:
QEMU_AUDIO_DRV=none qemu-system-arm -kernel zImage -initrd initrd -M
vexpress-a9 -cpu cortex-a9 -nographic -vnc :0 -m 1G -append
'root=/dev/mmcblk0p1 rw mem=1024M raid=noautodetect
console=ttyAMA0,38400n8 rootwait vmalloc=256MB devtmpfs.mount=0' -sd
vexpress-android.img -redir tcp:5555::5555

The first bootup is usually *very* slow (since it has to dex
everything), and I usually use the zImage kernel in the boot.tar.bz2
to let that finish so I can get a sane backup image. Connecting via
vnc to localhost:0 will let you know when its booted all the way and
finished dexing. I'd expect to wait ~5-10 minutes.

I then kill qemu, and make a backup copy of the disk image so future
boots are a bit faster.

And then booting again with my kernel zImage (config attached).

It most frequently triggers within ~90 seconds of boot, but not always
(I'll go ahead and kill qemu again if I don't see it). Usually I can
reproduce it within 4 boots. One potential clue here is that it
doesn't seem to trigger on the first boot w/ the affected kernel.

Every time I see corruption, I revert back to the backup dex'ed disk image.

thanks
-john
-------------- next part --------------
A non-text attachment was scrubbed...
Name: qemu.config
Type: application/octet-stream
Size: 62989 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/523bf999/attachment-0001.obj>
