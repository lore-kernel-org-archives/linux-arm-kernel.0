From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Oct 2012 10:30:15 -0600
Subject: [PATCH] ARM: kirkwood: DT board setup for Network Space v2 and
 parents
In-Reply-To: <20121009150517.GA26952@kw.sim.vm.gnt>
References: <1349277270-24962-1-git-send-email-simon.guinot@sequanux.org>
 <20121003154310.GI11837@lunn.ch> <20121003220916.GW31897@kw.sim.vm.gnt>
 <20121004055443.GK21046@lunn.ch> <20121004075335.GY31897@kw.sim.vm.gnt>
 <506DAE12.7000003@wwwdotorg.org> <20121009150517.GA26952@kw.sim.vm.gnt>
Message-ID: <50745117.7030804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2012 09:05 AM, Simon Guinot wrote:
> On Thu, Oct 04, 2012 at 09:41:06AM -0600, Stephen Warren wrote:
>> On 10/04/2012 01:53 AM, Simon Guinot wrote:
>>> On Thu, Oct 04, 2012 at 07:54:43AM +0200, Andrew Lunn wrote:
>>>>>>> --- a/arch/arm/mach-kirkwood/board-dt.c +++ 
>>>>>>> b/arch/arm/mach-kirkwood/board-dt.c @@ -96,6 +96,11 @@ 
>>>>>>> static void __init kirkwood_dt_init(void) if 
>>>>>>> (of_machine_is_compatible("keymile,km_kirkwood")) 
>>>>>>> km_kirkwood_init();
>>>>>>> 
>>>>>>> +	if (of_machine_is_compatible("lacie,inetspace_v2") ||
>>>>>>> + of_machine_is_compatible("lacie,netspace_v2") || + 
>>>>>>> of_machine_is_compatible("lacie,netspace_max_v2")) + 
>>>>>>> ns2_init(); + of_platform_populate(NULL, 
>>>>>>> kirkwood_dt_match_table, kirkwood_auxdata_lookup,
>>>>>>> NULL);
>>>>>> 
>>>>>> I'm not a DT policy expert. Could this be one
>>>>>> compatibility string for all the boards? Maybe ask on the
>>>>>> DT mainline list?
>>>>> 
>>>>> Maybe I could use "lacie,ns2_common" as a compatibility
>>>>> string. But this does not match any existing device. I
>>>>> don't know if it is correct.
...
>>> The status for this ns2 boards is more or less end-of-life. I
>>> mean, this boards are no longer in production. So I think it is
>>> safe to consider the code inside board-ns2.c as common and
>>> shareable between ns2, is2 and ns2max.
>>> 
>>> Once this file will be removed, the compatibility checks will
>>> be removed as well. But one could easily forget to remove the
>>> useless compatibility string "lacie,ns2_common" from the
>>> dts...
>> 
>> If that value is added to the DT, it should not be removed, and
>> the kernel should continue to support it indefinitely.
> 
> I understand it is a strong requirement. But as I mentioned before,
> due to the production process, one could easily end up with an
> embedded DTB not matching exactly the hardware. It could even be
> worse. A end-of-life device could be replaced by a supposed
> compatible one. And sometimes the compatibility assumption is
> false. In a such scenario, maybe you don't want the kernel to
> support indefinitely a DT statement.

I'm not sure I fully understand that last paragraph. However, if the
board is replaced by a new board model, and that new board model is
not 100% SW-compatible with the old model, then you'll want to invent
a new compatible value to represent the new board version. Removing
support from the kernel for the old compatible value, or keeping the
same compatible value and changing how the kernel handles it in a way
that prevents the original board and .dts from working, is not
appropriate.
