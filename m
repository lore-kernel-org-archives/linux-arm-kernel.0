From: hanjie.lin@amlogic.com (Hanjie Lin)
Date: Fri, 17 Aug 2018 14:12:55 +0800
Subject: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
In-Reply-To: <e5d9d89e79f8ec37b6337e54912f49a0b0856874.camel@baylibre.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
 <486e8ab477cc22ff231d2e18d7de22efba2c5abd.camel@baylibre.com>
 <2b87e834-41e3-e418-95f0-c6d695cd8b3f@amlogic.com>
 <e5d9d89e79f8ec37b6337e54912f49a0b0856874.camel@baylibre.com>
Message-ID: <91658f21-6934-6085-8deb-b85a1f6b7815@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/8/16 16:33, Jerome Brunet wrote:
> On Thu, 2018-08-16 at 11:05 +0800, Hanjie Lin wrote:
>>
>> On 2018/8/14 18:41, Jerome Brunet wrote:
>>> On Tue, 2018-08-14 at 02:12 -0400, Hanjie Lin wrote:
>>>> From: Yue Wang <yue.wang@amlogic.com>
>>>>
>>>> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
>>>> of the PCI Express Gen 2 specification and is backwardcompatible
>>>> with the 2.5-Gbps Gen 1.1 specification with only
>>>> inferred idle detection supported on AMLOGIC SoCs.
>>>
>>> It looks like the sole purpose of this driver is to provide the reset lines to
>>> pcie driver.
>>>
>>> I wonder why we need this ? Can't the pcie driver claim the reset lines itself.
>>>
>>> Also, an init of this phy will always reset both port. What will happen if the
>>> first port is in use and the 2nd port comes up ?? 
>>>
>>> Looks the the pcie driver should claim 'apb' and 'phy' reset lines as "shared"
>>> reset and the required 'port' as 'exclusive'
>>>
>>
>> Thank you for your response.
>>
>> Yes, 'apb' and 'phy' reset lines are shared, and ?port' reset line is exclusive.
>> If we handle all reset lines during the first port initial sequence, 
>> and when the second port comes up, we will do nothing about the rest lines, 
>> and don't need a extra API to do ?port' reset;
> 
> With which other driver are your control shared ?
> 
> Looks it is the answer is none since this phy driver will reset both port
> already, even if one is used.
> 
> In this case the fact that you are using shared control is just abusing the
> framework to reset once.
> 
> As far as I can tell, this driver makes no sense. The appropriate reset lines
> should be given directly to your pcie driver. 
> 
> 
> 
> .
> 

Amlogic AXG SOC includes two pcie controllers and pipes when only one pcie phy: 

                                    (port_a reset)
                      |PCIE_RC_A---->PCIE_PIPE_A------| 
    (apb_reset)       |                               |  (phy reset)
    APB BUS--->       |                               |   PCIE_PHY
                      |                               |
                      |             (port_b_reset)    |
                      |PCIE_RC_B---->PCIE_PIPE_B------|

The phy_reset affect the PCIE_PHY.
The port_a_reset affect the PCIE_PIPE_A, port_b_reset affect the PCIE_PIPE_B. 

As your suggestion we will move the 'port' reset to controller driver,
and keeping the phy driver to process the 'apb' and 'phy' reset or any
more changes of the phy in future.
