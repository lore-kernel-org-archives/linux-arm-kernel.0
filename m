From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Apr 2014 09:53:34 -0300
Subject: USB OTG support on mx27pdk
In-Reply-To: <1397649526.601497269@f431.i.mail.ru>
References: <CAOMZO5BcTP=fvYDE8EU2Y2Syn=QqbPd4zaQ96mSfy-mgLEjOmA@mail.gmail.com>
 <1397627716.685483508@f399.i.mail.ru>
 <CAOMZO5Bgo8L1G2hpZpg=0uVdxkcDDnkOPkNGX9dHYk3Wq9J+=w@mail.gmail.com>
 <1397649526.601497269@f431.i.mail.ru>
Message-ID: <CAOMZO5DXStD5wsFhm3A9izyrxLfC8rmY2YnGBVGD=fqsJdaRFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 8:58 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> I can tell immediately without further testing,
> this will not work without the USB support in the bootoader because
> we do not have DT support for ULPI.

The generic nop usb phy should work just fine.

I have tried Uwe's suggestion from a previous post and reverted:

commit cd0b42c2a6d2a74244f0053f8960f5dad5842278
Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Date:   Fri Jan 10 13:51:30 2014 +0800

    usb: chipidea: put hw_phymode_configure before ci_usb_phy_init

    hw_phymode_configure configures the PORTSC registers and allow the
    following phy_inits to operate on the right parameters. This fix a problem
    where the UPLI (ISP1504) could not be detected, because the Viewport was not
    available and read the viewport return 0's only.

    Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
    Signed-off-by: Peter Chen <peter.chen@freescale.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Then USB OTG port detected the USB pen driver fine:

usbcore: registered new interface driver usb-storage
10024000.usb supply vbus not found, using dummy regulator
ci_hdrc ci_hdrc.0: EHCI Host Controller
ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
...
scsi 0:0:0:0: Direct-Access     ChipsBnk Flash Disk       2.00 PQ: 0 ANSI: 2
sd 0:0:0:0: [sda] 1035200 512-byte logical blocks: (530 MB/505 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] No Caching mode page found
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk

If I understand correctly commit cd0b42c2a was only needed because
Chris was trying to add DT support for ULPI, which never got merged
into mainline.

If we use the generic nop usb phy instead, we should just revert this commit.

Any objections?

Regards,

Fabio Estevam
