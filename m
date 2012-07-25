From: deepak.sikri@st.com (deepaksi)
Date: Wed, 25 Jul 2012 10:03:16 +0530
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <50068030.1050905@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <CAOh2x==ob+N26pJdc1DC8DfOomus1robkj=8DeyVE_ve_L-bAA@mail.gmail.com>
 <500537C2.1030501@st.com> <201207171653.45688.arnd@arndb.de>
 <50068030.1050905@st.com>
Message-ID: <500F770C.9000005@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

>>>
>> I don't think that the STMMAC_PLATFORM part is used by any other
>> platform in the mainline kernel, so we are definitely free to
>> rip out (parts of) the platform_data and replace them with DT
>> properties.
>> There is also no platform defining plat_stmmacenet_data
>> yet, which means that the code is completely untested at
>> the moment.
>>
>> Don't worry about any out-of-tree platforms, they can keep
>> their out of tree patches to add back the platform data if
>> they don't want to move to DT booting.
>>
>> Since all the data you are adding to spear1340.c is constant
>> anyway, I suppose that means this data is specific to
>> the spear1340 soc, not to a particular board or configuration.
>> I would suggest you add a preset like
>>
>> static const struct of_device_id stmmac_dt_ids[] = {
>>          { .compatible = "st,spear600-gmac", .data =&spear600_data},
>>          { .compatible = "st,spear1340-gmac", .data =&spear1340_data}
>> };
>>
>> that contains all the soc-specific data. You can probably make
>> that "const" and just kill off the platform_data path in the
>> driver.
>

I am sorry but bringing alive this discussion once again, as we have 
some implementation
specific open points.

1. In case we go by the above proposal, it kind of solves a few things 
for us, such as

- Through the DT blob it was difficult to plug in some of the platform 
specific callbacks
which kind of did few things that driver needed before it could be 
operational. In SPEAr
architecture we have a miscellaneous space which provides SOC specific
initializations used by devices which can be handled by these callbacks.

Now with the approach suggested, we have the flexibility to add on these 
callbacks,
where DT is not sufficient and move further.

*But there are few catches/ query I have with me.*

1. Within the driver space now, even if it is a stmmac_platform.c file 
we are kind of adding
a non driver related miscellaneous space (SoC specific) to do some 
initializations.
Will that be fine to do all such initializations in driver ?

2. If yes, then it is kind of moving all the platform related 
initializations into driver, and these
could be varying across machines, for example with SPEAr, 6xx /3xx/13xx 
may all have
different callbacks; and then take it to next level when the stmmac 
driver would be shared
across the platforms, and all initializations will plug into this file.
It sounds more of collaborating of all the ethernet driver information 
which previously existed
across platforms into one area, and making the driver space untidy.
I would seek your opinion and suggestions on this.

Regards
Deepak
