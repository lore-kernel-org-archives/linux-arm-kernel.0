From: robert.jarzmik@free.fr (=Robert Jarzmik)
Date: Fri, 06 Feb 2015 17:20:06 +0100
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <20150205233716.GU8656@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 5 Feb 2015 23:37:16 +0000")
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org>
 <87h9v1a8k2.fsf@free.fr>
 <CAL_JsqLiiKvzxQqE=bEx7qoLSZXLZOegt87A=+pR3PJuSBK95w@mail.gmail.com>
 <20150205135037.GP8656@n2100.arm.linux.org.uk>
 <8761bg9ngy.fsf@free.fr>
 <20150205233716.GU8656@n2100.arm.linux.org.uk>
Message-ID: <87zj8r811l.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, Feb 05, 2015 at 08:18:05PM +0100, Robert Jarzmik wrote:
>> As a consequence, I'm pretty much in favor of :
>>  - making rtc-pxa and rtc-sa1100 exclusive
>>  - adding to rtc-pxa driver :
>>    - a new rtc device (ie. it will register 2 rtc devices, one of the sa1100
>>      kind, one of the pxa specific kind)
>> 
>> This has flaws :
>>  - a bit of code will be duplicated between rtc-pxa and rtc-sa1100
>>  - the ordering in rtc-pxa between the 2 rtc devices will be important, as if I
>>  remember correctly /dev/rtc points to the first /dev/rtc0 registered
>> 
>> But it opens up :
>>  - DT path to both drivers
>>  - isolation between sa1100 architecture changes and pxa architecture changes
>>  - Rob's current patches can remain almost the same
>
> Or you make one export a set of "library" calls which are referenced
> by the other driver, and only declare one platform device.  Not
> _particularly_ nice but would avoid the code duplication issue (but
> has the benefit of not eating up module space, especially when the
> strict rw/execute protections are in effect.)

Or even better only export sa1100_rtc_ops, which should be enough, with :
 - Kconfig will have a "select RTC_SRV_SA1100" in the "config RTC_DRV_PXA".
 - struct sa1100_rtc_ops won't be static anymore, it should be exported
 - amend rtc-pxa :
   - the probe/release
   - the interrupt handler should take into account one more bit

That will imply that rtc-pxa is one platform device, which registers 2 rtc
devices. rtc-sa1100 is another platform device. And both will be exclusive.

Yet I don't see the "not eating up module space", unless all sa1100
functions are exported into a "rtc-sa1100-lib.c", which will always be built
builtin into the kernel when CONFIG_RTC is selected.

If there are still 2 modules, rtc-pxa and rtc-sa1100, they'll both eat module
space, unless I'm missing something.

Cheers.

-- 
Robert
