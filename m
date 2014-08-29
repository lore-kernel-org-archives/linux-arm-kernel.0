From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 29 Aug 2014 16:08:20 +0200
Subject: [PATCH 3/3] ARM: zynq: DT: Add Ethernet phys
In-Reply-To: <53FB9AC4.8010704@gmail.com>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408550219-19825-3-git-send-email-soren.brinkmann@xilinx.com>
 <5a7b6f57-b6c0-4fb3-af0d-d403277c0207@BN1AFFO11FD045.protection.gbl>
 <53F5D8D9.7040604@suse.de>
 <f166a186-301c-4288-97cf-71f8173c07e7@BN1AFFO11FD010.protection.gbl>
 <CAGVrzcYWN83tznwvw1M9V_mwWgobs2kwtRvEj4stqE=XGC10fg@mail.gmail.com>
 <20140825174610.GA13737@obsidianresearch.com> <53FB9AC4.8010704@gmail.com>
Message-ID: <660fe929-1f16-4e22-8bd3-0388cd363978@BY2FFO11FD038.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2014 10:21 PM, Florian Fainelli wrote:
> On 08/25/2014 10:46 AM, Jason Gunthorpe wrote:
>> On Fri, Aug 22, 2014 at 01:47:09PM -0700, Florian Fainelli wrote:
>>
>>>>  - the ID based strings seem to be not needed since, IIUC, the core
>>>>    reads the ID from the PHY and uses it, so I just left it out not
>>>>    trying to figure out how to obtain the correct ID
>>>
>>> It is not needed, but it is one way to specify a PHY device if you do
>>> not know what compatible string to use instead.
>>
>> No, it is a way to specify a PHY device if the kernel can't auto probe
>> the Phy ID.
>>
>> Last I checked, the kernel doesn't support plain text compatible
>> strings for phys - everything is driven on the phy id, either auto
>> probed or specified in the DT.
> 
> That's right. Some PHY drivers might be relying on specific compatible
> strings though, but not the core PHY library that probes and maps a
> driver to a PHY node.
> 
>>
>>>>  - the marvell compatible strings are used in our vendor tree. They
>>>>    aren't used anywhere but in our vendor tree. I though keeping them is
>>>>    nice since it identifies the PHY fully. And in case that level of
>>>>    detail is needed at some point it is already there.
>>>
>>> And this is the recommended way to do it in case we ever need to key a
>>> software decision based on the hardware.
>>
>> All compatible strings need to be documented.
>>
>> .. and they need to encode more information than you get from the phy
>> id - die revsision, package option, functional options, voltage
>> codes. Etc.
>>
>> .. and they actually need to be *right*
> 
> Agreed.
> 
>>
>> An example: The kernel reports 88E1318S for all four chips in that
>> family, AFAIK you have to read the package marking to figure out which
>> you have (it is the same die, with options switched on/off at
>> packaging time). People have already posted patches trying to
>> helpfully add a 'marvell,88E1318S' compatible string based on kernel
>> output. Except it is wrong, it isn't actually the '8S version in the
>> HW.
>>
>> Even worse, Marvell has a whole series of socket compatible phys. Just
>> because the board the DT author looked at has a '318, doesn't mean
>> that every board ever made will. We've actually already been switching
>> between the 318 and 318S for production depending on which has part
>> availability.
>>
>> Basically: don't try to override self-discoverable hardware in DT
>> without a really good reason.
> 
> I think that's a very good point, at the very least let's use a
> compatible string that contains the full 32-bits PHY OUI.

I think resolution is:
1. Do not use marvell,88e1518 because it is not listed anywhere
2. Do not add ethernet-phy-idAAAA.BBBB because it breaks autodetection
if there is different phy on the board and we shouldn't restrict us in this.
In spite of autodetection takes some time.
3. "ethernet-phy-ieee802.3-c22" is optional that's why doesn't need to be added
4. Any listed compatible string has to be parsed which takes time

That's why I think make sense not to use any compatible string.
This should give us all flexibility which we want to have.

Thanks,
Michal


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/9f6b9847/attachment-0001.sig>
