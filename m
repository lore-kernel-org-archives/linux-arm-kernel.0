From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Mon, 08 Jun 2015 13:46:29 +0200
Subject: [ehci-orion] ETIMEOUT with ehci_setup()'s ehci_halt()
In-Reply-To: <5572E4E8.2060405@gmail.com>
References: <5571B38E.7080505@keymile.com> <20150605151930.GA16909@lunn.ch>
 <5572E4E8.2060405@gmail.com>
Message-ID: <55758095.2030609@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2015 02:17 PM, Sebastian Hesselbarth wrote:
> On 05.06.2015 17:19, Andrew Lunn wrote:
>> On Fri, Jun 05, 2015 at 04:34:54PM +0200, Valentin Longchamp wrote:
>>> I am currently bringing up the USB 2.0 Host controller of the Bobcat's (98DX4122
>>> Marvell switch) internal kirkwood CPU on a variation of Keymile's km_kirwood
>>> hardware (kirkwood-km_kirkwood.dts).
>>>
>>> When the driver registers its hcd, it fails with a timemout as it can be seen in
>>> the below log:
>>>
>>>> root at kmcoge5un:~# dmesg -n 8
>>>> root at kmcoge5un:~# insmod ehci-orion.ko
>>>> ehci-orion: EHCI orion driver
>>>> Initializing Orion-SoC USB Host Controller
>>>> orion-ehci f1050000.ehci: EHCI Host Controller
>>>> orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
>>>> orion-ehci f1050000.ehci: reset hcs_params 0x10011 dbg=0 ind cc=0 pcc=0 ordered ports=1
>>>> orion-ehci f1050000.ehci: reset hcc_params 0006 thresh 0 uframes 256/512/1024 park
>>>> orion-ehci f1050000.ehci: park 0
>>>> orion-ehci f1050000.ehci: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
>>>> orion-ehci f1050000.ehci: can't setup
>>>> orion-ehci f1050000.ehci: USB bus 1 deregistered
>>>> orion-ehci f1050000.ehci: init f1050000.ehci fail, -110
>>>> orion-ehci: probe of f1050000.ehci failed with error -110
>>>
>>> This is very similar to this problem, except that it always happens:
>>> https://lkml.org/lkml/2012/6/4/381
>>>
>>> I have cornered it out to the last handshake() call of the ehci_halt() call,
>>> that should set the controller in the HALT state. If I comment this handshake()
>>> call out, the registration is fine and the controller then looks OK (I don't
>>> have a hardware with a real USB bus to further test it yet).
> 
> Valentin,
> 
> can you specify what "real USB bus" means? Does your current hardware
> support USB host or device with anything connected to it?

No. The current hardware I am testing on does not support USB since the USB bus
is not "wired" at all, there is no phy present (this maybe causes a problem ?).
What I test is if the ehci-orion USB host driver is able to register with and
configure the USB host controller present in the SoC, in order to prepare things
for when the hardware is available.

Hopefully I get some new hardware prototypes where the USB bus is complete this
week so that I can test on the real setup.

> 
>>> My current idea is that maybe a reset or an initialization may be missing, but I
>>> wanted to ask if anybody already has seen a similar behavior with the various
>>> hardware platform supported by ehci-orion ?
> 
> You might want to tryout chipidea DRC too. We do need some mvebu boiler
> plate code to setup mbus registers but the IP definitely is chipidea.

OK, that's good to know, I will have a look at this driver and maybe I can find
a few differences there. ehci-orion is however stil the driver to use with this
platform, right ?

> 
>> Do you know what phy the 98DX4122 uses? The ehci-orion.c has some code
>> for handling the Orion5X USB phy. I also think u-boot might also have
>> some code. Sebastian might know more, i think he implemented USB
>> support for barebox.
> 
>  From my experiments with MVEBU usb phy's I recall that (at least on
> Armada 370/XP) ehci-orion will hang the system if PHYs are not setup by
> bootloader. I cannot recall what happened on KW.
> 

I tried to look if I found something in u-boot regarding USB and Kirkwood and
found nothing else that the USB_EHCI_MARVELL. With it enabled, u-boot is able to
init the controller and scan the "empty" bus, but it then does not help the
kernel to later probe the ehci-orion driver: it does not more that
ehci_orion_conf_mbus_windows() from ehci-orion).

Valentin
