From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 20:39:22 -0700
Subject: [PATCH V4] ARM: bcm281xx: Add timer driver
In-Reply-To: <5119B62E.9020901@broadcom.com>
References: <1360626279-26701-1-git-send-email-csd@broadcom.com>
 <5119B041.9040007@wwwdotorg.org> <5119B62E.9020901@broadcom.com>
Message-ID: <5119B96A.7060202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 08:25 PM, Christian Daudt wrote:
> On 13-02-11 07:00 PM, Stephen Warren wrote:
>> On 02/11/2013 04:44 PM, Christian Daudt wrote:
>>> This adds support for the Broadcom timer, used in the following SoCs:
>>> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>>> diff --git a/drivers/clocksource/bcm_kona_timer.c
>>> b/drivers/clocksource/bcm_kona_timer.c
>>> +static const struct of_device_id bcm_timer_ids[] __initconst = {
>>> +    {.compatible = "bcm,kona-timer"},
>>> +    {},
>>> +};
>>> +
>>> +static void __init kona_timers_init(void)
>>> +{
>>> +    struct device_node *node;
>>> +    u32 freq;
>>> +
>>> +    node = of_find_matching_node(NULL, bcm_timer_ids);
>>> +
>>> +    if (!node)
>>> +        panic("No timer");
>> I assume this is for 3.10 now.
> Oh. I missed 3.9 window ? Got busy with other stuff. Oh well, try again.
>> Can you rework this to remove
>> bcm_timer_ids[] and that of_find_matching_node() call, and replace it
>> with e.g.:
>>
>> CLOCKSOURCE_OF_DECLARE(kona, "bcm,kona-timer", kona_timer_init);
>
> where can I find an example ? I looked throught armsoc/for-next and the
> code there has CLOCKSOURCE_OF_DECLARE but it still has
> of_find_matching_node calls in the init fns - is it still in the process
> of being removed ?

It looks like Rob's patches that would allow you to eliminate the
of_find_matching_node() call aren't checked in yet; I'm not sure if
they'll make 3.9 or not. I has assumed so, but even if not, I imagine
they will be available as a dependency branch for you to build on top of
in 3.10. Those are:

https://lkml.org/lkml/2013/2/7/417

However, you could still convert to CLOCKSOURCE_OF_DECLARE right now;
the patches to enable that should be in arm-soc's for-next; see
drivers/clocksource/tegra20_timer.c there for example.
