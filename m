From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Jul 2010 13:20:59 +0200
Subject: [PATCH] Introduce 'struct machine_class' for SoC level
	abstraction
In-Reply-To: <20100722131145.q1mqlhg2888cks0w@v1539.ncsrv.de>
References: <AANLkTikWs2j8mSmiAdOPIY2uOfO9Q08kbuihkak7GCG8@mail.gmail.com>
	<20100722131145.q1mqlhg2888cks0w@v1539.ncsrv.de>
Message-ID: <AANLkTinvLsDl3smP7C9LmHeKF9b0-dSNXhJMsy6Tp7JI@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 1:11 PM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
> Zitat von Eric Miao <eric.miao@canonical.com>:
>>
>> @@ -772,8 +774,13 @@ void __init setup_arch(char **cmdline_p)
>>
>> ? ? ? ?if (__atags_pointer)
>> ? ? ? ? ? ? ? ?tags = phys_to_virt(__atags_pointer);
>> - ? ? ? else if (mdesc->boot_params)
>> - ? ? ? ? ? ? ? tags = phys_to_virt(mdesc->boot_params);
>> + ? ? ? else {
>> + ? ? ? ? ? ? ? unsigned long boot_params = mdesc->boot_params ?
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mdesc->boot_params :
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(class ? class->boot_params:
>> 0);
>> + ? ? ? ? ? ? ? if (boot_params)
>> + ? ? ? ? ? ? ? ? ? ? ? tags = phys_to_virt(boot_params);
>> + ? ? ? }
>
> Isn't
> ? ? ? ?if (__atags_pointer)
> ? ? ? ? ? ? ? ?tags = phys_to_virt(__atags_pointer);
> ? ? ? ?else if (mdesc->boot_params)
> ? ? ? ? ? ? ? ?tags = phys_to_virt(mdesc->boot_params);
> + ? ? ? else if (class)
> + ? ? ? ? ? ? ? tags = phys_to_virt(class->boot_params);
>
> equivalent and much simpler?
>

The idea is for mdesc->boot_params to override class->boot_params
if it's non-zero. Eventually this can be removed as the old way of
passing parameters from the bootloader at .boot_params will just
go away.

> HS
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
