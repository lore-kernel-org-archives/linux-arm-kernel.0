From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Jan 2013 12:07:12 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <20130107094747.GR3392@lunn.ch>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch> <20130104183139.20492204@skate>
 <50E71356.3030203@lunn.ch> <20130104190345.460151d1@skate>
 <50E9EE7A.1080301@free-electrons.com>
 <20130106235312.0839a879@skate> <20130107094747.GR3392@lunn.ch>
Message-ID: <20130107110712.GT3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 10:47:47AM +0100, Andrew Lunn wrote:
> On Sun, Jan 06, 2013 at 11:53:12PM +0100, Thomas Petazzoni wrote:
> > Dear Gregory CLEMENT,
> > 
> > On Sun, 06 Jan 2013 22:36:58 +0100, Gregory CLEMENT wrote:
> > 
> > > Until now I didn't notice any problem on this board with the 3GB enable.
> > > 
> > > I made more tests since I received this email, I booted (cold and hot boot)
> > > the board dozens of times, and indeed every 5 or 10 reboot the kernel hanged
> > > during boot at line:
> > > "UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)"
> > 
> > I think it hangs at the same place here.
> > 
> > > After applying your patch, I didn't notice any hang after 20 boots. Do you
> > > have a test pattern which make the kernel to hang each time to be sure that
> > > it is the root of the problem?
> > 
> > No, I don't have a specific pattern. It just hangs from time to time.
> > Maybe 1 boot out of 5 or something like that. And it just hangs like it
> > did for you.
> 
> Hi Thomas, Gregory
> 
> I've been testing my board some more, using the PlatHome kernel
> installed on the device as i received it. I've rebooted the device 20
> times and not had a single problem.
> 
> I will now swap to a mainline kernel, 3.8-rc2 plus UART patch.

Hi Thomas, Gregory

So, twenty reboots later, no problems at all with 3.8-rc2. Got to
user space every time.

So, what are we doing differently?

BootROM 1.15
Booting from NOR flash
DDR3 Training Sequence - Ver 2.5.DDR3 Training Sequence - Registered DIMM WL -  
BootROM: Image checksum verification PASSED
 ** LOADER **


U-Boot 2009.08 (Jul 27 2012 - 18:23:11)
Plat'Home version: 1.1.1 (Base: Marvell BSP  2.2.3 NQ)

Do you have the same version?

I'm tftpbooting:

setenv bootargs root=/dev/ram console=ttyS0,115200 earlyprintk ; tftpboot 0x80000000 openblocks-dev; bootm

My image contain the kernel and a buildroot rootfs included within the
kernel image and DT is appended. I load it to address 0x80000000,
which puts it at the beginning of CS 3:

DRAM:   3 GB
       CS 0: base 0x00000000 size  1 GB
       CS 2: base 0x40000000 size  1 GB
       CS 3: base 0x80000000 size  1 GB

Thanks
	Andrew
