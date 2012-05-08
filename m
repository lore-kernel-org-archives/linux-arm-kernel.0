From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 08 May 2012 14:59:52 +0100
Subject: Development tree for Cortex-A15?
In-Reply-To: <1336485257.47575.YahooMailNeo@web132502.mail.ird.yahoo.com>
References: <1336046199.46241.YahooMailNeo@web132501.mail.ird.yahoo.com>
 <bc6e93f98278125c354282f23751b1aa@localhost>
 <1336052155.37772.YahooMailNeo@web132504.mail.ird.yahoo.com>
 <6e4ad6defa33bf693ec45cae819469f0@localhost>
 <1336121047.79153.YahooMailNeo@web132504.mail.ird.yahoo.com>
 <e8545d06e2a63b7b2badc24d8bc1531f@localhost>
 <1336134008.88695.YahooMailNeo@web132504.mail.ird.yahoo.com>
 <4f7e5540dd597d8e48fb81a5e1e26313@localhost>
 <1336472016.29885.YahooMailNeo@web132503.mail.ird.yahoo.com>
 <4FA8FADF.2070701@arm.com>
 <1336485257.47575.YahooMailNeo@web132502.mail.ird.yahoo.com>
Message-ID: <4FA926D8.2050200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/12 14:54, Jemma Jones wrote:
>> Subject: Re: Development tree for Cortex-A15?
> 
>>
>> On 08/05/12 11:13, Jemma Jones wrote:
>>>>  Subject: Re: Development tree for Cortex-A15?
>>>>>   Any chance you can send me a .config file that works on the kernel 
>> in
>>>>  this
>>>>>   branch which runs on your A15x1 FastModel?
>>>>
>>>>  Coming in a private email.
>>>
>>>  I didn't seem to get anything?
>>
>> As far as I'm concerned, it was delivered:
>>
>> 2012-05-05 13:09:33 1SQcrl-0006uI-OX <= maz@misterjones.org U=www-data 
>> P=local S=59827 id=7da4dd4bd4f768d907094ce4919bfffe at localhost
>> 2012-05-05 13:09:34 1SQcrl-0006uI-OX => jemmajones81 at yahoo.co.uk R=dnslookup 
>> T=remote_smtp H=mx-eu.mail.am0.yahoodns.net [77.238.184.241]
>> 2012-05-05 13:09:34 1SQcrl-0006uI-OX Completed
>>
>> I'll resend it again, but you may want to check your spam folder.
>>
>>>>>   I'm using the boot-wrapper from
>>>>>   
>> http://git.linaro.org/gitweb?p=arm/models/boot-wrapper.git;a=summary in
>>>>>   semi hosting mode.
>>>>>
>>>>>   I managed to boot Android from that but I don't seem to be 
>> able to boot
>>>>>   your kernel. It just stops after the boot-wrapper says loading 
>> uImage.
>>>>
>>>>  Which dts file are you using?
>>>
>>>  I don't quite understand yet how the DT stuff is used. When I build the 
>> DTB files then I get vexpress-v2p-ca15-tc1.dtb in my arch/arm/boot directory. I 
>> assume that one is used then for my kernel image?
>>>
>>>  My .config has all the DT stuff enabled I think:
>>>  CONFIG_ARCH_VEXPRESS_DT=y
>>>  CONFIG_ARM_APPENDED_DTB=y
>>>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>>>
>>>  Or is that not correct?
>>
>> First, you want to forget about anything TC1 related, it isn't what you need 
>> for the Fast Model.
>>
>> Step by step instructions:
>> - Grab Pawe?'s DTS tree: git://linux-arm.org/arm-dts.git
>> - Build your zImage
>> - From your kernel tree, run:
>>   ./script/dtc/dtc -O dtb -o rtsm_ve-cortex_a15x2.dtb 
>> wherever_your_arm-dts_tree_is/fast_models/rtsm_ve-cortex_a15x2.dts
>> - cat rtsm_ve-cortex_a15x2.dtb >>arch/arm/boot/zImage
>> - Build your uImage if that's what you're using.
>> - Build your boot-wrapper as usual.
>>
>> That should get you going.
>>
>>>  I have now updated to you latest kvm-arm-3.4 branch.
>>
>> That's very brave of you... ;-)
>>
>>>  But the kernel still does not boot up properly, or at least I don't 
>> seem to get any output. It just goes "Uncompressing Linux... done." 
>> and then does nothing.
>>>  I'm using the FastModel Cortex-A15x2 simulation.
>>
>> Let me know if it gets better with the above. Or not.
>>
> 
> It seems as if the CLCD driver is not yet working in this configuration? It does not load for me, because the clcdfb_probe() function fails with board = dev->dev.platform_data being NULL. Is the platform initialization not setting this?

No. There is no binding for CLCD, and I've refrained from adding more
hacks to my tree. If you want to tackle the task of writing a CLCD
binding and porting the driver to DT, be my guest! :)

	M.
-- 
Jazz is not dead. It just smells funny...
