From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 26 Mar 2013 14:17:30 +0800
Subject: [PATCH 0/8] SIRF multiplatform support
In-Reply-To: <201303251133.31426.arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <201303251133.31426.arnd@arndb.de>
Message-ID: <CAGsJ_4ztS_jGsQaLm3URDjPrNSoP6PU6PR73f=X72YG-d4_Yfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/25, Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 20 March 2013, Arnd Bergmann wrote:
>> Here goes another one. Since the SIRF platforms are relatively new and
>> clean, they are easy to convert to multiplatform, so I did that and
>> fixed up a few other things in the process as well.
>>
>> Barry, could you test these and report back if everything still works
>> for you?
>
> Hi Barry,
>
> I've updated the branch at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> prima2/multiplatform
>
> now to fix the problems you pointed out. Can you check if it all works now?
>
> 	Arnd
Hi Arnd,
everything is fine except that:
1. Shawn Guo's uncompress debug patch is not in the tree, so the
uncompress debug is break. but that is not an issue

2. i want to change:
#define SIRFSOC_NUM_IRQS                128
to:
#define SIRFSOC_NUM_IRQS                64
the old 128 is suitable for marco, in fact prima2/atlas6 is 64. in
order that all SoCs can use the same irqs.h headfile, i pick the
biggest value. since now we have moved to linear irq, i want to fix it
back.

then nr_irqs in DT_MACHINE_START(ATLAS6_DT/PRIMA2_DT should also take 64.

3. will we have similar codes between prima2 and marco for initilizing
timer tick?
CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick",
sirfsoc_of_timer_init );
CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer, "sirf,prima2-tick",
sirfsoc_prima2_timer_init);

will we change "CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer,
"sirf,marco-tick", sirfsoc_of_timer_init )" to things like
"CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick",
sirfsoc_marco_timer_init )" as prima2 does and drop

anyway, this is a trivial issue.

-barry
