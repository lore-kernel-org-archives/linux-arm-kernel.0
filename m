From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 27 Jan 2015 09:48:43 -0700
Subject: [PATCH v2 04/11] ARM: tegra: Set spi-max-frequency property to
 flash node
In-Reply-To: <CAAObsKDx_W23OTL2RE4xxgXL-rtp3npkBtx6qMHV1j8ZXmo1rw@mail.gmail.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-5-git-send-email-tomeu.vizoso@collabora.com>
 <54B7F84A.6020906@wwwdotorg.org>
 <CAAObsKDx_W23OTL2RE4xxgXL-rtp3npkBtx6qMHV1j8ZXmo1rw@mail.gmail.com>
Message-ID: <54C7C16B.2080003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2015 04:13 AM, Tomeu Vizoso wrote:
> On 15 January 2015 at 18:26, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>>
>>> To silence a warning on Nyan boards.
>>>
>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>> ---
>>>    arch/arm/boot/dts/tegra124-nyan-big.dts | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> b/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> index 9a9cffe..94c7ba9 100644
>>> --- a/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> @@ -1660,6 +1660,7 @@
>>>
>>>                  flash at 0 {
>>>                          compatible = "winbond,w25q32dw";
>>> +                       spi-max-frequency = <25000000>;
>>
>>
>> This property already exists in the SPI controller. Isn't the max frequency
>> supposed to inherit from there? If so, shouldn't the code not warn when such
>> inheritance happens, i.e. it'd be better to fix the code?
>
> I don't think it's supposed to fall back to the controller's max freq,
> as each device has its own maximum frequency that it can support and
> it's not related to what the master supports.

If the controller-specific frequency property isn't ever used, we should 
remove it. No point carrying cruft that looks like it does something but 
doesn't.

Logically, each device's max frequency certainly should be influenced by 
all of the controller, board, and device max frequency. Those should all 
impose a cap on the speed used. I'd expect this to be expressed in DT as 
a single property in each device where the user has calculated that max 
for the device, with the option to have all the devices fall back to the 
"default" provided at the controller/bus level if the device imposes a 
cap that's no lower.
