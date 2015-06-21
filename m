From: rogershimizu@gmail.com (Roger Shimizu)
Date: Mon, 22 Jun 2015 00:16:11 +0900
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl
In-Reply-To: <20150620160331.GG1116@lunn.ch>
References: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
 <1434713319-8691-2-git-send-email-rogershimizu@gmail.com>
 <20150619221448.GA1116@lunn.ch>
 <CAEQ9gEkSYtBtmzN3+0FXFeYJZfGFQNQz=nX+54LDTbniQREqPQ@mail.gmail.com>
 <20150620145108.GF1116@lunn.ch>
 <CAEQ9gEm9xi53oB+tOuJAcDVka-VtSc=vmU_MyKWzNMjKLeDgLw@mail.gmail.com>
 <20150620160331.GG1116@lunn.ch>
Message-ID: <CAEQ9gEkubRtcdDBuhJHpP0H=Qhc1KvG-4QAMbExopt786XbMuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

> No. The name in DT should not give the name of the interface. It
> should be possible to give this eth0 as expected, even if in DT it is
> eth1. The names here are separate things. The kernel will assign a
> name to the interface when it is registered to the network
> stack. Since this is the first registered interface, if should get the
> name eth0. What i think is happening is that something is later
> renaming the interface to eth1. We have to find out what is doing this
> rename.

Yes, I confirmed what you said is absolutely right.
Your detailed info is really appreciated. Thank you!

Now I changed the ethernet part of dts like the following:

+&mdio {
+       status = "okay";
+
+       ethphy1: ethernet-phy at 8 {
+               device_type = "ethernet-phy";
+               reg = <8>;
+       };
+};
+
+&eth1 {
+       status = "okay";
+
+       ethernet1-port at 0 {
+               phy-handle = <&ethphy1>;
+       };
+};

and dmesg is like:
[    0.237167] [Firmware Info]:
/ocp at f1000000/ethernet-controller at 76000/ethernet1-port at 0:
local-mac-address is not set
[    1.820596] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[    1.907565] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with
MAC address xx:xx:xx:xx:xx:xx
[    5.524704] mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 100
Mb/s, full duplex, flow control disabled

For other part of dts, I assume you agreed with my changes explained
in previous email.
If you feel alright, I'll make the similar changes to
"kirkwood-lswvl.dts", and submit the "PATCH v2" to you.
Thank you!

Cheers,
Roger
