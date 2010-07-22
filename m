From: post@hendrik-sattler.de (Hendrik Sattler)
Date: Thu, 22 Jul 2010 13:40:47 +0200
Subject: [PATCH] Introduce 'struct machine_class' for SoC level abstraction
In-Reply-To: <AANLkTinvLsDl3smP7C9LmHeKF9b0-dSNXhJMsy6Tp7JI@mail.gmail.com>
References: <AANLkTikWs2j8mSmiAdOPIY2uOfO9Q08kbuihkak7GCG8@mail.gmail.com>
	<20100722131145.q1mqlhg2888cks0w@v1539.ncsrv.de>
	<AANLkTinvLsDl3smP7C9LmHeKF9b0-dSNXhJMsy6Tp7JI@mail.gmail.com>
Message-ID: <20100722134047.grwg79pz9wo84sok@v1539.ncsrv.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zitat von Eric Miao <eric.y.miao@gmail.com>:

> On Thu, Jul 22, 2010 at 1:11 PM, Hendrik Sattler
> <post@hendrik-sattler.de> wrote:
>> Zitat von Eric Miao <eric.miao@canonical.com>:
>>>
>>> @@ -772,8 +774,13 @@ void __init setup_arch(char **cmdline_p)
>>>
>>> ? ? ? ?if (__atags_pointer)
>>> ? ? ? ? ? ? ? ?tags = phys_to_virt(__atags_pointer);
>>> - ? ? ? else if (mdesc->boot_params)
>>> - ? ? ? ? ? ? ? tags = phys_to_virt(mdesc->boot_params);
>>> + ? ? ? else {
>>> + ? ? ? ? ? ? ? unsigned long boot_params = mdesc->boot_params ?
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mdesc->boot_params :
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(class ? class->boot_params:
>>> 0);
>>> + ? ? ? ? ? ? ? if (boot_params)
>>> + ? ? ? ? ? ? ? ? ? ? ? tags = phys_to_virt(boot_params);
>>> + ? ? ? }
>>
>> Isn't
>> ? ? ? ?if (__atags_pointer)
>> ? ? ? ? ? ? ? ?tags = phys_to_virt(__atags_pointer);
>> ? ? ? ?else if (mdesc->boot_params)
>> ? ? ? ? ? ? ? ?tags = phys_to_virt(mdesc->boot_params);
>> + ? ? ? else if (class)
>> + ? ? ? ? ? ? ? tags = phys_to_virt(class->boot_params);
>>
>> equivalent and much simpler?
>>
>
> The idea is for mdesc->boot_params to override class->boot_params
> if it's non-zero. Eventually this can be removed as the old way of
> passing parameters from the bootloader at .boot_params will just
> go away.

Just expand that your snippet to:
   unsigned long boot_params = 0;
   if (mdesc->boot_params)
     boot_params = mdesc->boot_params;
   else {
     if (class)
       boot_params = class->boot_params;
   }
   if (boot_params)
     tags = phys_to_virt(boot_params);

That is just more complicated than adding that simple else case but  
does the same.

HS
