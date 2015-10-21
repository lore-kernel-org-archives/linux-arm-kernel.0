From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 21 Oct 2015 15:23:32 +0200
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <56276C87.6040509@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
 <CAGOxZ51_JPy51htzD_M_=qaPVUexkVhoA2ANLS2-rpK3QDT=8A@mail.gmail.com>
 <1606098.olLAyTIhB3@dell2.five-lan.de> <56272C1C.8040007@samsung.com>
 <562765F3.9010306@osg.samsung.com> <56276C87.6040509@samsung.com>
Message-ID: <562791D4.3050105@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/21/2015 12:44 PM, Alim Akhtar wrote:

[snip]

>>
>> Can you please test following patch [0] on top of Alim's series? If that
>> works then it should either be part of Alim's series or the patches will
>> have to wait until that patch lands into mainline. I don't have an eMMC
>> to test it in XU4 but I'm pretty confident that it will solve the issue.
>>
> I am fine with including this with my series or lowering syscon_restart_handler priority to 128.

Yes, I also considered changing the syscon-reboot handler priority to 128 but
then I noticed this commit:

b81180b3fd48 ("power: reset: adjust priority of simple syscon reboot driver").

So as you can see, it was 128 before but was bumped to 192 so it was called
before restart handlers registered by watchdogs. So, changing to 128 would
break other people use cases.

Now, I don't know if that is the right fix since register_restart_handler()
explanation about the policy used for restart handler priority numbers is
scarce. It only mentions 0, 128 and 255 so probably the correct thing to do
is to change all watchdog restart handler to 0 but that is a separate issue.

> It also make sense to increase eMMC priority as you suggested as before system reboot, devices should have reseted itself.

That was my rationale as well and is why I think the handler for devices
should use the highest priority regardless if the syscon-reboot is later
changed to prio 128 and the watchdog handlers to 0.

Best regards,

[0]: http://lxr.free-electrons.com/source/kernel/reboot.c#L113

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
