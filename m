From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jan 2014 14:10:29 +0000
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140121143656.3c0b96c0@ipc1.ka-ro>
References: <20140120122840.36520f37@ipc1.ka-ro>
 <20140120123627.1147f252@ipc1.ka-ro>
 <20140120123849.GC15937@n2100.arm.linux.org.uk>
 <20140120150902.207b9d66@ipc1.ka-ro>
 <20140120151152.GE15937@n2100.arm.linux.org.uk>
 <20140121075922.2a83e076@ipc1.ka-ro>
 <20140121110107.GS15937@n2100.arm.linux.org.uk>
 <20140121125200.6b1e96bd@ipc1.ka-ro>
 <20140121115706.GT15937@n2100.arm.linux.org.uk>
 <20140121143656.3c0b96c0@ipc1.ka-ro>
Message-ID: <20140121141029.GU15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 02:36:56PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Russell King - ARM Linux wrote:
> > On Tue, Jan 21, 2014 at 12:52:00PM +0100, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > Russell King - ARM Linux wrote:
> > > > On Tue, Jan 21, 2014 at 07:59:22AM +0100, Lothar Wa?mann wrote:
> > > > > The file is automatically removed after the timeout has expired (or
> > > > > the frimware has been loaded).
> > > > > Thus you must check for it within the timeout period during boot.
> > > > 
> > > > ... which is impossible if imx-sdma is built into the kernel - it
> > > > expires while the initramfs has only just started running, giving a
> > > > very narrow window for userspace to load firmware.
> > > > 
> > > It works for me, but I'm not using initramfs.
> > 
> > You can take my email as a report of "it doesn't work for everyone."  The
> > *only* way I can get firmware to load is to build imx-sdma as a module.
> > Building it in is a hopeless case here.
> > 
> You could change the timeout from your initramfs as soon as sysfs has
> been mounted by writing the number of seconds to
> /sys/class/firmware/timeout. A timeout of '0' means 'wait forever' which
> should be long enough for any boot case. ;)

Err, no.  Let's walk through the code, shall we?

imx-sdma calls request_firmware_nowait() for the firmware.

request_firmware_nowait() allocates a work structure, saves all the
details, puts it on a queue, and triggers a workqueue to process this.

When the work structure is dequeued, request_firmware_work_func() is
called.  This calls _request_firmware() with the appropriate parameters,
including nowait = true.

_request_firmware() reads the timeout, and then calls
usermodehelper_read_lock_wait() with it.  (Once this has happened,
changing the timeout has no effect.)  This waits for the requisit amount
of time for usermodehelper_disabled.

Once that happens, fw_get_filesystem_firmware() is called by
_request_firmware(), which attempts to read the file from the mounted
filesystem.

If that fails, the kernel falls back to fw_load_from_user_helper()
to invoke a usermode helper to load the firmware.

This creates a file in /sys/class/firmware, and issues a uevent, sets
a timeout using the timeout value read above, and waits either for the
request to be satisfied or a timeout to happen.

So... increasing the timeout can _only_ have an effect if it is done
before the request is created - which, if imx-sdma is built into the
kernel will be impossible to achieve.

What I suspect is happening is that ubuntu's initramfs doesn't contain
the firmware, but it unblocks the user helper (since it contains and
runs udev) which also fails to find the firmware - and there's no
provision for the firmware to be included in ubuntu's initramfs.

So, let's go back to the point I've been making.  If you build imx-sdma
into the kernel, there are situations where it is impossible to load
replacement firmware, because the attempt to load firmware expires long
before there is any chance for it to be loaded.

Maybe you don't personally care about ubuntu.  Good for you, that's your
personal choice.  That has absolutely no bearing on this issue though.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
