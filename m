From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 6 May 2013 15:22:39 +0800
Subject: [V9 PATCH 01/12] usb: phy: protect phy init and shutdown for
 mutiple deivces
In-Reply-To: <20130429182441.GA1632@arwen.pp.htv.fi>
References: <1366784606-1813-1-git-send-email-chao.xie@marvell.com>
 <1366784606-1813-2-git-send-email-chao.xie@marvell.com>
 <20130429182441.GA1632@arwen.pp.htv.fi>
Message-ID: <CADApbeiKnTSscVrPrCWzZjrJKW9XnyHxNuvy_ReaLEaKgPb+Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 2:24 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Apr 24, 2013 at 02:23:15AM -0400, Chao Xie wrote:
>> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
>> index 6b5978f..98d7e60 100644
>> --- a/include/linux/usb/phy.h
>> +++ b/include/linux/usb/phy.h
>> @@ -87,6 +87,14 @@ struct usb_phy {
>>       /* to support controllers that have multiple transceivers */
>>       struct list_head        head;
>>
>> +     /*
>> +      * PHY may be shared by multiple devices.
>> +      * mutex and refcount are used to make sure PHY only initialize or
>> +      * shutdown once.
>
> bad grammar in this sentence.
>

I will fix it in the next version.

>> +      */
>> +     struct mutex            phy_mutex;
>> +     unsigned int            refcount;
>
> why don't you use an atomic_t ?
>

Mutex will protect both ->init and ->shutdown routines. Thanks for
Russell's explanation.

> --
> balbi

Can you help to review other patches in this series? So I can fix all
the errors in the next version.
Thanks.
