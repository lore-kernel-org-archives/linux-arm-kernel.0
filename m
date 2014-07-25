From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 25 Jul 2014 10:24:56 +0200
Subject: [PATCH v2 06/11] ARM: dts: zynq: Add DMAC for Parallella
In-Reply-To: <53D20F2A.5020209@monstr.eu>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-7-git-send-email-afaerber@suse.de>
 <bc390439-9a5b-43a1-a70c-a4c6517a6cb6@BN1AFFO11FD005.protection.gbl>
 <53D20F2A.5020209@monstr.eu>
Message-ID: <53D21458.3060403@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.07.2014 10:02, schrieb Michal Simek:
> On 07/25/2014 01:28 AM, S?ren Brinkmann wrote:
>> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  v2: New
>>>  
>>>  arch/arm/boot/dts/zynq-7000.dtsi      | 17 +++++++++++++++++
>>>  arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
>>>  2 files changed, 21 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>> index eed3df0..1a70277 100644
>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>> @@ -223,6 +223,23 @@
>>>  			};
>>>  		};
>>>  
>>> +		dmac_s: dmac at f8003000 {
>>> +			compatible = "arm,pl330", "arm,primecell";
>>> +			reg = <0xf8003000 0x1000>;
>>> +			status = "disabled";
>> I think for this IP we can omit the 'status' property since it is always
>> enabled. I don't see a reason to override it in each board DT.
> 
> Done this change myself

Fine with me, but allow me to point out that the TRM documents the DMAC
being mapped as DMAC S at the above address, and as DMAC NS at F800_4000
(secure vs. non-secure, ch. 4.6, p. 116). Not sure how this would be
handled driver-wise if not through alternative dt nodes?

>>> +			interrupt-parent = <&intc>;
>>> +			interrupts = <0 13 4>,
>>> +			             <0 14 4>, <0 15 4>,
>>> +			             <0 16 4>, <0 17 4>,
>>> +			             <0 40 4>, <0 41 4>,
>>> +			             <0 42 4>, <0 43 4>;
>>> +			#dma-cells = <1>;
>>> +			#dma-channels = <8>;
>>> +			#dma-requests = <4>;
>>> +			clocks = <&clkc 27>;
>>> +			clock-names = "apb_pclk";
>>> +		};
>>> +
>>
>> Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> 
> Applied to zynq/dt branch.
> https://github.com/Xilinx/linux-xlnx/commits/zynq/dt

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/a57e71e3/attachment-0001.sig>
