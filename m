From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 5 Nov 2017 09:41:52 +0800
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
In-Reply-To: <CAK8P3a1oP98K3mzK3MfFvJ27y5fgYsTnOdPpjukQGXOLAQYhyA@mail.gmail.com>
References: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
 <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
 <1509423579.10793.10.camel@mtkswgap22>
 <e8fdd9a9-ce13-8804-aea0-46becc6f9730@gmail.com>
 <CAK8P3a0+9fChSbObS9boR8okHtO8u8_hr2Te+RjfRD0T54QYWQ@mail.gmail.com>
 <1509673038.19220.19.camel@mtkswgap22>
 <CAK8P3a1doHCH4ucC1AUR5HiH5qvMXeoqsav-9dsvhM2KPh3FNw@mail.gmail.com>
 <1509709967.15691.25.camel@mtkswgap22>
 <CAK8P3a1oP98K3mzK3MfFvJ27y5fgYsTnOdPpjukQGXOLAQYhyA@mail.gmail.com>
Message-ID: <1509846112.26038.22.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-11-03 at 16:21 +0100, Arnd Bergmann wrote:
> On Fri, Nov 3, 2017 at 12:52 PM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > On Fri, 2017-11-03 at 10:40 +0100, Arnd Bergmann wrote:
> >> On Fri, Nov 3, 2017 at 2:37 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> >> This should have the exact same effect as what you have in your tree,
> >> but if that works,
> >> we can merge that version and try to figure out why the kernel thinks
> >> they are different.
> >
> > I've tried this approach by using the 4-ports network card and got the
> > result:
> > pcieport 0000:00:01.0: assign IRQ: got 220
> > pcieport 0000:00:01.0: assigning IRQ 220
> > pcieport 0000:00:01.0: enabling device (0140 -> 0142)
> > pcieport 0000:00:01.0: enabling bus mastering
> > pcieport 0000:00:01.0: Signaling PME with IRQ 220
> > ....
> > igb 0000:01:00.0: assign IRQ: got 221
> > igb 0000:01:00.0: assigning IRQ 221
> > igb 0000:01:00.1: assign IRQ: got 221
> > igb 0000:01:00.1: assigning IRQ 221
> > igb 0000:01:00.2: assign IRQ: got 221
> > igb 0000:01:00.2: assigning IRQ 221
> > igb 0000:01:00.3: assign IRQ: got 221
> > igb 0000:01:00.3: assigning IRQ 221
> >
> > I think slot 1 should share its IRQ (220) with every device in the
> > hierarchy below this root port.
> 
> Agreed, that is what I expected, too. I've looked at the of_pci_irq.c
> in more detail but couldn't come up with what happened. Can you
> try running with this patch or something like that to figure out where
> it takes the wrong turn?
> 
> https://pastebin.com/MrMzwcmw
> 

[    4.466527] pcieport 0000:00:01.0: swizzle found slot 1 pin 1
[    4.472252] pcieport 0000:00:01.0: direct parse found irq
3747445820:3747445848
[    4.479515] pcieport 0000:00:01.0: parse pin 1
[    4.483920] null ppdev, node dfff3744, pin 1
[    4.488151] null ppdev, parse node dfff3744 pin 1
[    4.492825] of_irq_parse_raw:  /pcie-controller at 1a140000:00000001
[    4.498885] OF: of_irq_parse_raw: ipar=/pcie-controller at 1a140000,
size=1
[    4.505530] OF:  -> addrsize=3
[    4.508569] OF:  -> match=0 (imaplen=92)
[    4.512481] OF:  -> newintsize=3, newaddrsize=0
[    4.516969] OF:  -> imaplen=88
[    4.520007] OF:  -> match=0 (imaplen=84)
[    4.523899] OF:  -> newintsize=3, newaddrsize=0
[    4.528400] OF:  -> imaplen=80
[    4.531425] OF:  -> match=0 (imaplen=76)
[    4.535317] OF:  -> newintsize=3, newaddrsize=0
[    4.539817] OF:  -> imaplen=72
[    4.542842] OF:  -> match=0 (imaplen=68)
[    4.546734] OF:  -> newintsize=3, newaddrsize=0
[    4.551234] OF:  -> imaplen=64
[    4.554259] OF:  -> match=1 (imaplen=60)
[    4.558151] OF:  -> newintsize=3, newaddrsize=0
[    4.562651] OF:  -> imaplen=56
[    4.565676] OF:  -> new parent: /interrupt-controller at 10200100
[    4.571469] OF:  -> got it !
[    4.574322] null ppdev, parse node dfff3744 irq 0:194
[    4.579413] pcieport 0000:00:01.0: assign IRQ: got 220

[    4.613400] igb 0000:01:00.0: swizzle pin 1
[    4.617551] pcieport 0000:00:01.0: swizzle found slot 1 pin 1
[    4.623276] igb 0000:01:00.0: parse pin 1
[    4.627251] pcieport 0000:00:01.0: node dfff3e6c pin 1
[    4.632359] pcieport 0000:00:01.0: parse node dfff3e6c pin 1
[    4.637970]
of_irq_parse_raw:  /pcie-controller at 1a140000/pcie at 1,0:00000001
[    4.644807] OF: of_irq_parse_raw: ipar=/pcie-controller at 1a140000,
size=1
[    4.651463] OF:  -> addrsize=3
[    4.654491] OF:  -> match=1 (imaplen=92)
[    4.658404] OF:  -> newintsize=3, newaddrsize=0
[    4.662893] OF:  -> imaplen=88
[    4.665917] OF:  -> new parent: /interrupt-controller at 10200100
[    4.671711] OF:  -> got it !
[    4.674567] pcieport 0000:00:01.0: parse node dfff3e6c irq 0:193
[    4.680596] igb 0000:01:00.0: assign IRQ: got 221

[    4.806020] igb 0000:01:00.1: swizzle pin 2
[    4.810201] pcieport 0000:00:01.0: swizzle found slot 1 pin 2
[    4.815902] igb 0000:01:00.1: parse pin 2
[    4.819891] pcieport 0000:00:01.0: node dfff3e6c pin 2
[    4.824987] pcieport 0000:00:01.0: parse node dfff3e6c pin 2
[    4.830609]
of_irq_parse_raw:  /pcie-controller at 1a140000/pcie at 1,0:00000002
[    4.837437] OF: of_irq_parse_raw: ipar=/pcie-controller at 1a140000,
size=1
[    4.844093] OF:  -> addrsize=3
[    4.847121] OF:  -> match=0 (imaplen=92)
[    4.851042] OF:  -> newintsize=3, newaddrsize=0
[    4.855532] OF:  -> imaplen=88
[    4.858570] OF:  -> match=1 (imaplen=84)
[    4.862463] OF:  -> newintsize=3, newaddrsize=0
[    4.866952] OF:  -> imaplen=80
[    4.869988] OF:  -> new parent: /interrupt-controller at 10200100
[    4.875769] OF:  -> got it !
[    4.878637] pcieport 0000:00:01.0: parse node dfff3e6c irq 0:193
[    4.884601] igb 0000:01:00.1: assign IRQ: got 221


But if I add "interrupt-map properties" in both the pcie controller and
its child node:

[    4.466979] pcieport 0000:00:01.0: swizzle found slot 1 pin 1
[    4.472705] pcieport 0000:00:01.0: direct parse found irq
3747437628:3747437656
[    4.479969] pcieport 0000:00:01.0: parse pin 1
[    4.484372] null ppdev, node dfff3570, pin 1
[    4.488603] null ppdev, parse node dfff3570 pin 1
[    4.493278] of_irq_parse_raw:  /pcie-controller at 1a140000:00000001
[    4.499338] OF: of_irq_parse_raw: ipar=/pcie-controller at 1a140000,
size=1
[    4.505983] OF:  -> addrsize=3
[    4.509023] OF:  -> match=0 (imaplen=20)
[    4.512935] OF:  -> newintsize=3, newaddrsize=0
[    4.517424] OF:  -> imaplen=16
[    4.520464] OF:  -> match=1 (imaplen=12)
[    4.524356] OF:  -> newintsize=3, newaddrsize=0
[    4.528857] OF:  -> imaplen=8
[    4.531797] OF:  -> new parent: /interrupt-controller at 10200100
[    4.537578] OF:  -> got it !
[    4.540442] null ppdev, parse node dfff3570 irq 0:194
[    4.545534] pcieport 0000:00:01.0: assign IRQ: got 220

[    4.579510] igb 0000:01:00.0: swizzle pin 1
[    4.583660] pcieport 0000:00:01.0: swizzle found slot 1 pin 1
[    4.589384] igb 0000:01:00.0: parse pin 1
[    4.593359] pcieport 0000:00:01.0: node dfff3d34 pin 1
[    4.598453] pcieport 0000:00:01.0: parse node dfff3d34 pin 1
[    4.604080]
of_irq_parse_raw:  /pcie-controller at 1a140000/pcie at 1,0:00000001
[    4.610918] OF: of_irq_parse_raw:
ipar=/pcie-controller at 1a140000/pcie at 1,0, size=1
[    4.618337] OF:  -> addrsize=3
[    4.621377] OF:  -> match=1 (imaplen=4)
[    4.625193] OF:  -> newintsize=3, newaddrsize=0
[    4.629695] OF:  -> imaplen=0
[    4.632633] OF:  -> new parent: /interrupt-controller at 10200100
[    4.638414] OF:  -> got it !
[    4.641282] pcieport 0000:00:01.0: parse node dfff3d34 irq 0:194
[    4.647242] igb 0000:01:00.0: assign IRQ: got 220

[    4.772710] igb 0000:01:00.1: swizzle pin 2
[    4.776860] pcieport 0000:00:01.0: swizzle found slot 1 pin 2
[    4.782583] igb 0000:01:00.1: parse pin 2
[    4.786559] pcieport 0000:00:01.0: node dfff3d34 pin 2
[    4.791668] pcieport 0000:00:01.0: parse node dfff3d34 pin 2
[    4.834485] pcieport 0000:00:01.0: parse node dfff3d34 irq 0:194
[    4.840460] igb 0000:01:00.1: assign IRQ: got 220

I'm trying to understand what happened in the walking function.

Ryder
