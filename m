From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 5 Jun 2015 17:19:30 +0200
Subject: [ehci-orion] ETIMEOUT with ehci_setup()'s ehci_halt()
In-Reply-To: <5571B38E.7080505@keymile.com>
References: <5571B38E.7080505@keymile.com>
Message-ID: <20150605151930.GA16909@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 04:34:54PM +0200, Valentin Longchamp wrote:
> Hello,
> 
> I am currently bringing up the USB 2.0 Host controller of the Bobcat's (98DX4122
> Marvell switch) internal kirkwood CPU on a variation of Keymile's km_kirwood
> hardware (kirkwood-km_kirkwood.dts).
> 
> When the driver registers its hcd, it fails with a timemout as it can be seen in
> the below log:
> 
> > root at kmcoge5un:~# dmesg -n 8
> > root at kmcoge5un:~# insmod ehci-orion.ko 
> > ehci-orion: EHCI orion driver
> > Initializing Orion-SoC USB Host Controller
> > orion-ehci f1050000.ehci: EHCI Host Controller
> > orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
> > orion-ehci f1050000.ehci: reset hcs_params 0x10011 dbg=0 ind cc=0 pcc=0 ordered ports=1
> > orion-ehci f1050000.ehci: reset hcc_params 0006 thresh 0 uframes 256/512/1024 park
> > orion-ehci f1050000.ehci: park 0
> > orion-ehci f1050000.ehci: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
> > orion-ehci f1050000.ehci: can't setup
> > orion-ehci f1050000.ehci: USB bus 1 deregistered
> > orion-ehci f1050000.ehci: init f1050000.ehci fail, -110
> > orion-ehci: probe of f1050000.ehci failed with error -110
> 
> This is very similar to this problem, except that it always happens:
> https://lkml.org/lkml/2012/6/4/381
> 
> I have cornered it out to the last handshake() call of the ehci_halt() call,
> that should set the controller in the HALT state. If I comment this handshake()
> call out, the registration is fine and the controller then looks OK (I don't
> have a hardware with a real USB bus to further test it yet).
> 
> My current idea is that maybe a reset or an initialization may be missing, but I
> wanted to ask if anybody already has seen a similar behavior with the various
> hardware platform supported by ehci-orion ?

Hi Valentin

I don't remember seeing any problems like this on any kirkwood
devices.

Do you know what phy the 98DX4122 uses? The ehci-orion.c has some code
for handling the Orion5X USB phy. I also think u-boot might also have
some code. Sebastian might know more, i think he implemented USB
support for barebox.

	Andrew
