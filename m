From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 8 May 2017 21:07:50 +0200
Subject: [PATCH 0/4] TI Bluetooth serdev support
In-Reply-To: <CAHCN7x+Mq=b6RN-ezU0400W=H=D7DR+Es1FHtT4GyozpVd8ALA@mail.gmail.com>
References: <20170405183005.20570-1-robh@kernel.org>
 <CAHCN7xJUxZm1qKAxT0kaK6qoDg+HWOJK7sTH-q9za4HJuUwe8Q@mail.gmail.com>
 <20170430160430.rmyuo6sdrkrjxjg6@earth>
 <CAHCN7x+Mq=b6RN-ezU0400W=H=D7DR+Es1FHtT4GyozpVd8ALA@mail.gmail.com>
Message-ID: <20170508190749.sev2wtecjnaneyng@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 05, 2017 at 09:51:33AM -0500, Adam Ford wrote:
> On Sun, Apr 30, 2017 at 11:04 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Sun, Apr 30, 2017 at 10:14:20AM -0500, Adam Ford wrote:
> >> On Wed, Apr 5, 2017 at 1:30 PM, Rob Herring <robh@kernel.org> wrote:
> >> > This series adds serdev support to the HCI LL protocol used on TI BT
> >> > modules and enables support on HiKey board with with the WL1835 module.
> >> > With this the custom TI UIM daemon and btattach are no longer needed.
> >>
> >> Without UIM daemon, what instruction do you use to load the BT firmware?
> >>
> >> I was thinking 'hciattach' but I was having trouble.  I was hoping you
> >> might have some insight.
> >>
> >>  hciattach -t 30 -s 115200 /dev/ttymxc1 texas 3000000 flow  Just
> >> returns a timeout.
> >>
> >> I modified my i.MX6 device tree per the binding documentation and
> >> setup the regulators and enable GPIO pins.
> >
> > If you configured everything correctly no userspace interaction is
> > required. The driver should request the firmware automatically once
> > you power up the bluetooth device.
> >
> > Apart from DT changes make sure, that the following options are
> > enabled and check dmesg for any hints.
> >
> > CONFIG_SERIAL_DEV_BUS
> > CONFIG_SERIAL_DEV_CTRL_TTYPORT
> > CONFIG_BT_HCIUART
> > CONFIG_BT_HCIUART_LL
> 
> I have enabled those flags, and I have updated my device tree.
> I am testing this on an OMAP3630 (DM3730) board with a WL1283.  I am
> getting a lot of timeout errors.  I tested this against the original
> implemention I had in pdata-quirks.c using the ti-st driver, uim & and
> the btwilink driver.
> 
> I pulled in some of the newer patches to enable the wl1283-st, but I
> am obviously missing something.
> 
> I   58.717651] Bluetooth: hci0: Reading TI version information failed
> (-110)
> [   58.724853] Bluetooth: hci0: download firmware failed, retrying...
> [   60.957641] Bluetooth: hci0 command 0x1001 tx timeout
> [   68.957641] Bluetooth: hci0: Reading TI version information failed
> (-110)
> [   68.964843] Bluetooth: hci0: download firmware failed, retrying...
> [   69.132171] Bluetooth: Unknown HCI packet type 06
> [   69.138244] Bluetooth: Unknown HCI packet type 0c
> [   69.143249] Bluetooth: Unknown HCI packet type 40
> [   69.148498] Bluetooth: Unknown HCI packet type 20
> [   69.153533] Bluetooth: Data length is too large
> [   69.158569] Bluetooth: Unknown HCI packet type a0
> [   69.163574] Bluetooth: Unknown HCI packet type 00
> [   69.168731] Bluetooth: Unknown HCI packet type 00
> [   69.173736] Bluetooth: Unknown HCI packet type 34
> [   69.178924] Bluetooth: Unknown HCI packet type 91
> [   71.197631] Bluetooth: hci0 command 0x1001 tx timeout
> [   79.197662] Bluetooth: hci0: Reading TI version information failed (-110)
>
> Since the pdata-quirks and original ti-st drivers work together, I
> know the hardware is fine.  The only change to the device tree is the
> addition of the Bluetooth container:
> 
> bluetooth {
>   compatible = "ti,wl1283-st";
>   enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
> };
> 
> Any thoughts or suggestions to try? I get similar behavior on an
> i.MX6 board with a wl1837-st module as well.

Looks like its loosing bytes. I suggest to have a look at
pinmuxing (esp. for cts & rts) and maybe add some debug
prints to see where it starts failing.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170508/cadc0608/attachment.sig>
