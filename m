From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 6 Nov 2015 14:58:04 +0900
Subject: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
In-Reply-To: <3770393.BLNOaUSB5Q@wuerfel>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <3770393.BLNOaUSB5Q@wuerfel>
Message-ID: <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,



2015-11-05 23:49 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 05 November 2015 20:15:21 Masahiro Yamada wrote:
>> When I was implementing a new reset controller for my SoCs,
>> I struggled to make my sub-menu shown under the reset
>> controller menu.
>> I noticed the Kconfig in reset sub-system are screwed up due to two
>> config options (ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER).
>>
>> I think only the former should be select'ed by relevant SoCs,
>> but in fact the latter is also select'ed here and there.
>> Mixing "select" to a user-configurable option is a mess.
>>
>> Finally, I started to wonder whether it could be more simpler?
>>
>> The first patch drops ARCH_HAS_RESET_CONTROLLER.
>> RESET_CONTROLLER should be directly selected by SoCs.
>>
>> The rest of this series are minor clean ups in other
>> sub-systems.
>> I can postpone them if changes over cross sub-systems
>> are not preferred.
>
> Thanks a lot for picking up this topic! It has been annoying me
> for a while and I have submitted an experimental patch some time
> ago, but not finished it myself.
>
> For some reason, I only see a subset of your patches here (patch 1, 4 and 6),
> so I don't know exactly what you did.

All the patches CCed linux-kernel at vger.kernel.org,
so you can dig into LKML log or the following patchwork
https://patchwork.kernel.org/project/LKML/list/




> For reference, you can find
> my original patch below. Please check if I did things that your
> series doesn't do, and whether those are still needed.

Thanks.

Yours looks mostly nice, and this work is worth continuing.
(I am pleased to review it when you submit the next version.)

I have some comments.

[1]
Why is ARCH_HAS_RESET_CONTROLLER select'ed by
ARCH_MULTIPLATFORM, but not by others?
This seems weird.

We do not have such options like
  ARCH_HAS_PINCTRL,  ARCH_HAS_COMMON_CLK...


[2]
The difference is that yours is adding per-driver options such as
RESET_SOCFPGA, RESET_BERLIN, etc.
I think this is a good idea.

But, I notice lowlevel drivers select RESET_CONTROLLER,
for example, RESET_SOCFPGA select RESET_CONTROLLER.

We generally do the opposite in other subsystems, I think.


For example, the whole of clk menu is guarded by "depends on COMMON_CLK".

menu "Common Clock Framework"
         depends on COMMON_CLK

     <bunch of low-level drivers>

endmenu


Likewise for pinctrl.





-- 
Best Regards
Masahiro Yamada
