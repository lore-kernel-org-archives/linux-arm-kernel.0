From: slash.tmp@free.fr (Mason)
Date: Mon, 28 Nov 2016 17:52:28 +0100
Subject: arasan,sdhci.txt "compatibility" DT binding
In-Reply-To: <14771688.Q8f97gHC2H@wuerfel>
References: <56B07BA5.4060407@free.fr>
 <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com> <583C50E7.6030400@free.fr>
 <14771688.Q8f97gHC2H@wuerfel>
Message-ID: <583C60CC.2020408@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/2016 17:15, Arnd Bergmann wrote:

> On Monday, November 28, 2016 4:44:39 PM CET Mason wrote:
>
>> Hello,
>>
>> @Shawn Lin, could you take a look below and tell me exactly
>> which IP core(s) Rockchip is using in its SoCs?
>>
>> Based on the feedback I received, here is an updated list of
>> compatible strings and controller versions dealt with by the
>> drivers/mmc/host/sdhci-of-arasan.c code.
>>
>>
>> Xilinx Zynq:
>> "SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
>> "arasan,sdhci-8.9a"
>> NB: 8.9a is the documentation revision (dated 2011-10-19)
>> subsequent tweaks labeled 9.0a, 9.1a, 9.2a
>>
>> Xilinx ZynqMP:
>> "SD3.0 / SDIO3.0 / eMMC4.51 AHB Host Controller"
>> "arasan,sdhci-8.9a"
>> NB: using the same compatible string as Zynq
>>
>> Sigma SMP87xx
>> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
>> no compatible string yet, platform-specific init required
>>
>> APM:
>> "SD3.0 / SDIO3.0 / eMMC4.41 AHB Host Controller"
>> "arasan,sdhci-4.9a"
>> NB: 4.9a appears to be the documentation revision
>> no functional diff with "arasan,sdhci-8.9a"
>>
>> Rockchip
>> Exact IP unknown, waiting for Shawn's answer
>> "arasan,sdhci-5.1"
>> NB: 5.1 appears to refer to the eMMC standard supported
>>
>>
>> On a final note, there are many variations of the Arasan IP.
>> I've tracked down at least the following:
>>
>> SD_2.0_SDIO_2.0__MMC_3.31_AHB_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.41_OCP_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
>> SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller.pdf
>> SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller.pdf
>>
>> It seems to me the compatible string should specify
>> the SD/SDIO version AND the eMMC version, since it
>> seems many combinations are allowed, e.g. eMMC 4.51
>> has two possible SD versions.
>>
>> What do you think?
> 
> It seems wrong to have the eMMC or SD version in the compatible
> string.  Is that the only difference between the documents you
> found? Normally there should be a version of IP block itself,
> besides the supported protocol.

But that is exactly the problem :-)

Nowhere in the documentation do they specify an "IP version".
Some documents do provide a revision number, but that's just
a *documentation* revision number, e.g.

changes in version 3.6 : fix typos
changes in version 9.1a : update company logo

That's why Xilinx used "arasan,sdhci-8.9a" and APM used
"arasan,sdhci-4.9a". These are documentation revisions.
In my opinion, that information is mostly worthless.


Looking more closely at SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
(User Guide, which has more info than Datasheet) I see this:

Changed Host Controller Version Register value from 16'h0002 to 16'h7501
Changed Host Controller Version Register value from 16'h8301 to 16'h8401
Changed Host Controller Version Register value from 16'h8401 to 16'h8501
Changed Host Controller Version Register to 16'h9502
Changed Host Controller Version Register to 16'h9602
Changed Host Controller Version Register to 16'h9902

Host controller version register (offset 0FEh)

Vendor Version Number 15:8
HwInit=0x99
This status is reserved for the vendor version number.
The HD should not use this status.

Specification Version Number 7:0
HwInit=0x02
This status indicates the Host Controller Spec. Version.
The upper and lower 4-bits indicate the version.
Description
00 - SD Host Specification version 1.0
01 - SD Host Specification version 2.00
including only the feature of the Test Register
02 - SD Host Specification Version 3.00
others - Reserved

I'm not sure what this "Vendor Version Number" specifies, nor if is
guaranteed to be unique across controllers.

In SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller_UserGuide.pdf,
they write "The Vendor Version Number is set to 0x10 (1.0)"

I don't have a UserGuide for "arasan,sdhci-5.1".

Regards.
