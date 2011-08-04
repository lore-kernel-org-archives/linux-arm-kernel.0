From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 4 Aug 2011 16:54:32 +0800
Subject: [PATCH 07/17] mach-integrator: introduce cm_read function helper
	to read CM_CTRL register
In-Reply-To: <4E393128.3040602@ru.mvista.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-8-git-send-email-bryan.wu@canonical.com>
	<4E393128.3040602@ru.mvista.com>
Message-ID: <CAK5ve-+iVNSen+agOTM9BjyRre0oBEeQZg7Fa=1nswVJJhKKcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2011 at 7:29 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 03-08-2011 13:34, Bryan Wu wrote:
>
>> Signed-off-by: Bryan Wu<bryan.wu@canonical.com>
>> ---
>> ?arch/arm/mach-integrator/core.c ? ? ? ? ? ?| ? 17 +++++++++++++++++
>> ?arch/arm/mach-integrator/include/mach/cm.h | ? ?1 +
>> ?2 files changed, 18 insertions(+), 0 deletions(-)
>
>> diff --git a/arch/arm/mach-integrator/core.c
>> b/arch/arm/mach-integrator/core.c
>> index 77315b9..0ee6af6 100644
>> --- a/arch/arm/mach-integrator/core.c
>> +++ b/arch/arm/mach-integrator/core.c
>> @@ -225,6 +225,23 @@ void cm_control(u32 mask, u32 set)
>>
>> ?EXPORT_SYMBOL(cm_control);
>>
>> +/**
>> + * cm_read - read the CM_CTRL register.
>> + */
>> +u32 cm_read(void)
>> +{
>> + ? ? ? unsigned long flags;
>> + ? ? ? u32 val = 0;
>> +
>> + ? ? ? spin_lock_irqsave(&cm_lock, flags);
>> + ? ? ? val = readl(CM_CTRL);
>> + ? ? ? spin_unlock_irqrestore(&cm_lock, flags);
>
> ? What's the point of locking around already atomic read?
>

Actually, I'm not sure about whether we need special operation on
CM_CTRL register. So I followed the cm_control() function style.

Yeah, if it is just a common register, it's quite convenient for me to
read it in leds drivers.

Thanks a lot,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
