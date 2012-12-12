From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Dec 2012 21:43:05 +0100
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <50C8E2A9.7020802@gmail.com>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net>
 <50C681B0.4030801@gmail.com> <20121211161557.6819daa9@skate>
 <50C7A25A.2090602@gmail.com> <20121212093103.2f29494d@skate>
 <50C8E2A9.7020802@gmail.com>
Message-ID: <20121212214305.27e351c8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bernd,

On Wed, 12 Dec 2012 21:01:45 +0100, Bernd wrote:

> Having to create the uImage manually is not so bad, IMO. The address
> (0x00008000) seems to be a 'magic number', though, so I think the
> process of creating a uImage for a particular box should be
> documented.

Well, actually, I *think* it could potentially be any address that fits
within the DRAM, since we use AUTO_ZRELADDR. But I have never tested.

> Meanwhile, I am struggling with the next issue which is getting the
> kernel to recognize and mount any root filesystem on the mirabox.
> Preferably I would like to use an SD card in the internal card reader
> for it. The factory kernel accesses the card reader via USB, so I
> assume I need to get USB working for that in mainline, too.
> Alternatively, I would use the built-in flash memory which the
> factory kernel accesses via MTD. So far I am out of luck ("Kernel
> panic - not syncing: VFS: Unable to mount root fs...") as I don't
> know whether drivers for any of the devices are available in mainline
> already and, if yes, which ones I need to enable in config for that.
> 
> Is this information available somewhere?

The SD card readers in the Mirabox are controlled by a controller on
the USB bus, and we haven't enabled the USB controller of the Marvell
SoC on the Mirabox yet. (Note that the USB controller of the Marvell
SoC is *not* the one that controls the USB ports on the back of the
Mirabox: those USB 3.0 ports are controlled by a USB 3.0 controller on
the PCIe port).

For now, your choices of root filesystem solutions are:

 * initramfs (this is what most of us are doing to bring up those
   platforms)

 * root over NFS, since we have network support for the Mirabox

 * USB key on one of the USB 3.0 ports, but that requires you to apply
   the 16 patches patch set I've sent last Friday on the LAKML to
   enable the PCIe interfaces of the Armada 370.

Hope this helps,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
