From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 8 Oct 2015 16:30:15 +0100
Subject: [linux-sunxi] [PATCH v2 1/2] mmc: Add support for marking hpi as
 broken through devicetree
In-Reply-To: <56166271.4060302@schinagl.nl>
References: <1427901984-26469-1-git-send-email-hdegoede@redhat.com>
 <5614DB4E.8040807@schinagl.nl> <56162CAE.6000105@redhat.com>
 <56165DD9.2000008@schinagl.nl> <56166271.4060302@schinagl.nl>
Message-ID: <56168C07.2060108@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/08/2015 01:32 PM, Olliver Schinagl wrote:
> Hey Hans,
>
> On 08-10-15 14:13, Olliver Schinagl wrote:
>> Hey Hans,
>>
>>
>> On 08-10-15 10:43, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10/07/2015 09:43 AM, Olliver Schinagl wrote:
>>>> Hey Hans,
>>>>
>>>> On 01-04-15 17:26, Hans de Goede wrote:
>>>>> The eMMC on a tablet I've will stop working / communicating as soon as
>>>>> the kernel executes:
>>>>>
>>>>>         mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>>>                   EXT_CSD_HPI_MGMT, 1,
>>>>>                   card->ext_csd.generic_cmd6_time);
>>>>>
>>>>> There seems to be no way to reliable identify eMMC-s which have a broken
>>>>> hpi implementation, but at least for eMMC's which are soldered onto a board
>>>>> we can work around this by specifying that hpi is broken in devicetree.
>>>> We've been talking about this a little off-list, and I was just triggered again by this so I'm following up on it again.
>>>>
>>>> The same issue bit me in the ass on a Micron 'industrial' grade eMMC (MTFC4GACAANA) and luckily you found this back then to help me.
>>>>
>>>> As we discussed, this may very well be a limitation of the mmc controller, rather then the MMC chip. While we only have a sample size of 2 on 2 different socs (with likely the same mmc IP) (A13/A20) I found in the JEDEC spec in the appendix on changes from 4.4 to 4.41:
>>>> Introduce of High Priority Interrupt mechanism, HPI background and one of possible solutions.
>>>>
>>>> Which leaves me to believe, that HPI was added to eMMC in version 4.41 and was not available before. Both the A13 and A20 user manuals state that the MMC controller in these socs is only version 4.3.
>>>>
>>>> Obviously I know far to little as to what does and what does not work with an MMC-host, since it's just a simple data-bus, but I would not be surprised if these things are somewhere somewhat related, so hopefully someone on this list can give their opinion on this.
>>>>
>>>> I already checked the core/mmc.c where the version is read from the mmc controller to see if we can trigger on this based on version, however it seems only the major version number is stored here [0]?
>>>>
>>>> So in my opinion, it is quite likely that this setting be moved up to the mmc-core level, for the SoC, rather then the card itself?
>>>
>>> Yes I was talking to Tsvetan from Olimex and he says they have seen the problem with yet
>>> another emmc, so this indeed seems to be a sunxi SoC specific problem, and we just need to
>>> disable hpi on all sunxi SoC's.
>>>
>>> Do you have time to look into doing a kernel patch for this ?
>>>
>>> I'm thinking adding a host-cap called MMC_CAP_BROKEN_HPI and adding
>>> support for that to drivers/mmc/core/host.c: mmc_of_parse() and
>>> extending the current card check for broken-hpi to also check
>>> host->caps
>>>
>>> And then we need to decide whether to just hard set that cap
>>> in drivers/mmc/host/sunxi_mmc.c or if we are going to add it
>>> to our dtsi files. I think we should probably just hard-code
>>> it in drivers/mmc/host/sunxi_mmc.c.
>> Yeah I'll see if I can look into that.
>>
>> I was also looking if we really cannot detect older MMC versions, and I think we can somewhat. I haven't figured out the details yet though.
>>
>> The EXT_CSD_REV field does yield a version number matching the various 4 sub-versions, so for now I'm thinking of simply disabeling HPI for anything before 4.41 (unless maybe overriden). Since before 4.41 it shouldn't have been supported. Maybe add an override that allows use of HPI? but then we have the whole backwards compatibility thing.
>>
>> [0] http://lxr.free-electrons.com/source/drivers/mmc/core/mmc.c#L368
>
> I re-read what you said and looked at the files and think your idea is probably best, since there is no version information (in sunxi_mmc.c for example) anyway). So there is versioning information on the card level and the mmc core level, but not in the host level.
>
> The quick fix, is to use MMC_CAP_BROKEN_HPI
> The better fix that would feel better/proper to use MMC_CAP_HPI instead, to indicate that a chipset actually can do HPI, since nothing says our chipset should do HPI (v4.3 that we have doesn't support it at all).

Maybe, I think for starters doing a MMC_CAP_BROKEN_HPI is best, and then
later maybe do an RFC patch to introduce MMC_CAP_HPI instead, this
becomes difficult quickly though, e.g. on which controllers should
we enable MMC_CAP_HPI ?  Since sunxi currently is the only SoC having
issues with this, I think that MMC_CAP_BROKEN_HPI is the best way to
deal with this.

> I'm debating if it would be usefull to have a version field in the mmc host struct,

I'm not familiar enough with mmc to say for sure, but I've the feeling that
a lot of card caps introduced in later specs can be used by older hosts
just fine, since they are only a matter of changing the host-driver /
mmc-core. I think it is best to just go for the KISS solution here,
introduce the MMC_CAP_BROKEN_HPI flag and leave it at that.

> which would set some capabilities by default based on the version level, but I don't think we have that many capabilities right now anyway do we?
>
> P.S. you want to keep the broken-hpi flag (on a card level?) for backwards compatibility with older dts files?

I think we should keep it, it may also be useful for non sunxi boards
in some cases.

Regards,

Hans
