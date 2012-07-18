From: deepak.sikri@st.com (deepaksi)
Date: Wed, 18 Jul 2012 14:51:52 +0530
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <201207171653.45688.arnd@arndb.de>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <CAOh2x==ob+N26pJdc1DC8DfOomus1robkj=8DeyVE_ve_L-bAA@mail.gmail.com>
 <500537C2.1030501@st.com> <201207171653.45688.arnd@arndb.de>
Message-ID: <50068030.1050905@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 7/17/2012 10:23 PM, Arnd Bergmann wrote:
> On Tuesday 17 July 2012, deepaksi wrote:
>> I do differ on the point over here. I do believe that the code for now
>> should be left as into mutually
>> exclusive sections.
>> As you said, without DT, the platform data would exist without any
>> problem, Thats fine
>>
>> But with DT also, as of now since the DT is still evolving we should not
>> merge the data and keep it at
>> two places. The reasons being.
>> The stmmac driver is being used by multiple platforms, lets say within
>> spear we have different variants
>> requiring different configurations and dividing those configurations at
>> two different places will require larger
>> maintenance.
> I don't think that the STMMAC_PLATFORM part is used by any other
> platform in the mainline kernel, so we are definitely free to
> rip out (parts of) the platform_data and replace them with DT
> properties.
> There is also no platform defining plat_stmmacenet_data
> yet, which means that the code is completely untested at
> the moment.
>
> Don't worry about any out-of-tree platforms, they can keep
> their out of tree patches to add back the platform data if
> they don't want to move to DT booting.
>
> Since all the data you are adding to spear1340.c is constant
> anyway, I suppose that means this data is specific to
> the spear1340 soc, not to a particular board or configuration.
> I would suggest you add a preset like
>
> static const struct of_device_id stmmac_dt_ids[] = {
>          { .compatible = "st,spear600-gmac", .data =&spear600_data},
>          { .compatible = "st,spear1340-gmac", .data =&spear1340_data}
> };
>
> that contains all the soc-specific data. You can probably make
> that "const" and just kill off the platform_data path in the
> driver.

Sure, we will do it as per the suggestions.

Regards
Deepak

>> Any more changes in driver that has dependency on the
>> platform data will require updates,
>> and more such conflicts will arrive related to maintenance.
>>
>> Lets keep the platform data as a part of AUXDATA for now, till the tree
>> evolves fully specifically if DT is being
>> used.
> SPEAr is already fully using DT for everything except DMA channels.
> Please don't add any more such exceptions.
>
> 	Arnd
> .
>
