From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Aug 2013 14:24:31 -0600
Subject: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1376425077.3167.6.camel@linux-builds1>
References: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
 <520A8E71.4090508@wwwdotorg.org> <1376423915.3167.2.camel@linux-builds1>
 <520A92D2.2090208@wwwdotorg.org> <1376425077.3167.6.camel@linux-builds1>
Message-ID: <520A95FF.9050105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2013 02:17 PM, Dinh Nguyen wrote:
> On Tue, 2013-08-13 at 14:10 -0600, Stephen Warren wrote:
>> On 08/13/2013 01:58 PM, Dinh Nguyen wrote:
>>> On Tue, 2013-08-13 at 13:52 -0600, Stephen Warren wrote:
>>>> On 08/12/2013 09:49 AM, dinguyen at altera.com wrote:
>>>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>>>
>>>>> Add bindings for SD/MMC for SOCFPGA.
>>>>> Add "syscon" to the "altr,sys-mgr" binding.
>>
>>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>>
>>>>>  		sysmgr at ffd08000 {
>>>>> -				compatible = "altr,sys-mgr";
>>>>> +				compatible = "altr,sys-mgr", "syscon";
>>>>
>>>> That seems like an unrelated change?
>>>
>>> This patch is to enable SD/MMC for SOCFPGA. The "syscon" is needed in
>>> dw_mmc-socfpga.c as the clock phases for the SD IP is controlled by
>>> registers in "altr,sys-mgr".
>>
>> But nothing in the dwmmc nodes refers to the syscon node, so how can the
>> syscon driver possibly provide services to the MMC driver; the MMC
>> driver won't be able to find it. I hope there's no back-door assumption
>> that some syscon exists, and that there's only one of them...
> 
> In dw_mmc-socfpga.c:
> 
> priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> 
> then, uses regmap_write() to set the correct values from
>  "altr,dw-mshc-sdr-timing".

Uggh. There should really be a phandle from the MMC node to the syscon
node to specify the connectivity. What if there ends up being 2 HW
modules that are sys-mgr?

At the very least, the binding for any device that's affected by the
sys-mgr should specify that some other node must exist with that
compatible value, to provide XXX services for it.

But, I wonder if the altr,dw-mshc-sdr-timing property shouldn't be part
of the syscon node itself?

(Probably best to ignore my ack for now given this new information)

> This was a suggestion from Arnd. It seems that this part of patch is
> causing alot of confusion, I should just split the patches out?

A separate patch to change that compatible value probably would make
sense; by the sound of it, that change would also be required for a lot
of other devices on the SoC; it's not just specific to MMC?
