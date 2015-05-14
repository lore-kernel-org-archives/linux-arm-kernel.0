From: binmlist@gmail.com (Bin Liu)
Date: Thu, 14 May 2015 15:03:04 -0500
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <20150514194924.GW24269@saruman.tx.rr.com>
References: <20150225111129.GA5062@lukather>
 <54EDBBEA.8030509@visionsystems.de>
 <20150514170700.GN24269@saruman.tx.rr.com>
 <20150514174031.GP24269@saruman.tx.rr.com>
 <20150514174907.GQ24269@saruman.tx.rr.com>
 <20150514190429.GT24269@saruman.tx.rr.com>
 <CADYTM3Zso8bV_8yFyx1-ATbL5AgkKBjvWWR4AsoZUNuLvFe1bQ@mail.gmail.com>
 <20150514192125.GU24269@saruman.tx.rr.com>
 <CADYTM3bbEAVefFZtivJf5Z+2Q+1zDZEvNhqE5ytsOxDX7hjbdA@mail.gmail.com>
 <20150514192946.GV24269@saruman.tx.rr.com>
 <20150514194924.GW24269@saruman.tx.rr.com>
Message-ID: <CADYTM3Y4AnpWKQ2MJfaKHLDey9OvzKwH6BxNetJz4KmhxewggQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

I can see the problem with 3.14.42 the current kernel I use right now.
See my other comments below.

On Thu, May 14, 2015 at 2:49 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, May 14, 2015 at 02:29:46PM -0500, Felipe Balbi wrote:
>> > >> >> > Even in this case, when I connect the device on the other end of the
>> > >> >> > cable, I still see some 3 seconds delay from the time device is
>> > >> >> > connected, to the time connect IRQ fires up.
>> > >> >>
>> > >> >> seems to be a problem with the USB stick I'm using. Tested two other
>> > >> >> devices and they connect right away.
>> > >> >
>> > >> > ok, fixing DRD on AM335x will take longer than I originally expected,
>> > >> > probably won't be ready for v4.2 :-(
>> > >>
>> > >> Are you able replicate the issue with TI AM335x GP EVM? I am wondering
>> > >> if the is custom board design problem? have you checked the custom
>> > >> board schematics?
>> > >
>> > > don't have either AM335x GP EVM nor schematics for this board. But it's
>> > > certainly not a problem with the board. It's very easy to replicate the
>> > > problem:
>> > >
>> > > Set dr-mode to otg, load g_zero, connect to PC and as quickly as you
>> > > can, remove cable and attach otg cable with a mouse or whatever on the
>> > > other end.
>> > >
>> > > First time, mouse won't enumerate (no IRQs fire) remove and connect
>> > > again. You should see a Babble IRQ.
>> >
>> > And this only happens with 3.16+, not older kernels? I have a GP EVM,
>> > and can try to take a look.
>>
>> yeah, if you can try with v4.1-rc3, that'd be great. I also see that
>> disconnect IRQ takes a while to fire, but VBUS drops rather fast on this
>> board (< 10ms to discharge VBUS).
>
> Here are some logs:

[snip]

> | [   53.162507] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0001 tx0000 rx0000
> | [   53.170201] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x1
> | [   53.176709] musb-hdrc musb-hdrc.1.auto: SUSPEND (b_peripheral) devctl 99
> | [   53.183760] musb-hdrc musb-hdrc.1.auto: devctl 99
> | [   53.188713] zero gadget: suspend
> | [   53.192111] zero gadget: zero_suspend
>
> Gadget driver suspended
>
> | [   59.289314] musb-hdrc musb-hdrc.1.auto: usbintr (20) epintr(0)
>
> 6.09 seconds later we get Disconnect IRQ (???????????). No idea what's
> going on here. Why 6 seconds for Disconnect IRQ to fire ?

I believe the Disconnect IRQ was because MUSB is already confused at
this time when the ID pin is grounded before it transition to b_idle.

If I don't connect the mouse after disconnect MUSB from host, I saw it
took about 30 sec for MUSB to transition from b_peripheral to b_idle
which is not right. I think we need to figure out why it takes that
long. Once MUSB can quickly get to b_idle, it should handle connect to
host or device properly.

Regards,
-Bin.

>
> | [   59.295494] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0020 tx0000 rx0000
> | [   59.303187] musb-hdrc musb-hdrc.1.auto: <== DevCtl=88, int_usb=0x20
> | [   59.309786] musb-hdrc musb-hdrc.1.auto: DISCONNECT (b_peripheral) as Peripheral, devctl 88
> | [   59.318482] musb-hdrc musb-hdrc.1.auto: devctl 88
> | [   59.323439] zero gadget: reset config
> | [   59.327312] musb-hdrc musb-hdrc.1.auto: ep1in request cf70d6c0, 512/4096 fault -108
> | [   59.336523] musb-hdrc musb-hdrc.1.auto: ep1in
> | [   59.341133] musb-hdrc musb-hdrc.1.auto: ep1out request ccdab040, 0/4096 fault -108
> | [   59.349106] musb-hdrc musb-hdrc.1.auto: ep1out
>
> Disconnect IRQ handled. All outstanding requests given back, etc.
>
> | [   61.281706] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
>
> ID pin polling restarts
>
> | [   63.281681] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
>
> again
>
> | [   65.281681] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
>
> again
>
> | [   67.281681] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
>
> again
>
> | [   69.281682] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
>
> again
>
> | [   69.340437] musb-hdrc musb-hdrc.1.auto: usbintr (100) epintr(0)
>
> ID pin grounded (DRVVBUS changed due to ID going low)
>
> | [   69.346711] musb-hdrc musb-hdrc.1.auto: VBUS on (a_wait_vrise), devctl 19
>
> VBUS goes on, a_wait_vrise
>
> | [   69.461549] musb-hdrc musb-hdrc.1.auto: usbintr (10) epintr(0)
>
> Connect IRQ. We're now HOST.
>
> | [   69.467726] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0010 tx0000 rx0000
> | [   69.474874] musb-hdrc musb-hdrc.1.auto: <== DevCtl=3d, int_usb=0x10
> | [   69.481531] musb-hdrc musb-hdrc.1.auto: CONNECT (a_host) devctl 3d
> | [   69.488158] usb usb2: usb wakeup-resume
> | [   69.492361] usb usb2: usb auto-resume
> | [   69.496228] musb-hdrc musb-hdrc.1.auto: root port reset stopped
> | [   69.502540] hub 2-0:1.0: hub_resume
> | [   69.506275] musb-hdrc musb-hdrc.1.auto: port status 00130303
> | [   69.544084] usb usb2-port1: status 0303 change 0013
> | [   69.549304] musb-hdrc musb-hdrc.1.auto: clear feature 1
> | [   69.559573] musb-hdrc musb-hdrc.1.auto: clear feature 16
> | [   69.569982] musb-hdrc musb-hdrc.1.auto: clear feature 17
> | [   69.580388] musb-hdrc musb-hdrc.1.auto: clear feature 20
> | [   69.691853] hub 2-0:1.0: state 7 ports 1 chg 0002 evt 0000
> | [   69.697734] musb-hdrc musb-hdrc.1.auto: port status 00000301
> | [   69.710670] usb usb2-port1: status 0301, change 0000, 1.5 Mb/s
> | [   69.717351] musb-hdrc musb-hdrc.1.auto: set feature 4
> | [   69.761823] musb-hdrc musb-hdrc.1.auto: root port reset stopped
> | [   69.769125] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   69.775185] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0004 tx0000 rx0000
> | [   69.782331] musb-hdrc musb-hdrc.1.auto: <== DevCtl=3d, int_usb=0x4
> | [   69.788835] musb-hdrc musb-hdrc.1.auto: Babble
> | [   69.793527] musb-hdrc musb-hdrc.1.auto: babble: MUSB_BABBLE_CTL value 44
> | [   69.800577] musb-hdrc musb-hdrc.1.auto: STUCK_J is reset
> | [   69.806269] musb-hdrc: setup fifo_mode 4
> | [   69.810413] musb-hdrc: 28/31 max ep, 16384/16384 memory
> | [   69.815915] musb-hdrc musb-hdrc.1.auto: <== devctl 98
> | [   69.821249] musb-hdrc musb-hdrc.1.auto: Longer idle timer already pending, ignoring...
> | [   69.829815] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(2)
> | [   69.835873] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0004 tx0002 rx0000
> | [   69.843015] musb-hdrc musb-hdrc.1.auto: <== DevCtl=91, int_usb=0x4
> | [   69.849519] musb-hdrc musb-hdrc.1.auto: BUS RESET as a_wait_bcon
> | [   69.855841] musb-hdrc musb-hdrc.1.auto: HNP: in a_wait_bcon, 1100 msec timeout
> | [   69.863450] musb-hdrc musb-hdrc.1.auto: extra TX1 ready, csr 0020
> | [   69.872017] musb-hdrc musb-hdrc.1.auto: port status 00010100
> | [   69.892140] musb-hdrc musb-hdrc.1.auto: clear feature 20
> | [   69.903680] musb-hdrc musb-hdrc.1.auto: clear feature 1
> | [   69.910942] musb-hdrc musb-hdrc.1.auto: clear feature 1
> | [   69.932876] hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0002
> | [   69.939031] musb-hdrc musb-hdrc.1.auto: port status 00010100
> | [   69.962046] musb-hdrc musb-hdrc.1.auto: clear feature 16
> | [   69.973216] usb usb2-port1: status 0100, change 0001, 12 Mb/s
> | [   69.979790] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   70.010452] musb-hdrc musb-hdrc.1.auto: usbintr (100) epintr(0)
> | [   70.016727] musb-hdrc musb-hdrc.1.auto: VBUS on (a_wait_vrise), devctl 19
> | [   70.042019] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   70.081874] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   70.121890] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   70.131541] musb-hdrc musb-hdrc.1.auto: usbintr (10) epintr(0)
> | [   70.137694] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0010 tx0000 rx0000
> | [   70.144839] musb-hdrc musb-hdrc.1.auto: <== DevCtl=3d, int_usb=0x10
> | [   70.151455] musb-hdrc musb-hdrc.1.auto: CONNECT (a_host) devctl 3d
> | [   70.163281] musb-hdrc musb-hdrc.1.auto: port status 00010301
> | [   70.169710] musb-hdrc musb-hdrc.1.auto: clear feature 16
> | [   70.221845] musb-hdrc musb-hdrc.1.auto: port status 00000301
> | [   70.261889] musb-hdrc musb-hdrc.1.auto: port status 00000301
> | [   70.301885] musb-hdrc musb-hdrc.1.auto: port status 00000301
> | [   70.341888] musb-hdrc musb-hdrc.1.auto: port status 00000301
> | [   70.348089] usb usb2-port1: debounce total 200ms stable 100ms status 0x301
> | [   70.355564] musb-hdrc musb-hdrc.1.auto: set feature 4
> | [   70.401782] musb-hdrc musb-hdrc.1.auto: root port reset stopped
> | [   70.421925] musb-hdrc musb-hdrc.1.auto: port status 00120303
> | [   70.481812] musb-hdrc musb-hdrc.1.auto: clear feature 20
> | [   70.487656] usb 2-1: new low-speed USB device number 3 using musb-hdrc
> | [   70.494695] musb-hdrc musb-hdrc.1.auto: qh ccde8cc0 urb ccdab040 dev0 ep0out, hw_ep 0, cf652340/8
> | [   70.504042] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev0 ep0out h_addr00 h_port00 bytes 8
> | [   70.513933] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf652340
> | [   70.521809] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   70.527255] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   70.533311] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   70.540461] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh ccde8cc0, count 0, urb ccdab040, stage 1
> | [   70.549886] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   70.555311] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   70.561363] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   70.568511] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8cc0, count 8, urb ccdab040, stage 2
> | [   70.577939] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cccdb040
> | [   70.585956] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   70.592012] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   70.599160] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh ccde8cc0, count 8, urb ccdab040, stage 2
> | [   70.608586] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cccdb048
> | [   70.616555] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   70.622609] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   70.629757] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8cc0, count 2, urb ccdab040, stage 2
> | [   70.639184] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 2 buf cccdb050
> | [   70.647056] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   70.653137] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   70.659190] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   70.666337] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh ccde8cc0, count 0, urb ccdab040, stage 4
> | [   70.675969] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev0 ep0in, 18/64
> | [   70.748464] musb-hdrc musb-hdrc.1.auto: set feature 4
> | [   70.791839] musb-hdrc musb-hdrc.1.auto: root port reset stopped
> | [   70.811925] musb-hdrc musb-hdrc.1.auto: port status 00120303
> | [   70.871811] musb-hdrc musb-hdrc.1.auto: clear feature 20
> | [   70.877702] musb-hdrc musb-hdrc.1.auto: qh ccde8cc0 urb ccdab040 dev0 ep0out, hw_ep 0, cccdb040/8
> | [   70.887051] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev0 ep0out h_addr00 h_port00 bytes 8
> | [   70.896943] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cccdb040
> | [   70.904818] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   70.910347] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   70.916408] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   70.923558] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh ccde8cc0, count 0, urb ccdab040, stage 1
> | [   70.932983] musb-hdrc musb-hdrc.1.auto: start no-DATA
> | [   70.938300] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0860
> | [   70.944365] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   70.950419] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   70.957566] musb-hdrc musb-hdrc.1.auto: <== csr0 0841, qh ccde8cc0, count 0, urb ccdab040, stage 4
> | [   70.967197] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev0 ep0out, 0/0
> | [   70.980094] musb-hdrc musb-hdrc.1.auto: HNP: Unhandled mode a_host
> | [   71.042069] musb-hdrc musb-hdrc.1.auto: qh ccde8ac0 urb ccdab040 dev3 ep0out, hw_ep 0, cf652340/8
> | [   71.051442] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   71.061345] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf652340
> | [   71.069220] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   71.074759] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.080821] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.087972] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh ccde8ac0, count 0, urb ccdab040, stage 1
> | [   71.097397] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   71.102825] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.108880] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.116029] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8ac0, count 8, urb ccdab040, stage 2
> | [   71.125458] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cccdb040
> | [   71.133461] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.139516] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.146664] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh ccde8ac0, count 8, urb ccdab040, stage 2
> | [   71.156090] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cccdb048
> | [   71.164055] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.170108] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.177255] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8ac0, count 2, urb ccdab040, stage 2
> | [   71.186680] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 2 buf cccdb050
> | [   71.194553] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   71.200600] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.206652] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.213798] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh ccde8ac0, count 0, urb ccdab040, stage 4
> | [   71.223428] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0in, 18/18
> | [   71.304075] musb-hdrc musb-hdrc.1.auto: qh ccde8ac0 urb ccdab040 dev3 ep0out, hw_ep 0, cf571d80/8
> | [   71.313389] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   71.323222] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf571d80
> | [   71.331056] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   71.336615] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.342676] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.349827] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh ccde8ac0, count 0, urb ccdab040, stage 1
> | [   71.359252] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   71.364678] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.370733] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.377880] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8ac0, count 8, urb ccdab040, stage 2
> | [   71.387308] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf652340
> | [   71.395273] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.401327] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.408473] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh ccde8ac0, count 1, urb ccdab040, stage 2
> | [   71.417900] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 1 buf cf652348
> | [   71.425772] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   71.431817] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.437871] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.445018] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh ccde8ac0, count 0, urb ccdab040, stage 4
> | [   71.454647] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0in, 9/9
> | [   71.521002] musb-hdrc musb-hdrc.1.auto: qh cf70d6c0 urb ccdab040 dev3 ep0out, hw_ep 0, cf621b00/8
> | [   71.530375] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   71.540268] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf621b00
> | [   71.548144] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   71.553738] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.559801] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.566953] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh cf70d6c0, count 0, urb ccdab040, stage 1
> | [   71.576378] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   71.581803] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.587855] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.595002] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cf70d6c0, count 8, urb ccdab040, stage 2
> | [   71.604430] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf571d80
> | [   71.612446] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.618503] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.625651] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh cf70d6c0, count 8, urb ccdab040, stage 2
> | [   71.635078] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf571d88
> | [   71.643083] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.649137] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.656284] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cf70d6c0, count 8, urb ccdab040, stage 2
> | [   71.665711] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf571d90
> | [   71.673691] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.679744] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.686891] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh cf70d6c0, count 8, urb ccdab040, stage 2
> | [   71.696317] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf571d98
> | [   71.704281] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.710333] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.717481] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cf70d6c0, count 2, urb ccdab040, stage 2
> | [   71.726907] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 2 buf cf571da0
> | [   71.734779] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   71.740821] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.746873] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.754020] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh cf70d6c0, count 0, urb ccdab040, stage 4
> | [   71.763646] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0in, 34/34
> | [   71.857582] usb 2-1: skipped 1 descriptor after interface
> | [   71.863555] musb-hdrc musb-hdrc.1.auto: qh cf70d6c0 urb ccdab040 dev3 ep0out, hw_ep 0, cf652340/8
> | [   71.872903] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   71.882793] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf652340
> | [   71.890669] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   71.896237] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.902298] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.909448] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh cf70d6c0, count 0, urb ccdab040, stage 1
> | [   71.918873] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   71.924299] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.930352] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.937500] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cf70d6c0, count 4, urb ccdab040, stage 2
> | [   71.946928] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 4 buf ccc4c700
> | [   71.954802] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   71.960849] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   71.966902] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   71.974048] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh cf70d6c0, count 0, urb ccdab040, stage 4
> | [   71.983678] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0in, 4/255
> | [   72.042307] usb 2-1: default language 0x0409
> | [   72.046898] musb-hdrc musb-hdrc.1.auto: qh ccde8cc0 urb ccdab040 dev3 ep0out, hw_ep 0, cf652340/8
> | [   72.056243] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   72.066134] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf652340
> | [   72.074009] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   72.079561] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.085622] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.092772] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh ccde8cc0, count 0, urb ccdab040, stage 1
> | [   72.102196] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   72.107624] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.113679] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.120826] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8cc0, count 8, urb ccdab040, stage 2
> | [   72.130255] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf ccc4c700
> | [   72.138240] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.144295] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.151441] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh ccde8cc0, count 8, urb ccdab040, stage 2
> | [   72.160866] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf ccc4c708
> | [   72.168848] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.174900] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.182047] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8cc0, count 8, urb ccdab040, stage 2
> | [   72.191473] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf ccc4c710
> | [   72.199471] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.205526] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.212673] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh ccde8cc0, count 8, urb ccdab040, stage 2
> | [   72.222100] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf ccc4c718
> | [   72.230065] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.236118] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.243265] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8cc0, count 4, urb ccdab040, stage 2
> | [   72.252691] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 4 buf ccc4c720
> | [   72.260563] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   72.266607] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.272659] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.279806] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh ccde8cc0, count 0, urb ccdab040, stage 4
> | [   72.289435] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0in, 36/255
> | [   72.384380] musb-hdrc musb-hdrc.1.auto: qh ccde8ac0 urb ccdab040 dev3 ep0out, hw_ep 0, cf731e00/8
> | [   72.393752] musb-hdrc musb-hdrc.1.auto: --> hw0 urb ccdab040 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   72.403644] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf731e00
> | [   72.411520] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   72.417101] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.423162] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.430312] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh ccde8ac0, count 0, urb ccdab040, stage 1
> | [   72.439737] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   72.445222] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.451278] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.458426] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh ccde8ac0, count 8, urb ccdab040, stage 2
> | [   72.467854] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf ccc4c700
> | [   72.475825] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.481878] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.489025] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh ccde8ac0, count 6, urb ccdab040, stage 2
> | [   72.498451] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 6 buf ccc4c708
> | [   72.506323] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   72.512369] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.518422] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.525568] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh ccde8ac0, count 0, urb ccdab040, stage 4
> | [   72.535198] musb-hdrc musb-hdrc.1.auto: complete ccdab040 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0in, 14/255
> | [   72.601553] usb 2-1: udev 3, busnum 2, minor = 130
> | [   72.606785] usb 2-1: New USB device found, idVendor=17ef, idProduct=602e
> | [   72.613929] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> | [   72.621442] usb 2-1: Product: USB Optical Mouse
> | [   72.626262] usb 2-1: Manufacturer: PixArt
> | [   72.650288] usb 2-1: usb_probe_device
> | [   72.654398] usb 2-1: configuration #1 chosen from 1 choice
>
> My mouse gets enumerated.
>
> | [   72.660309] musb-hdrc musb-hdrc.1.auto: qh ccde8ac0 urb cf70d6c0 dev3 ep0out, hw_ep 0, cf697040/8
> | [   72.669652] musb-hdrc musb-hdrc.1.auto: --> hw0 urb cf70d6c0 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   72.679544] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf697040
> | [   72.687420] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   72.692963] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.699023] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.706173] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh ccde8ac0, count 0, urb cf70d6c0, stage 1
> | [   72.715598] musb-hdrc musb-hdrc.1.auto: start no-DATA
> | [   72.720915] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0860
> | [   72.726977] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   72.733031] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   72.740178] musb-hdrc musb-hdrc.1.auto: <== csr0 0841, qh ccde8ac0, count 0, urb cf70d6c0, stage 4
> | [   72.749807] musb-hdrc musb-hdrc.1.auto: complete cf70d6c0 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0out, 0/0
> | [   72.823728] usb 2-1: adding 2-1:1.0 (config #1, interface 0)
> | [   72.845576] hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0002
> | [   72.851998] musb-hdrc musb-hdrc.1.auto: port status 00020303
> | [   72.885276] usb usb2-port1: enable change, status 00000303
> | [   72.891142] musb-hdrc musb-hdrc.1.auto: clear feature 17
> | [   73.013128] usbhid 2-1:1.0: usb_probe_interface
> | [   73.017944] usbhid 2-1:1.0: usb_probe_interface - got id
> | [   73.024791] musb-hdrc musb-hdrc.1.auto: qh cf628240 urb cf65ab40 dev3 ep0out, hw_ep 0, cf670240/8
> | [   73.034152] musb-hdrc musb-hdrc.1.auto: --> hw0 urb cf65ab40 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   73.044058] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf670240
> | [   73.051934] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   73.057439] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.063501] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.070651] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh cf628240, count 0, urb cf65ab40, stage 1
> | [   73.080076] musb-hdrc musb-hdrc.1.auto: start no-DATA
> | [   73.085394] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0860
> | [   73.091454] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.097510] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.104657] musb-hdrc musb-hdrc.1.auto: <== csr0 0a44, qh cf628240, count 0, urb cf65ab40, stage 4
> | [   73.114080] musb-hdrc musb-hdrc.1.auto: STALLING ENDPOINT
> | [   73.119760] musb-hdrc musb-hdrc.1.auto: aborting
> | [   73.124827] musb-hdrc musb-hdrc.1.auto: complete cf65ab40 usb_api_blocking_completion+0x0/0x14 [usbcore] (-32), dev3 ep0out, 0/0
> | [   73.196596] musb-hdrc musb-hdrc.1.auto: qh cccd5cc0 urb cf65ab40 dev3 ep0out, hw_ep 0, cf670240/8
> | [   73.205967] musb-hdrc musb-hdrc.1.auto: --> hw0 urb cf65ab40 spd1 dev3 ep0out h_addr00 h_port00 bytes 8
> | [   73.215861] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cf670240
> | [   73.223736] musb-hdrc musb-hdrc.1.auto: Start TX0 pio
> | [   73.229329] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.235392] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.242544] musb-hdrc musb-hdrc.1.auto: <== csr0 0200, qh cccd5cc0, count 0, urb cf65ab40, stage 1
> | [   73.251970] musb-hdrc musb-hdrc.1.auto: start IN-DATA
> | [   73.257396] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.263451] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.270598] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cccd5cc0, count 8, urb cf65ab40, stage 2
> | [   73.280026] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf670280
> | [   73.288035] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.294089] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.301237] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh cccd5cc0, count 8, urb cf65ab40, stage 2
> | [   73.310663] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf670288
> | [   73.318662] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.324716] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.331863] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cccd5cc0, count 8, urb cf65ab40, stage 2
> | [   73.341290] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf670290
> | [   73.349271] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.355324] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.362471] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh cccd5cc0, count 8, urb cf65ab40, stage 2
> | [   73.371897] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf670298
> | [   73.379877] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.385930] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.393077] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cccd5cc0, count 8, urb cf65ab40, stage 2
> | [   73.402503] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf6702a0
> | [   73.410545] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.416602] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.423750] musb-hdrc musb-hdrc.1.auto: <== csr0 0201, qh cccd5cc0, count 8, urb cf65ab40, stage 2
> | [   73.433176] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf cf6702a8
> | [   73.441208] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.447263] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.454411] musb-hdrc musb-hdrc.1.auto: <== csr0 0001, qh cccd5cc0, count 4, urb cf65ab40, stage 2
> | [   73.463838] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 4 buf cf6702b0
> | [   73.471711] musb-hdrc musb-hdrc.1.auto: ep0 STATUS, csr 0842
> | [   73.477766] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   73.483819] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
> | [   73.490966] musb-hdrc musb-hdrc.1.auto: <== csr0 0800, qh cccd5cc0, count 0, urb cf65ab40, stage 4
> | [   73.500603] musb-hdrc musb-hdrc.1.auto: complete cf65ab40 usb_api_blocking_completion+0x0/0x14 [usbcore] (0), dev3 ep0in, 52/52
> | [   73.621582] usbcore: registered new interface driver usbhid
> | [   73.627765] usbhid: USB HID core driver
> | [   73.673533] usbcore: registered new interface driver usbmouse
> | [   73.745972] input: PixArt USB Optical Mouse as /devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2/2-1/2-1:1.0/0003:17EF:602E.0001/input/input0
> | [   73.772055] hid-generic 0003:17EF:602E.0001: input: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-musb-hdrc.1.auto-1/input0
>
> Now I can use.
>
> | [   78.548836] musb-hdrc musb-hdrc.1.auto: usbintr (20) epintr(0)
>
> Disconnect came as soon as cable was disconnected. Host seems to be
> behave well.
>
> | [   78.555017] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0020 tx0000 rx0000
> | [   78.562162] musb-hdrc musb-hdrc.1.auto: <== DevCtl=19, int_usb=0x20
> | [   78.568761] musb-hdrc musb-hdrc.1.auto: DISCONNECT (a_host) as Host, devctl 19
> | [   78.576429] musb-hdrc musb-hdrc.1.auto: a_wait_bcon inactive, starting idle timer for 1100 ms
> | [   78.585610] hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0002
> | [   78.591477] musb-hdrc musb-hdrc.1.auto: port status 00010100
> | [   78.608263] musb-hdrc musb-hdrc.1.auto: clear feature 16
> | [   78.622870] usb usb2-port1: status 0100, change 0001, 12 Mb/s
> | [   78.629228] usb 2-1: USB disconnect, device number 3
> | [   78.634631] usb 2-1: unregistering device
> | [   78.638863] usb 2-1: unregistering interface 2-1:1.0
> | [   78.714884] usb 2-1: usb_disable_device nuking all URBs
> | [   78.787528] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   78.841801] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   78.881889] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   78.921897] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   78.961891] musb-hdrc musb-hdrc.1.auto: port status 00000100
> | [   78.968094] usb usb2-port1: debounce total 100ms stable 100ms status 0x100
> | [   78.979923] hub 2-0:1.0: hub_suspend
> | [   78.988603] usb usb2: bus auto-suspend, wakeup 1
> | [   78.993864] musb-hdrc musb-hdrc.1.auto: Root port suspended, power e0
> | [   79.000656] musb-hdrc musb-hdrc.1.auto: bogus rh suspend? a_wait_bcon
>
> Looks like we shouldn't be in a_wait_bcon here, but that's minor.
>
> | [   79.641702] musb-hdrc musb-hdrc.1.auto: Poll devctl 19 (a_wait_bcon)
> | [   81.641698] musb-hdrc musb-hdrc.1.auto: Poll devctl 90 (a_idle)
> | [   83.641708] musb-hdrc musb-hdrc.1.auto: Poll devctl 91 (b_idle)
> | [   85.641700] musb-hdrc musb-hdrc.1.auto: Poll devctl 91 (b_idle)
> | [   87.641679] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
> | [   89.641685] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
> | [   91.641705] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
> | [   93.167339] musb-hdrc musb-hdrc.1.auto: usbintr (1) epintr(0)
>
> Suspend IRQ. This really doesn't look correct, I'm connecting to my PC,
> why do I get a Suspend IRQ ? I should get a RESET!!!
>
> | [   93.173425] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0001 tx0000 rx0000
> | [   93.181121] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x1
> | [   93.187628] musb-hdrc musb-hdrc.1.auto: SUSPEND (b_idle) devctl 99
> | [   93.291687] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   93.297771] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   93.305465] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   93.311972] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_idle
>
> oh, it came later :-)
>
> | [   93.317839] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   93.402227] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   93.408311] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   93.416009] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   93.423159] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   93.431037] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0100 i0000 l64
> | [   93.437909] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   93.444974] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=18
> | [   93.452030] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 18 buf cccdcc00
> | [   93.459999] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  18/18
> | [   93.467250] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   93.473304] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   93.480997] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage out/status
> | [   93.488617] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   93.494668] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   93.502359] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   93.508864] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   93.515278] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   93.582191] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   93.588276] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   93.595974] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   93.603124] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   93.611001] musb-hdrc musb-hdrc.1.auto: SETUP req00.05 v0003 i0000 l0
> | [   93.617782] musb-hdrc musb-hdrc.1.auto: handled 1, csr 0001, ep0stage in/status
> | [   93.625676] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   93.631734] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   93.639427] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage in/status
> | [   93.647019] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   93.653073] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   93.660764] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   93.667270] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   93.673685] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   93.758996] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   93.765083] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   93.772778] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   93.779284] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   93.785700] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   93.970197] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   93.976283] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   93.983981] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   93.991132] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   93.999010] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0100 i0000 l64
> | [   94.005882] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   94.012948] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=18
> | [   94.020004] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 18 buf cccdcc00
> | [   94.027973] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  18/18
> | [   94.035217] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   94.041273] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   94.048964] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage out/status
> | [   94.056586] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   94.062636] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   94.070327] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   94.076832] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   94.083246] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   94.202208] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   94.208296] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   94.215994] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   94.223144] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   94.231021] musb-hdrc musb-hdrc.1.auto: SETUP req00.05 v0018 i0000 l0
> | [   94.237801] musb-hdrc musb-hdrc.1.auto: handled 1, csr 0001, ep0stage in/status
> | [   94.245587] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   94.251640] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   94.259332] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage in/status
> | [   94.266861] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   94.272911] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   94.280603] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   94.287107] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   94.293522] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   94.782721] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   94.788806] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   94.796500] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   94.803005] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   94.809421] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   94.890213] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   94.896300] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   94.903998] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   94.911149] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   94.919026] musb-hdrc musb-hdrc.1.auto: SETUP req00.05 v001f i0000 l0
> | [   94.925807] musb-hdrc musb-hdrc.1.auto: handled 1, csr 0001, ep0stage in/status
> | [   94.933724] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   94.939782] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   94.947476] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage in/status
> | [   95.070195] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.076280] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.083979] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage idle
> | [   95.091038] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   95.098916] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0100 i0000 l8
> | [   95.105697] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.112762] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=8
> | [   95.119727] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 8 buf cccdcc00
> | [   95.127604] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  8/8
> | [   95.134681] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.140736] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.148429] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage out/status
> | [   95.156030] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   95.163905] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0100 i0000 l18
> | [   95.170775] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.177830] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=18
> | [   95.184884] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 18 buf cccdcc00
> | [   95.192850] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  18/18
> | [   95.200069] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.206123] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.213815] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage out/status
> | [   95.221416] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9d30
> | [   95.229291] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0200 i0000 l9
> | [   95.236069] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.243131] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=9
> | [   95.250094] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 9 buf cccdcc00
> | [   95.257968] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  9/9
> | [   95.264950] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.271000] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.278692] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage out/status
> | [   95.286293] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9d30
> | [   95.294168] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0200 i0000 l69
> | [   95.301037] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.308094] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=69
> | [   95.315146] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 64 buf cccdcc00
> | [   95.323130] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.329180] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.336871] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage in
> | [   95.343741] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 5 buf cccdcc40
> | [   95.351615] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  69/69
> | [   95.358803] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.364855] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.372546] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage out/status
> | [   95.380146] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   95.388021] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0201 i0000 l9
> | [   95.394799] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.401855] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=9
> | [   95.408818] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 9 buf cccdcc00
> | [   95.416692] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  9/9
> | [   95.423692] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.429743] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.437435] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage out/status
> | [   95.445036] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9d38
> | [   95.452911] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0201 i0000 l32
> | [   95.459780] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.466836] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=32
> | [   95.473889] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 32 buf cccdcc00
> | [   95.481855] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  32/32
> | [   95.489019] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.495069] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.502761] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage out/status
> | [   95.510361] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9d38
> | [   95.518236] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0300 i0000 l255
> | [   95.525196] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.532256] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=4
> | [   95.539219] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 4 buf cccdcc00
> | [   95.547094] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  4/4
> | [   95.554074] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   95.560124] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   95.567816] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage out/status
> | [   95.575416] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9d38
> | [   95.583291] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0302 i0409 l255
> | [   95.590251] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   95.597311] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=24
> | [   95.604365] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 24 buf cccdcc00
> | [   95.612330] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  24/24
> | [   95.619494] musb-hdrc musb-hdrc.1.auto: usbintr (1) epintr(1)
> | [   95.625543] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0001 tx0001 rx0000
> | [   95.633234] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x1
> | [   95.639740] musb-hdrc musb-hdrc.1.auto: SUSPEND (b_peripheral) devctl 99
> | [   95.646792] musb-hdrc musb-hdrc.1.auto: devctl 99
> | [   95.651742] zero gadget: suspend
> | [   95.655140] zero gadget: zero_suspend
>
> Cable removed, got a suspend, not disconnect.
>
> | [   95.659078] musb-hdrc musb-hdrc.1.auto: csr 000a, count 0, ep0stage out/status
> | [   95.666705] musb-hdrc musb-hdrc.1.auto: Poll devctl 99 (b_peripheral)
> | [   98.115605] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   98.121692] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   98.129387] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   98.135893] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   98.142308] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   98.226208] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   98.232294] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   98.239993] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   98.247144] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   98.255021] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0100 i0000 l64
> | [   98.261892] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   98.268958] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=18
> | [   98.276014] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 18 buf cccdcc00
> | [   98.283983] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  18/18
> | [   98.291233] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   98.297286] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   98.304979] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage out/status
> | [   98.312599] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   98.318649] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   98.326341] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   98.332846] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   98.339261] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   98.458184] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   98.464269] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   98.471967] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   98.479117] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   98.486994] musb-hdrc musb-hdrc.1.auto: SETUP req00.05 v0007 i0000 l0
> | [   98.493773] musb-hdrc musb-hdrc.1.auto: handled 1, csr 0001, ep0stage in/status
> | [   98.501558] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   98.507612] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   98.515304] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage in/status
> | [   98.522835] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   98.528887] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   98.536578] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   98.543084] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   98.549499] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   98.631016] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   98.637103] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   98.644798] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   98.651304] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   98.657720] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   98.842197] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   98.848279] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   98.855977] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   98.863128] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   98.871006] musb-hdrc musb-hdrc.1.auto: SETUP req80.06 v0100 i0000 l64
> | [   98.877878] musb-hdrc musb-hdrc.1.auto: handled 0, csr 0001, ep0stage in
> | [   98.884943] musb-hdrc musb-hdrc.1.auto: queue to ep0 (OUT/RX), length=18
> | [   98.891998] musb-hdrc musb-hdrc.1.auto: TX ep0 fifo d1a82c20 count 18 buf cccdcc00
> | [   98.899967] musb-hdrc musb-hdrc.1.auto: ep0 done request ccdde140,  18/18
> | [   98.907214] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   98.913267] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   98.920960] musb-hdrc musb-hdrc.1.auto: csr 0000, count 0, ep0stage out/status
> | [   98.928580] musb-hdrc musb-hdrc.1.auto: usbintr (4) epintr(0)
> | [   98.934630] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0004 tx0000 rx0000
> | [   98.942321] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x4
> | [   98.948826] musb-hdrc musb-hdrc.1.auto: BUS RESET as b_peripheral
> | [   98.955240] musb-hdrc musb-hdrc.1.auto: <== B-Device driver 'zero'
> | [   99.022183] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
> | [   99.028268] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0000 tx0001 rx0000
> | [   99.035965] musb-hdrc musb-hdrc.1.auto: csr 0001, count 8, ep0stage setup
> | [   99.043116] musb-hdrc musb-hdrc.1.auto: RX ep0 fifo d1a82c20 count 8 buf c08e9e00
> | [   99.050993] musb-hdrc musb-hdrc.1.auto: SETUP req00.05 v0017 i0000 l0
> | [   99.057774] musb-hdrc musb-hdrc.1.auto: handled 1, csr 0001, ep0stage in/status
> | [   99.068569] musb-hdrc musb-hdrc.1.auto: usbintr (1) epintr(0)
> | [   99.074650] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0001 tx0000 rx0000
> | [   99.082344] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x1
> | [   99.088851] musb-hdrc musb-hdrc.1.auto: SUSPEND (b_peripheral) devctl 99
> | [   99.095903] musb-hdrc musb-hdrc.1.auto: devctl 99
> | [   99.100856] zero gadget: suspend
> | [   99.104254] zero gadget: zero_suspend
>
> cable removed.
>
> | [  105.194553] musb-hdrc musb-hdrc.1.auto: usbintr (20) epintr(0)
>
> Again 6 seconds to get Disconnect.
>
> | [  105.200733] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0020 tx0000 rx0000
> | [  105.208426] musb-hdrc musb-hdrc.1.auto: <== DevCtl=88, int_usb=0x20
> | [  105.215026] musb-hdrc musb-hdrc.1.auto: DISCONNECT (b_peripheral) as Peripheral, devctl 88
> | [  105.223721] musb-hdrc musb-hdrc.1.auto: devctl 88
> | [  107.191676] musb-hdrc musb-hdrc.1.auto: Poll devctl 88 (b_idle)
>
> Any ideas ?
>
> --
> balbi
