From: marex@denx.de (Marek Vasut)
Date: Fri, 7 Sep 2018 23:50:32 +0200
Subject: SoCFPGA Arria10 timer hang
In-Reply-To: <BA1B5AF7D118E146A437E44412B829131565154A@fmsmsx122.amr.corp.intel.com>
References: <f696454d-d81d-2b2d-d5b3-04f868c080be@denx.de>
 <BA1B5AF7D118E146A437E44412B829131565154A@fmsmsx122.amr.corp.intel.com>
Message-ID: <e78addb3-e36e-3161-8cc8-ea4fcc5fb2a3@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2018 11:40 PM, Nguyen, Dinh wrote:
> Hi Marek,

Hi,

>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Friday, September 7, 2018 2:46 PM
>> To: linux ARM <linux-arm-kernel@lists.infradead.org>
>> Cc: Nguyen, Dinh <dinh.nguyen@intel.com>; See, Chin Liang
>> <chin.liang.see@intel.com>; Tan, Ley Foon <ley.foon.tan@intel.com>
>> Subject: SoCFPGA Arria10 timer hang
>>
>> Hi,
>>
>> Latest upstream U-Boot (2018.09-rc3 and newer) properly handles reset on the
>> SoCFPGA Arria10. Since it uses only SP Timer 2, the remaining timers (0, 1, 3) are
>> left in reset state.
>>
>> Linux, on the other hand, picks the last timer in DT, which is SP Timer 3, as a
>> system timer. But since on Arria10 it doesn't unreset the timer and depends on
>> bootloader behavior, Linux just hangs very early on there.
>>
>> The Arria10 DTSI lacks any SP Timer "reset" phandles, so the reset controller
>> cannot unreset those timers. Adding those reset phandles is the first step to fix
>> this problem.
>>
>> Next one is drivers/clocksource/dw_apb_timer_of.c, which lacks support for
>> reset control at all. Adding reset controller support there is another step.
>>
>> But there is a problem, the reset controller driver comes up much later than the
>> timer. This is something I didn't have time to solve. If any of you can continue
>> fixing this, that'd be nice. I can share the patches I have thus far too.
>>
> 
> I can look into it. Are your patches going down the line of having a version of the
> SoCFPGA reset driver that gets registered early and uses the simple reset driver?

I only added the DT reset entries and reset controller support into the
dw-apb timer driver. I didn't dig into it beyond that.

That said, you can simulate it with any bootloader, just set the reset
bits for sptimer* in per1modrst and boot Linux, it will hang.

-- 
Best regards,
Marek Vasut
