From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 9 Jul 2017 21:27:37 -0700
Subject: [PATCH] ARM: owl: smp: Drop owl_secondary_boot()
In-Reply-To: <1fd52467-48fc-5283-6b48-5d653105ba19@suse.de>
References: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
 <20170704233219.18790-1-afaerber@suse.de>
 <3F3740FC-3873-4C01-A625-C8DC7F50A018@gmail.com>
 <c037a437-0e9e-e451-d3a6-3a866db8bb16@suse.de>
 <1fd52467-48fc-5283-6b48-5d653105ba19@suse.de>
Message-ID: <1c790718-657e-e860-e03e-473b5ddba6a3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/09/2017 02:55 PM, Andreas F?rber wrote:
> Am 06.07.2017 um 19:17 schrieb Andreas F?rber:
>> Am 05.07.2017 um 04:36 schrieb Florian Fainelli:
>>> On July 4, 2017 4:32:18 PM PDT, "Andreas F?rber" <afaerber@suse.de> wrote:
>>>> -	writel(virt_to_phys(owl_secondary_startup),
>>>> +	writel(virt_to_phys(secondary_startup),
>>>> 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>>>
>>> This is a kernel symbol so please use __pa_symbol() here, also you might want to build with CONFIG_DEBUG_VIRTUAL and see if you get other warnings about using virt_to_phys() in the owl platform code (I did not check if there are other uses)
> 
> Florian, I don't spot any build or runtime warning for this
> virt_to_phys() with CONFIG_DEBUG_VIRTUAL=y on Guitar/S500:

You would only see run time warnings, not build time warnings for this,
but in fact, no, see below.

> 
> [    0.062765] CPU: Testing write buffer coherency: ok
> [    0.063468] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.100856] Setting up static identity map for 0x100000 - 0x100060
> [    0.120864] Hierarchical SRCU implementation.
> [    0.161092] smp: Bringing up secondary CPUs ...
> [    0.291654] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.422226] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.552798] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.553074] smp: Brought up 1 node, 4 CPUs
> [    0.553388] SMP: Total of 4 processors activated (1629.38 BogoMIPS).
> [    0.553477] CPU: All CPU(s) started in SVC mode.
> 
> I've tested that __pa_symbol() works as well, but I'd like to understand
> this for commit message and future testing. Am I missing other options?

After re-checking the implementation you would get a warning only if you
were using virt_to_phys() against a part of the kernel that is not in
the linear map, similarly you would get a warning if __pa_symbol() was
used against symbols outside of the kernel image, this is obviously not
the case here. You should use __pa_symbol() just for correctness, no
warning would be produced, sorry for misleading you with that.
-- 
Florian
