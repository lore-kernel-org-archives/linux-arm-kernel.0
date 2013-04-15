From: robherring2@gmail.com (Rob Herring)
Date: Mon, 15 Apr 2013 08:36:23 -0500
Subject: [GIT PULL] Timer clean-ups for 3.10, Part 2
In-Reply-To: <20130413065056.GB14735@quad.lixom.net>
References: <516720B4.3000703@gmail.com> <201304112257.07645.arnd@arndb.de>
 <20130413065056.GB14735@quad.lixom.net>
Message-ID: <516C0257.8040103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2013 01:50 AM, Olof Johansson wrote:
> On Thu, Apr 11, 2013 at 10:57:07PM +0200, Arnd Bergmann wrote:
>> On Thursday 11 April 2013, Rob Herring wrote:
>>> Olof, Arnd,
>>>
>>> Please pull timer clean-ups for arch timer, sp804, and integrator-cp timers.
>>>
>>> I've dropped the final patch which moved the sp804 and integrator timers
>>> code to drivers/clocksource until the desired structure is worked out.
>>>
>>> Simon, the fixes for shmobile were trivial. Please comment if you see
>>> any issues.
>>
>> Ok, nice!
>>
>> There are various bits for which I'd like to see Russell's ACK before
>> we send them Linuswards, but it all looks good to me.
>>
>> I would put it into arm-soc tomorrow, and hopefully Haojian Zhuang is
>> able to send an updated version of his hisilicon platform code based
>> on top of this in time for the merge window. The patches are all
>> reviewed but just waiting for the sp804 changes now, and since
>> it's a new platform, I'm not worried about regressions.
> 
> I've pulled this in as a late/clksrc branch now, so that we keep it separate
> from the other work in case Russell ends up having comments on it when he is
> back online.
> 
> Also, I based the branch on samsung/mct and samsung/clk, since they had merge
> conflicts. Kukjin, Rob, please confirm that I've resolved them properly.

It is quite messed up because the mct timer changes are not based on
arm-soc/clksrc/cleanup. Any timer changes adding CLKSRC_OF support need
to be based on this. I've fixed it up in this branch (untested):

git://sources.calxeda.com/kernel/linux.git exynos-mct-merge

I merged with clksrc-cleanup-for-3.10-part2 and fixed it in the merge,
but really either the mct branch should be rebased or some of the
changes can be a preparatory commit before merging.

Also, I really don't like how intermingled the DT and non-DT init is in
the exynos code. We should remove of_have_populated_dt so we don't have
stuff like this:

        if (!of_have_populated_dt())
                gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST,
S5P_VA_GIC_CPU, gic_bank_offset, NULL);
#ifdef CONFIG_OF
        else
                irqchip_init();
#endif

        if (!of_have_populated_dt())
                combiner_init(S5P_VA_COMBINER_BASE, NULL);


I went thru arm-soc/for-next and all the other conversions not done by
me (mxs, sirf, zynq) are based on clksrc/cleanup.

Rob
