From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 28 Aug 2017 20:18:58 +0800
Subject: [PATCH v2] arm64: allwinner: h5: add support for NanoPi NEO Plus 2
In-Reply-To: <20170828121644.p7mknytubsajzctg@AntonyAntony.local>
References: <20170824231716.2623-1-antony@phenome.org>
 <20170825103242.5665-1-antony@phenome.org>
 <CAEKpxBkUKGUQR2Vh1+Ci4wbB-+x48nRjLmWME2EUECCHuuwsmQ@mail.gmail.com>
 <20170828121644.p7mknytubsajzctg@AntonyAntony.local>
Message-ID: <BF2F26DC-7014-4AF6-9C02-D1038A0FDA38@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?8?28? GMT+08:00 ??8:16:44, Antony Antony <antony@phenome.org> ??:
>On Fri, Aug 25, 2017 at 03:28:41PM +0200, Code Kipper wrote:
>> On 25 August 2017 at 12:32, Antony Antony <antony@phenome.org> wrote:
>
>> > +
>> > +       brcmf: bcrmf at 1 {
>> > +               reg = <1>;
>> > +               compatible = "brcm,bcm4329-fmac";
>> > +       };
>> Incorrect wifi chip - just deliver what you've tested.

Nope, this compatible is required by the dt binding, see the
binding document or other DTs with brcmfmac SDIO.

Please complain to brcmfmac maintainers.

>
>You are right. Now I found the correct chip ID by enabling debug with 
>Broadcom kernel module 'modprobe brcmfmac debug=0x3ffff6'
>
>The module is Ampak AP6212A with Broadcom 43430 rev=1 inside it.
>
>brcmfmac: brcmf_chip_recognition found AXI chip: BCM43430, rev=1
>brcmfmac: brcmf_ops_sdio_probe sdio vendor ID: 0x02d0
>brcmfmac: brcmf_ops_sdio_probe sdio device ID: 0xa9a6
>
>IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>
>This information mostly match with https://wikidevi.com/wiki/AMPAK,
>except 
>module is actually AP6212A. Some of the modules may not have 'A'
>printed on 
>them. However the ones that identify as rev=1 is a  AP6212A.
>
>FYI: there were two things that confused me
>	- bcm4329-fmac also works.
>	- I couldn't configure it to join WiFi network with password.
>
>With change I will send a v4. Here is the propssed diff to v3.
>
>arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
>
>        /*
>-        * WiFi driver support could be incomplete,
>-        * wlan0 is able to see Base Stations, however not able to
>join.
>+        * AMPAK AP6212A WiFi module with BCM43430, rev=1 inside
>+        * sdio vendor ID: 0x02d0, sdio device ID: 0xa9a6
>         */
>	brcmf: wifi at 1 {
>		reg = <1>;
>-               compatible = "brcm,bcm4329-fmac";
>+               compatible = "brcm,bcm43430-fmac";
>	}; 
>
>I think now nanopi-neo-plus2.dts, v4, is in a good shape to merge.
>
>thanks for the feedback and review.
>
>regards,
>-antony
