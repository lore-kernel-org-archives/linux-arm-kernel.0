From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 14 Sep 2011 22:43:48 +0530
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <20110914170803.GN24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	<20110913203616.GG24252@atomide.com>
	<CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
	<20110914152116.GM24252@atomide.com> <4E70DB33.5070501@ti.com>
	<20110914170803.GN24252@atomide.com>
Message-ID: <4E70E0CC.80300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 September 2011 10:38 PM, Tony Lindgren wrote:
> * Santosh<santosh.shilimkar@ti.com>  [110914 09:16]:
>>
>> First and foremost, I have to go with the approach here because MPUSS
>> hardware team put a requirement that GIC and wakeupgen should always be
>> kept in sync. If needed we can discuss this off-the list with Richard.
>>
>> Below is the extract from the veyron func specs.
>> -------------------------------------
>> Version 1.6 of veyron spec has this.
>>
>>  From page 95, paragraph 2 on version 1.6:
>>
>> "It is SW responsibility to program interrupt enabling/disabling
>> coherently in the GIC and in the Wugen enable registers. That is, a
>> given interrupt for a given CPU is either enable at both GIC and Wugen,
>> or disable at both, but no mix."
>> -------------------------------------
>>
>> The way understand this IP is, even in normal scenario's every IRQ
>> will come to wakeupgen and then it will pass that to GIC. CPU clock
>> domains are kept under HW supervised always and they can enter inactive
>> any time without WFI. Only wakeup gen can bring the CPU out of inactive
>> state.
>>
>> That's requirement really lead to this design choice. Just to add
>> all ARM SOC's using GIC has a gic extension interrupt controller and
>> follow the same approach for the secondary IRQCHIPO.
>
> Thanks for the clarification. It seems to me the spec is most likely
> wrong as we've had the GIC working for over two years now without
> doing anything with the wakeup gen registers :)
>
It's working because CPU clockdomain are never put under HW
supervised mode and they are kept in force wakeup. Clock-domain
never idles on mainline code. PM series will put the clock-domains
under HW supervison as needed to achieve any low power states and
then all sorts of corner cases will come out.

Regards
Santosh
