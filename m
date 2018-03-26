From: liwei213@huawei.com (liwei (CM))
Date: Mon, 26 Mar 2018 12:01:56 +0000
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIIHY4IDIvNV0gZHQtYmlu?=
 =?utf-8?Q?dings:_scsi:_ufs:_add_document_for_hisi-ufs?=
In-Reply-To: <CAK8P3a29sDaEj=iTkru-3mc9NpjNvZos3Z+h5UsT1cAeULoGHw@mail.gmail.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-3-liwei213@huawei.com>
 <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA584ED@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a3NdHLDf2vOMyZ1qcWNW1Jg5T47qR0qWhWEeDn+90S4ug@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA58798@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a29sDaEj=iTkru-3mc9NpjNvZos3Z+h5UsT1cAeULoGHw@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA587B5@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

I'll ask our soc colleagues for help and give a detailed and accurate explanation aosp.

Thanks!


-----????-----
???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd Bergmann
????: 2018?3?26? 18:42
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; zangleigang; Gengjianfeng; Guodong Xu; Zhangfei Gao; Fengbaopeng (kevin, Kirin Solution Dept); Yaniv Gardi
??: Re: ??: ??: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Mon, Mar 26, 2018 at 12:26 PM, liwei (CM) <liwei213@huawei.com> wrote:
> ???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd 
> Bergmann
> > ??: Re: ??: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for 
> > hisi-ufs On Fri, Mar 23, 2018 at 3:22 AM, liwei (CM) <liwei213@huawei.com> wrote:
> >> The clock names sound generic enough, should we have both in the generic binding?
> >>
> >> Do you mean that add a "phy_clk" to ufshcd-pltfrm 's bindings?
> >> At present, it seems that in the implementation of generic code, 
> >> apart from "ref_clk" may have special processing, other clk will 
> >> not have special processing and simply parse and enable; Referring 
> >> to ufs-qcom binding, I think "phy_clk" can be named "iface_clk", 
> >> this "iface_clk" exists in ufshcd-pltfrm bindings;If so, "ref_clk", "iface_clk" are both in the generic binding,we will remove them here. Is that okay?
>
> > I'm looking at the generic binding again, and it seems we never 
> > quite managed to fix some minor problems with it. See below for a possible way to clarify it.
>
> phy_clk is actually given to the phy. But as previously mentioned , we 
> do not have a separate phy to configure ; The clks in the patch you 
> give appear to be unsuitable for describing this .
> Here we can't describe phy_clk in the node "ufsphy1: ufsphy at fc597000" like qcom.
> So can we put it here in our own binding like this?

I think the concept of having a phy clk is generic enough that it's better to have that in the common part, others will surely have the same thing, and in this case, qcom would be the exception that does not use one.

There are apparently a couple of things related to the phy that may or may not require a clk:

- ref_clk: The reference clock on the mipi bus, this is what qcom have, this would
  be the 19.2 MHz clock signal.
- one clock to drive the logic block for the PHY itself, if it is included within
  the same logical portion of an SoC as the ufshcd, but uses a separate clock.
- Looking at the Android kernel as distributed by google/qualcomm, they have
  four separate clocks described as

    PHY to controller symbol synchronization clocks:
        "rx_lane0_sync_clk" - RX Lane 0
        "rx_lane1_sync_clk" - RX Lane 1
        "tx_lane0_sync_clk" - TX Lane 0
        "tx_lane1_sync_clk" - TX Lane 1

Which of the above would your phy_clk refer to?

       Arnd

[1] https://android.googlesource.com/kernel/msm/+/android-msm-bullhead-3.10-marshmallow-dr/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt?autodive=0%2F%2F%2F%2F%2F
