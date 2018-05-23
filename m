From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 23 May 2018 08:55:20 +0300
Subject: [RFC 12/13] ARM: dts: ti: add dra71-evm FIT description file
In-Reply-To: <20180522200100.GA23937@rob-hp-laptop>
References: <1523956215-28154-1-git-send-email-t-kristo@ti.com>
 <1523956215-28154-13-git-send-email-t-kristo@ti.com>
 <20180417092924.GB20335@flint.armlinux.org.uk>
 <ad5ef67d-d566-0034-a7cd-09a549cbd6d7@ti.com>
 <20180417144913.GD5669@atomide.com>
 <43ff3894-a287-1558-687c-40f50712735c@ti.com>
 <20180522200100.GA23937@rob-hp-laptop>
Message-ID: <243730d3-e7f3-584d-b5dd-491c2700cf11@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/18 23:01, Rob Herring wrote:
> On Mon, May 21, 2018 at 09:57:54AM +0300, Tero Kristo wrote:
>> On 17/04/18 17:49, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [180417 09:36]:
>>>> In typical setup, you can boot a large number of different configs via:
>>>>
>>>> bootm 0x82000000#dra71-evm#nand#lcd-auo-g101evn01.0
>>>>
>>>> ... assuming the configs were named like that, and assuming they would be
>>>> compatible with each other. The am57xx-evm example provided is better, as
>>>> you can chain the different cameras to the available evm configs.
>>>
>>> Why not just do it in the bootloader to put together the dtb?
>>>
>>> Then for external devices, you could just pass info on the
>>> kernel cmdline with lcd=foo camera=bar if they cannot be
>>> detected over I2C.
>>
>> (Added Linux ARM list to CC, this was not part of the original delivery.)
>>
>> Ok trying to resurrect this thread a bit. Is there any kind of consensus how
>> things like this should be handled? Should we add the DT overlay files to
>> kernel tree or not?
> 
> IMO, yes.
> 
>> Should we add any kind of build infra to kernel tree, and at what level
>> would this be? Just DT overlay file building support, and drop the FIT build
>> support as was proposed in this RFC series or...?
> 
> I think I mentioned this already, but I expect that this is going to
> cause a number of conversions of dtsi + dtsi -> dtb into base dts and
> overlay(s) dts files. In doing so, we still need to be able to build the
> original, full dtb.

So you mean like breaking apart the existing .dts files? Are there any 
plans to get that done (I know the android folks talk about this but I 
don't like their idea.) If we do the split, how are we going to 
determine which dts + overlay files are required to get a specific DTB 
done? I actually wrote a tool for this purpose which parses the FIT 
image configurations and generates plain dtb files out of the info there 
if needed, but assuming FIT is abandoned then what...?

> 
>> U-boot can obviously parse the base DTB + overlay DTB:s into a single DTB,
>> but this is somewhat clumsy approach and is relatively error prone to get it
>> right.
> 
> Why? How is the kernel better?

I am mostly speaking about runtime applying of the overlays. If done 
build time, it is obviously on same level. If you apply the base DTS + 
overlays from u-boot prompt, it is not too much fun, and if there are 
any failures it just won't work, but don't really tell you why not.

> 
>> Building the FIT image post kernel build would also be possible, but who
>> would be doing this, is there any need to get this done in generic manner or
>> shall we just add SoC vendor specific tools for this?
> 
> I'll tell you up front, I'm not a fan of FIT image (nor uImage,
> Android boot image, $bootloader image). If you want a collection of
> files and some configuration data, use a filesystem and a text file.

Ok, thanks for your frank comments. I believe based on this feedback 
I'll try to modify this series into bare minimal overlay support to 
kernel, and have the post processing done elsewhere (either u-boot build 
or possibly completely separate tool.)

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
