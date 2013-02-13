From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 09:38:49 -0700
Subject: zynq drivers/clocksource (was: Re: [GIT PULL] arm-soc: Xilinx
 zynq timer changes for v3.9)
In-Reply-To: <CAHTX3dJftmsMvK1BMupZMfz7bmTBvsUq37fZaC=vd8yanYEasw@mail.gmail.com>
References: <CAHTX3dJftmsMvK1BMupZMfz7bmTBvsUq37fZaC=vd8yanYEasw@mail.gmail.com>
Message-ID: <511BC199.8030907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2013 07:22 AM, Michal Simek wrote:
> Hi,
> 
> here is origin comment from Arnd.
> 
>> Please have a look at the contents of the timer/cleanup and clocksource/cleanup
>> branches in arm-soc, and merge them into your branch. If everything still
>> works, you can add a patch on top of the merge to move your driver to
>> drivers/clocksource and use the new infrastructure introduced there.
> 
> based on Arnd request I have looked at moving zynq timer code to the
> new infrastructure
> in drivers/clocksource. I have done some investigation and I am not quite
> sure if I understand the design correctly.
> 
> I have looked at vt8500, tegra20 and bcm2835 drivers in arm-soc/for-next branch
> and all of them use the same pattern with expectation that only
> one timer with the same compatible property is available in the system.

Oh right. When we spoke on IRC, I was thinking of multiple different
types of clocksource driver, rather than multiple instances of the same
type. Yes, my original patches wouldn't work well with multiple
instances (DT nodes) with the same compatible property.

> I have done some tests on zynq and the problem is with calling
> of_find_matching_node(NULL, .._match); which will always return the same
> device_node which end up with faults later when you try to request the same
> irq.
> 
> Is there any limitation/expectation that only one clocksource driver
> should be probed?
> 
> Also not sure if make sense to add of_find_matching_node for architectures
> which select CONFIG_OF or USE_OF when we can pass device_node directly from
> of_find_matching_node().

... but Rob's patches that I mentioned should solve this multiple
instance issue, since they do indeed pass the found DT node into the
timer init function.
