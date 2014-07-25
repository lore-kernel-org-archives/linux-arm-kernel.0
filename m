From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 25 Jul 2014 10:36:03 +0200
Subject: [PATCH v2 06/11] ARM: dts: zynq: Add DMAC for Parallella
In-Reply-To: <53D21458.3060403@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-7-git-send-email-afaerber@suse.de>
 <bc390439-9a5b-43a1-a70c-a4c6517a6cb6@BN1AFFO11FD005.protection.gbl>
 <53D20F2A.5020209@monstr.eu> <53D21458.3060403@suse.de>
Message-ID: <42796bf5-b27c-4009-894d-9462c85e2bc2@BY2FFO11FD025.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 10:24 AM, Andreas F?rber wrote:
> Am 25.07.2014 10:02, schrieb Michal Simek:
>> On 07/25/2014 01:28 AM, S?ren Brinkmann wrote:
>>> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>>  v2: New
>>>>  
>>>>  arch/arm/boot/dts/zynq-7000.dtsi      | 17 +++++++++++++++++
>>>>  arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
>>>>  2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> index eed3df0..1a70277 100644
>>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> @@ -223,6 +223,23 @@
>>>>  			};
>>>>  		};
>>>>  
>>>> +		dmac_s: dmac at f8003000 {
>>>> +			compatible = "arm,pl330", "arm,primecell";
>>>> +			reg = <0xf8003000 0x1000>;
>>>> +			status = "disabled";
>>> I think for this IP we can omit the 'status' property since it is always
>>> enabled. I don't see a reason to override it in each board DT.
>>
>> Done this change myself
> 
> Fine with me, but allow me to point out that the TRM documents the DMAC
> being mapped as DMAC S at the above address, and as DMAC NS at F800_4000
> (secure vs. non-secure, ch. 4.6, p. 116). Not sure how this would be
> handled driver-wise if not through alternative dt nodes?

Kernel on zynq runs in secure world. All the sw on zynq from beginning runs in secure world.
I haven't had any time to look at switching kernel to NS.
That's why having dmac in this dts as default configuration in secure world
is fine.

It is not about how driver will handle - driver shouldn't care.
It is how users will handle that kernel runs in non secure
and how to change DTS to reflect this.
Bootloader can do this change for example. Or if there is an option
to detect at run time by kernel that we are in NS than kernel itself can
patch dmac node and use different address.
Definitely bootloader or setup correct address by user is preferred way.

Thanks,
Michal


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/ab55f6cc/attachment.sig>
