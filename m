From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 10 Jan 2018 13:15:48 +0100
Subject: [PATCH] usb: dwc2: Fix endless deferral probe
In-Reply-To: <CAK8P3a3eggC=XWLxr-A+pdaXj-0kMZ4aoX3hRyg5tLUknoDeBA@mail.gmail.com>
References: <1515526134-2148-1-git-send-email-stefan.wahren@i2se.com>
 <CAK8P3a3eggC=XWLxr-A+pdaXj-0kMZ4aoX3hRyg5tLUknoDeBA@mail.gmail.com>
Message-ID: <7ef21b99-67c8-b246-cc9a-b7202264a7a0@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Am 09.01.2018 um 22:33 schrieb Arnd Bergmann:
> On Tue, Jan 9, 2018 at 8:28 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> The dwc2 USB driver tries to find a generic PHY first and then look
>> for an old style USB PHY. In case of a valid generic PHY node without
>> a PHY driver, the PHY layer will return -EPROBE_DEFER forever. So dwc2
>> will never tries for an USB PHY.
>>
>> Fix this issue by finding a generic PHY and an old style USB PHY
>> at once.
> This would fix only one of the USB controllers (dwc2), but not the others
> that are affected. As I wrote in my suggested patch, dwc3 appears to be
> affected the same way, and all other host drivers that call usb_add_hcd()
> without first setting hcd->phy would suffer from this as well.
>
> If we go down the route of addressing it here in the hcd drivers, we should
> at least change all three of those, and hope this doesn't regress in
> another way.
>
>         Arnd

i fully unterstand. But we leaving the path of "fixing a critical issue 
on BCM2835" and go to "fixing multiple USB host controller". I do this 
all in my spare time and don't have any of the other USB controller 
available. So before i proceed with any other patch i like so see some 
feedback from John, Greg or Felipe.

After finalizing this patch i think the chance is little that this would 
be applied to 4.15. So i seems to me that we still revert my DT clean up 
patch.

Stefan
