From: deepak.sikri@st.com (deepaksi)
Date: Tue, 17 Jul 2012 15:55:57 +0530
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <201207131422.26274.arnd@arndb.de>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <214127499f10b0099e6f3542e1e879fdd8c1bdcf.1342171151.git.vipulkumar.samar@st.com>
 <CAOh2x==ob+N26pJdc1DC8DfOomus1robkj=8DeyVE_ve_L-bAA@mail.gmail.com>
 <201207131422.26274.arnd@arndb.de>
Message-ID: <50053DB5.1010704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


On 7/13/2012 7:52 PM, Arnd Bergmann wrote:
> On Friday 13 July 2012, viresh kumar wrote:
>> Adding Stefan and Peppe.
>>
>> I understand why you can't send all platform data from DT.
>> Let me elaborate the problem statement
>>
>> stmmac is used by platforms with and without DT.
>> - Without DT will pass platform data directly, without any issues.
>> - With DT have to pass all data, some of that via DT and other without
>> DT, like routines
>>    (atleast for now)
>>
>> For now what I suggest is, update DT support for whatever we can..
>> i.e. support Maximum
>> properties there. As finally we will support everything via DT, no
>> platform data.
>>
>> Whatever is left, that can't be passed via DT, like routine, pass it
>> from platform data
>> and merge both these versions of platform data in driver, keeping DT
>> ones in priority.
>>
>> i.e. Whatever is defined in DT properties must come from there and
>> left outs from
>> platform data.
> Absolutely agreed.
>
> The one part I think you both have wrong is the idea that the
> spear13xx_eth_phy_clk_cfg function is needed.
>
> I believe the correct answer for this is to introduce a driver for
> the phy in drivers/net/phy/, and have the phy be described correctly
> in the device tree and referenced found using the of_phy_find_device()
> function.

SPEAr platform has been using the generic phy framework, and it just 
requires a register into mdio
bus and provide the necessary callback w.r.t mdio read and write. These 
mdio read and write are more
into the GMAC registers, and hence a part of stmmac driver.

As far as my understanding is concerned, addition to the phy framework 
could have been done had it been
some phy from stmicro, which requires some special addressing to be done.
The function we are talking about is more related to handling the 
interface that phy has. The stmmac core has
been configured as rmii/smii/rgmii and requires the system to generate 
corresponding clock to support data
transfers over PHY.
This was specifically the reason of aligning the phy clock configuration 
function with stmmac driver, and could
well be taken as functional interface clock for mac core.
I do think that we should not add a new driver for aligning the clock 
settings of the interfaces.


Regards
Deepak



>
> 	Arnd
> .
>
