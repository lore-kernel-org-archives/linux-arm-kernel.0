From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Tue, 03 May 2016 12:33:31 +0300
Subject: [PATCH] usb: xhci-mtk: fixup mouse wakeup failure during system
 suspend
In-Reply-To: <1462266591.11651.34.camel@mhfsdcap03>
References: <1461204293-18243-1-git-send-email-chunfeng.yun@mediatek.com>
 <1462261458.11651.7.camel@mhfsdcap03> <87vb2vfujq.fsf@intel.com>
 <1462266591.11651.34.camel@mhfsdcap03>
Message-ID: <87mvo7fpuc.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> > On Thu, 2016-04-21 at 10:04 +0800, Chunfeng Yun wrote:
>> >> Click mouse after xhci suspend completion but before system suspend
>> >> completion, system will not be waken up by mouse if the duration of
>> >> them is larger than 20ms which is the device UFP's resume signaling
>> 
>> what is "them" here ? The duration of what is longer than 20ms ?
> They are "xhci suspend completion" and "system suspend completion";
>
> It's time duration

okay. So if xhci suspend takes longer than 20ms your SPM doesn't see a
wakeup ?

>> >> lasted. Another reason is that the SPM is not enabled before system
>> 
>> what's SPM ?
> It is System Power Management which is powered off when system is
> running in normal mode, and is powered on when system enters suspend
> mode. It is used to wakeup system when some wakeup sources, such as
> bluetooth or powerkey etc, tigger wakeup event.

okay, thanks

>> >> suspend compeltion, this causes SPM also not notice the resume signal.
>>            ^^^^^^^^^^
>>            completion
>> 
>> >> So in order to reduce the duration less than 20ms, make use of
>> >> syscore's suspend/resume interface.
>> 
>> no, this is the wrong approach
> But it seems only one workable approach from software side

I wouldn't say that. It seems to me SPM should be enabled earlier.

>> >> Because the syscore runs on irq disabled context, and xhci's
>> >> suspend/resume calls some sleeping functions, enable local irq
>> >> and then disable it during suspend/resume. This may be not a problem,
>> >> since only boot CPU is runing.
>> 
>> another problem :) calling local_irq_{enable,disable}() is an indication
>> that something's wrong.
> Oh!
>
> BTW: There will be warning logs if they are not called.

yeah, I got that :-) But it's still wrong to use
local_irq_{enable,disable}() the way you're using them :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160503/6371eb03/attachment.sig>
