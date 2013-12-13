From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 13 Dec 2013 14:23:35 +0800
Subject: [PATCH v6 07/15] usb: phy: add notify suspend and resume callback
In-Reply-To: <20131213042722.GG867@saruman.home>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-8-git-send-email-peter.chen@freescale.com>
 <20131213042722.GG867@saruman.home>
Message-ID: <CAL411-o7YBzQitOPZodnp6OsRrUZf2LPzbWUY6AJpHo29x2FzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:27 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 13, 2013 at 09:23:37AM +0800, Peter Chen wrote:
>> They are used to notify PHY that the controller enters suspend
>> or finishes resume.
>>
>> Signed-off-by: Peter Chen <peter.chen@freescale.com>
>> ---
>>  include/linux/usb/phy.h |   23 +++++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
>> index 6c0b1c5..a747960 100644
>> --- a/include/linux/usb/phy.h
>> +++ b/include/linux/usb/phy.h
>> @@ -116,6 +116,11 @@ struct usb_phy {
>>                       enum usb_device_speed speed);
>>       int     (*notify_disconnect)(struct usb_phy *x,
>>                       enum usb_device_speed speed);
>> +     int     (*notify_suspend)(struct usb_phy *x,
>> +                     enum usb_device_speed speed);
>> +     int     (*notify_resume)(struct usb_phy *x,
>> +                     enum usb_device_speed speed);
>> +
>
> I still don't think this is necessary. Why don't you just call
> usb_phy_set_suspend() directly ? And why do you need the extra speed
> argument ?
>
> --

It is different with PHY's power/clock.

Eg, for .notify_resume, it needs to be called after host controller finishes
 sending resume signal. If its operation is executed before controller sends
resume signal, the disconnect operation during the resume will not be detected.

.notify_suspend and .notify_resume needs to be called during ehci suspend/
resume operation for mxs-phy typed controller.

For mxs-phy, this operation is only needed for high speed connection,
and to aligned with .nofity_connect/.notify_disconnect, I added the speed
argument. If the user doesn't need it, it can pass USB_SPEED_UNKNOWN like
below post.

http://marc.info/?l=linux-usb&m=138418998118519&w=2

BR,
Peter Chen
