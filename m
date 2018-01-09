From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Jan 2018 22:33:40 +0100
Subject: [PATCH] usb: dwc2: Fix endless deferral probe
In-Reply-To: <1515526134-2148-1-git-send-email-stefan.wahren@i2se.com>
References: <1515526134-2148-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAK8P3a3eggC=XWLxr-A+pdaXj-0kMZ4aoX3hRyg5tLUknoDeBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 8:28 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The dwc2 USB driver tries to find a generic PHY first and then look
> for an old style USB PHY. In case of a valid generic PHY node without
> a PHY driver, the PHY layer will return -EPROBE_DEFER forever. So dwc2
> will never tries for an USB PHY.
>
> Fix this issue by finding a generic PHY and an old style USB PHY
> at once.

This would fix only one of the USB controllers (dwc2), but not the others
that are affected. As I wrote in my suggested patch, dwc3 appears to be
affected the same way, and all other host drivers that call usb_add_hcd()
without first setting hcd->phy would suffer from this as well.

If we go down the route of addressing it here in the hcd drivers, we should
at least change all three of those, and hope this doesn't regress in
another way.

       Arnd
