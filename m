From: phoenix.liyi@huawei.com (liyi 00215672)
Date: Mon, 19 Jan 2015 01:27:02 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIdjRdIGFybTY0OiBkbWk6IEFkZCBTTUJJT1MvRE1JIHN1?=
 =?gb2312?Q?pport?=
In-Reply-To: <54BA7B0E.5020207@redhat.com>
References: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
 <54B9F9D2.6000104@redhat.com> <20150117121247.GL3827@bivouac.eciton.net>
 <54BA7B0E.5020207@redhat.com>
Message-ID: <D0F5605BA99F0B4594FB1EEC24E785CC6549F905@SZXEMA510-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon, Leif,

	I am reviving with phoenix.liyi at huawei.com :)

	Agreed with Leif, The DMI/SMBIOS data are available for user space not for kernel level on x86, which means if DMI has some bad descriptions, it should not affect the kernel boot normally.

	So ARM platform will do the same thing, DMI data just as a reference for system configuration, and don't depend them to boot the sytem. :)

	Thanks!

Yi

-----????-----
???: Jon Masters [mailto:jcm at redhat.com] 
????: 2015?1?17? 23:09
???: Leif Lindholm
??: msalter at redhat.com; catalin.marinas at arm.com; will.deacon at arm.com; linux-arm-kernel at lists.infradead.org; grant.likely at linaro.org; liyi 00215672; ard.biesheuvel at linaro.org
??: Re: [PATCHv4] arm64: dmi: Add SMBIOS/DMI support

On 01/17/2015 07:12 AM, Leif Lindholm wrote:
> Hi Jon,
> 
> On Sat, Jan 17, 2015 at 12:57:38AM -0500, Jon Masters wrote:
>> Hi Yi Li,
> 
> Yi has gone back to work inside Huawei, so probably did not receive 
> your messags.

Good to know. I was at one point tracking all of the engineers involved but it's getting harder to do that :)

>> I would like some advice on the below patch. First, a little background.
>>
>> I /may/ need to use SMBIOS provided data on ARMv8 systems to 
>> enumerate the number of physical underlying CPU sockets present.
> 
> This sounds like a very risky precedent to set. Hardware description 
> for the kernel comes in the form of DT or ACPI. SMBIOS is hardware 
> description for userland.

Agreed. I don't actually want to set this precedent on ARM yet :)

> x86 added internal access to SMBIOS tables to be able to work around 
> known-bad firmware. I would say we're in a much better place today 
> with regards to people actually testing hardware with Linux than when 
> that happened, so would really like to avoid opening those floodgates 
> on ARM*.

Fair enough. I suspect we may get there one day, but I'm certainly not going to try to move that along :) I have btw pushed every vendor to rev their build information each time they build new firmware (when we build the RH reference firmware for Mustang and - other boards I won't mention on list - we do rev the version), and we'll require it in SBBR. That's on my todo list for a clarification.

> The rest of this email is therefore assuming we are talking about a 
> temporary out-of-tree patch kept for development purposes until a 
> better solution can be devised to upstream.

Yup. I'm just exploring all of the options. Currently, there is no reliable way to extract the exact number of sockets present, even with the DT binding, and I need to know precisely how many sockets there are, with this information correctly provided in the sysfs topology.

>> This is provided
>> in one Type4 DMI structure per physical socket. Using that fact (such 
>> data is already provided by all of the reference ARMv8 server 
>> systems), and a variable interpretation of the CPU affinity data, we 
>> can refactor the topology.c code to understand threads vs cores vs 
>> sockets without getting confused by the extra levels of hierarchy for clusters.
>>
>> I am going back over some older patches, including this one to 
>> understand the DMI port, and I notice that you call dmi_scan_machine 
>> from an early_initcall. This will run from the init thread, after 
>> we've done basic SMP setup in smp_prepare_cpus, which is where we 
>> stash cpu_topology data, which is after I already need DMI data available.
> 
> Yep.
> 
>> So. If I wanted this available prior to early_initcall time, would it 
>> be reasonable to follow e.g. x86 and move this early in the boot? I'm 
>> not necessarily going to ask to upstream such a change (since I 
>> expect to be able to solve the underlying problem I am looking to 
>> address in a different fashion soon), but first want to know if it 
>> would be reasonable to ask to do that anyway.
> 
> My suggestion would be to not try to over-engineer a patch not going 
> upstream. Move the call before smp_prepare_cpus() in init/main.c.

I guess. I don't like not overdoing things. You've met me right? ;)

> Or, if you can be fairly certain your SMBIOS table is covered by the 
> linear mapping, move the call to setup_arch().

I thought about that. I think I can assume this, but I am not certain.
I'm going to ponder that. For now, the above (move before SMP setup) is probably the way I'll go with it as a hackish kludge.

>> P.S. I'm not interested at all in replies pointing me to the existing 
>> DT cpu topology binding, which I am well aware of, but it does also 
>> not actually solve the problem I have :)
> 
> Not going to point, but perhaps the correct answer is to ensure the 
> information you need is provided via DT/ACPI. As your email hints at.

Yep. I've multiple threads going to get this addressed properly.

Thanks Leif!

Jon.
