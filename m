From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jun 2015 21:45:04 +0100
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5CrqAhcx=CmYVmKQ0t0oF-pduJYVio3xbUinvL8yTnrRg@mail.gmail.com>
References: <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
 <CAOMZO5DBoKXE9URxWvk+WkJEZ1RkC4S3hAyugTbd7b5Qu91QKA@mail.gmail.com>
 <CAOMZO5DOdrJdkvmtBV3Kegdxg=LVZB60qB_TvMJ-D45+1vDAHw@mail.gmail.com>
 <20150616094242.GR7557@n2100.arm.linux.org.uk>
 <CAOMZO5B9ysnLKpCrpyN3JBUrxVT7MOh7crY3nS8MDW2Hv4Xs+A@mail.gmail.com>
 <CAOMZO5BYCNuQ=5zHurf6Zqmpwcj1tiCZj7Nj4j6ygijbePNBFw@mail.gmail.com>
 <20150616161317.GS7557@n2100.arm.linux.org.uk>
 <CAOMZO5A43JV9piTpkoQQdkYr2P-ysEZVaXLQWd4mNW7OTe_ANw@mail.gmail.com>
 <20150616195828.GT7557@n2100.arm.linux.org.uk>
 <CAOMZO5CrqAhcx=CmYVmKQ0t0oF-pduJYVio3xbUinvL8yTnrRg@mail.gmail.com>
Message-ID: <20150616204504.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 05:13:37PM -0300, Fabio Estevam wrote:
> On Tue, Jun 16, 2015 at 4:58 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > If you don't have that commit, kexec should fail gracefully if it thinks
> > it can't cope with the existing system config - it shouldn't get to the
> > point where it takes the existing kernel down.
> 
> That's correct. On 4.0.5:
> 
> root at wandboard-solo:~# kexec -d -l /tmp/zImage --dtb
> /tmp/imx6dl-wandboard.dtb --command-line="console=ttymxc0,115200
> earlyprintk root=/dev/mmcblk0p2 rootwait rw"
> my_load:667: do
> kernel: 0x75dd1008 kernel_size: 0x5664c8
> kexec_load: entry = 0x10008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0x75dd1008
> segment[0].bufsz = 0x5664c8
> segment[0].mem   = 0x10008000
> segment[0].memsz = 0x567000
> segment[1].buf   = 0x10ab008
> segment[1].bufsz = 0x6ba7
> segment[1].mem   = 0x1159b000
> segment[1].memsz = 0x7000
> kexec_load failed: Invalid argument
> entry       = 0x10008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0x75dd1008
> segment[0].bufsz = 0x5664c8
> segment[0].mem   = 0x10008000
> segment[0].memsz = 0x567000
> segment[1].buf   = 0x10ab008
> segment[1].bufsz = 0x6ba7
> segment[1].mem   = 0x1159b000
> segment[1].memsz = 0x7000
> 
> Applying fee3fd4fd2ad136b into 4.0.5 then kexec works fine.
> 
> Should we send fee3fd4fd2ad136b to stable?

Do we have "real" users affected by this?  It seems there's more issues
that need resolving for it to work on iMX6, and so I don't think this
is a regression.

1) If you build just for imx6, then you get the decompressor talking to
   the serial port, which has been left disabled by the previous kernel
   (when userspace closes, it disables the TXEN bit in UCR2 and UARTEN
   in UCR1.)  This causes an imprecise abort to be raised in the
   decompressor when it tries to talk to the console.

   Changing the 

2) The IPU probe code is _definitely_ buggy - it claims its interrupt
   before it's finished setting stuff up, resulting in a nice oops.
   That's because we receive an interrupt immediately when:

        irq_set_chained_handler(ipu->irq_sync, ipu_irq_handler);

   has been called, and it tries to grab the pointer to the IPU, but
   it hasn't been set yet...

        irq_set_handler_data(ipu->irq_sync, ipu);

   I've had a quick discussion with tglx this evening about it, and
   we think it'd make sense to have a combo function -

	irq_set_chained_handler_and_data(ipu->irq_sync, ipu_irq_handler, ipu);

   which sets stuff up without this possibly being out of order.  With
   that resolved...

3) Something else causes boot to fail at:

621f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 294, base_baud = 5000000) is a IMX
[drm] Initialized drm 1.1.0 20060810
imx-drm display-subsystem: parent device of /soc/aips-bus at 02000000/ldb at 020e0008/lvds-channel at 1 is not available
imx-drm display-subsystem: parent device of /soc/aips-bus at 02000000/ldb at 020e0008/lvds-channel at 1 is not available

   It would have given the next kernel message as:

[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
...

Not sure what's going on there yet...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
