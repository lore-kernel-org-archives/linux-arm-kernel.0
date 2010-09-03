From: vipin.kumar@st.com (Vipin Kumar)
Date: Fri, 3 Sep 2010 12:41:56 +0530
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <4C7F5B9E.8090406@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
	<4C7F5B9E.8090406@st.com>
Message-ID: <4C809FBC.8020003@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 1:39 PM, Armando VISCONTI wrote:
> Ciao Linus,
> 
> Linus Walleij wrote:
>> 2010/8/30 Viresh KUMAR <viresh.kumar@st.com>:
>>
>>   
>>> From: Vipin Kumar <vipin.kumar@st.com>
>>>
>>> SPEAr platforms use Flexible Static Memory Controller(FSMC) provided by ST for
>>> interfacing with NAND devices.
>>> This patch adds the support for glue logic for NAND flash on SPEAr boards
>>>     
>>
>> OK...
>>
>>   
>>> (...)
>>>  create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h
>>>  create mode 100644 arch/arm/plat-spear/include/plat/nand.h
>>>  create mode 100644 drivers/mtd/nand/spear_nand.c
>>>     
>>
>> spear_nand.c?
>>
>> Why not fsmc-nand.c or similar if this is the name of the block.
>> We have this in U300, Nomadik NHK8815 and other platforms too,
>> it doesn't have much to do with SPEAr actually...
>>
>> Also, what are the include files doing in plat-spear since we have
>> the same hardware in other platforms? Move them to include/linux/mtd/
>> so we can use them please.
>>
>> I *highly* suspect that this driver duplicates some code found in
>> drivers/mtd/nand/nomadik_nand.c because it's the same silicon.
>>   
> Why nomadik_nand.c?
> Shouldn't the fsmc_nand.c rule apply also in this case?
> 
> 
>> Alessandro can judge on this, but I have a feeling that driver
>> should be replaced by this, more mature driver.
>>   

Hello All,

> Maybe.
> But I suspect that may be few differences in the ECC accelerator inside, 
> in fact.
> 
> In our FSMC previous case it was a Hamming accelerator, and I think this 
> apply
> also for nomadik (maybe). In our sp1300 case it is a BCH with 104 bytes 
> of ECC.

Adding on top of what Armando has already pointed out, FSMC block may 
have different versions and each of them may support different features 
based on its configuration eg. spear device's FSMC block is version8 
and is configured for 13 byte ecc(per 512 bytes data, BCH8 algorithm). 
There are other possibilities eg. BCH4, BCH2 etc which are not used in 
spear devices.

Making it generic would also entail supporting all possible configurations 
through single driver (makes more sense)

Customization was the prime reason for keeping the driver spear 
dependent and naming it as spear_nand.c

Alessandro/Sebastian: Is it OK to add a common driver for all FSMC versions
and customizations

Comments/Suggestions welcome

Regards
Vipin

> 
> This is one of the options when generating the h/w block, so FSMCs may 
> differ.
> If we want to re-use same driver I guess we might change something and 
> accept
> few parameters from the platform.
> 
> Vipin can for sure comment more on this.....
> 
> 
> Rgds,
> Arm
> 
