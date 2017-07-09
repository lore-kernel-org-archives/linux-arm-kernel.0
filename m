From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 9 Jul 2017 23:55:22 +0200
Subject: [PATCH] ARM: owl: smp: Drop owl_secondary_boot()
In-Reply-To: <c037a437-0e9e-e451-d3a6-3a866db8bb16@suse.de>
References: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
 <20170704233219.18790-1-afaerber@suse.de>
 <3F3740FC-3873-4C01-A625-C8DC7F50A018@gmail.com>
 <c037a437-0e9e-e451-d3a6-3a866db8bb16@suse.de>
Message-ID: <1fd52467-48fc-5283-6b48-5d653105ba19@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.07.2017 um 19:17 schrieb Andreas F?rber:
> Am 05.07.2017 um 04:36 schrieb Florian Fainelli:
>> On July 4, 2017 4:32:18 PM PDT, "Andreas F?rber" <afaerber@suse.de> wrote:
>>> -	writel(virt_to_phys(owl_secondary_startup),
>>> +	writel(virt_to_phys(secondary_startup),
>>> 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>>
>> This is a kernel symbol so please use __pa_symbol() here, also you might want to build with CONFIG_DEBUG_VIRTUAL and see if you get other warnings about using virt_to_phys() in the owl platform code (I did not check if there are other uses)

Florian, I don't spot any build or runtime warning for this
virt_to_phys() with CONFIG_DEBUG_VIRTUAL=y on Guitar/S500:

[    0.062765] CPU: Testing write buffer coherency: ok
[    0.063468] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.100856] Setting up static identity map for 0x100000 - 0x100060
[    0.120864] Hierarchical SRCU implementation.
[    0.161092] smp: Bringing up secondary CPUs ...
[    0.291654] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.422226] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.552798] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.553074] smp: Brought up 1 node, 4 CPUs
[    0.553388] SMP: Total of 4 processors activated (1629.38 BogoMIPS).
[    0.553477] CPU: All CPU(s) started in SVC mode.

I've tested that __pa_symbol() works as well, but I'd like to understand
this for commit message and future testing. Am I missing other options?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
