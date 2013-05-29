From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 May 2013 09:35:30 -0600
Subject: [PATCH 4/4] ARM: tegra: pcie: Enable PCIe controller on Cardhu
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB91B616BE9B@BGMAIL01.nvidia.com>
References: <1368010660-31465-1-git-send-email-jagarwal@nvidia.com>
 <1368010660-31465-4-git-send-email-jagarwal@nvidia.com>
 <518A8596.7070702@wwwdotorg.org>
 <C79B248886DD134989C8FF6B096A91AB91B4886B5D@BGMAIL01.nvidia.com>
 <C79B248886DD134989C8FF6B096A91AB91B4886B6C@BGMAIL01.nvidia.com>
 <C79B248886DD134989C8FF6B096A91AB91B616BE9B@BGMAIL01.nvidia.com>
Message-ID: <51A62042.7070304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 04:10 AM, Jay Agarwal wrote:
>>>> So, if I apply this series, I do see the PCIe bridge and Ethernet
>>>> device get enumerated, but I don't see the USB3 controller get
>>>> enumerated. I believe that is a PCIe device behind the same bridge
>>>> on the
>>> same Tegra PCIe port.
>>>> Shouldn't this device show up?
>>> I have also reproduced this problem. I see somehow no non-
>>> prefetchable memory is assigned to any of pcie devices.
>>> Probably that is the reason for USB3 (pci 0000:04:00.0) not getting
>>> enumerated since it uses only non-prefetchable memory.
>>
>> 1. Bus4(on which usb3 device resides) always return 0xffffffff from it's
>> config space. which means device is not present?
>> 2. That's why it is not assigned any resources and hence no usb3 probe
>> happens.
>> 3. But same bus does return valid info like vendor/device id etc from it's
>> config space in downstream kernel and hence usb3 probe does happen.
>>
>> Thierry, Stephen,
>> 4. Any idea why bus4 should return 0xffffffff values in upstream kernel?
>> Anything missing?
>> 5. Also, how config space of all pcie devices are mapped? I mean if I change
>> the config space offset in dts file, then also I find correct vendor/device id
>> etc for bus0/device0/fun0.
>>     So how this mapping happens that even after changing the config space
>> offset in PCIe address space, it always finds correct vendor/device id.
> 
>  Any idea on this?

I did already reply the same day you sent the original email. My
response was:

Is there some reset/enable GPIO or regulator that needs to be programmed
to enable the PCIe USB3 controller? Take a look at the schematic. If you
can make it work by tweaking those GPIOs/... manually, then we can
ignore this issue and fix it up later, since it's not directly related
to the PCIe controller driver patches. It's more important to get the
Ethernet working than USB, I think.

To be honest though, I would expect you to be asking around inside
NVIDIA to determine the answer here. As the PCIe SW expert, I'd expect
you to drive this process. Try asking the Cardhu board and PCIe HW
experts within NVIDIA.

Did you make any progress on the issues with the Ethernet device?
