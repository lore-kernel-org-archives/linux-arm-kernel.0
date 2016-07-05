From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jul 2016 15:43:59 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm,
 nvram_file_name dt property
In-Reply-To: <577AAC95.7040800@broadcom.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <8717879.O1RMZcQt4V@wuerfel> <577AAC95.7040800@broadcom.com>
Message-ID: <26659199.PqqRaoPEho@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 4, 2016 8:36:05 PM CEST Arend van Spriel wrote:
> On 04-07-16 16:54, Arnd Bergmann wrote:
> > On Monday, July 4, 2016 11:08:38 AM CEST Arend Van Spriel wrote:
> > 
> > In drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c I already see
> > over a dozen different chips being supported, bcm4329 is only one of
> > them. In particular, there seem to be some that have various modules:
> > 
> >         BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43241_CHIP_ID, 0x0000001F, 43241B0),
> >         BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43241_CHIP_ID, 0x00000020, 43241B4),
> >         BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43241_CHIP_ID, 0xFFFFFFC0, 43241B5),
> > 
> > So if you have a bcm43241, that compatible string probably should
> > include both brcm,bcm43241-b4-fmac and brcm,bcm43241-fmac, possibly also
> > brcm,bcm4329-fmac, to show that it is a superset of the programming
> > interface of that one.
> 
> Hi Arnd,
> 
> I have to disagree here. The compatible string "brcm,bcm4329-fmac" is
> chosen as the bcm4329 chip was the first supported and we never added
> others as there is no other programming required. For all supported
> devices the same device tree properties apply and are handled the same.
> As such there is no need to come up with a new compatible string.

Generally speaking, the way that the compatible strings work is that you
add a new one whenever you get a new piece of hardware, and you can leave
the first one as a fallback so you don't have to change the driver.

Adding the new string for the actual device is important though,
since you might only discover later that they are not 100% compatible
and that you in fact need to know the difference.

For discoverable buses like sdio or usb, it may actually be better
to not identify the device through the compatible property at all,
and instead use a string that is generated from the actual identifier
as the primary key, as e.g. documented in
Documentation/devicetree/bindings/usb/usb-device.txt

The mmc binding is less clear about that, and we may want to correct
that. In fact, the example in
Documentation/devicetree/bindings/mmc/mmc.txt even lists an invalid
compatible string, so that is even worse.

	Arnd
