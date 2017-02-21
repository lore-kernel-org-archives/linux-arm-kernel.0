From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue, 21 Feb 2017 04:16:39 +0000
Subject: [PATCH v3 5/6] ARM: mvebu: Add driver for mv98dx3236-soc-id
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
 <20170216085041.28337-6-chris.packham@alliedtelesis.co.nz>
 <28604982.PnlvXC13kC@wuerfel>
 <be262173372a46be97f635e8ce9e36af@svr-chch-ex1.atlnz.lc>
 <CAK8P3a0Zyii5QbGAtR0TCEsUnGwkH1G5+_bPku4VYPKM-aTS8g@mail.gmail.com>
Message-ID: <e8aa98ec22214e77ae4b060dccec8a78@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/17 05:17, Arnd Bergmann wrote:
> On Fri, Feb 17, 2017 at 5:22 AM, Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
>> Hi Arnd,
>> On 17/02/17 02:28, Arnd Bergmann wrote:
>>> On Thursday, February 16, 2017 9:50:39 PM CET Chris Packham wrote:
>>>> The DFX server on the 98dx3236 and compatible SoCs has an ID register
>>>> that provides revision information that the PCI based ID register
>>>> doesn't have. Use this if it's available.
>>>>
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>>
>>>
>>> How about putting this new code into a separate driver in
>>> drivers/soc/? I don't think you need the early probing we have
>>> here, and not that much is shared otherwise.
>>>
>>
>> Not putting it there means we'll get the pci fall-back behaviour which
>> will result in a incorrect rev value. Having said that no callers of
>> mvebu_get_soc_id() currently care about these specific SoCs so not
>> having the right rev is not an issue at the moment.
>
> We should still care about incorrect IDs as they are shown to user space,
> which could start relying on it in theory.
>
> However, the PCI ID should only be used on chips that have a PCI
> host with an ID known to be correct, so maybe we can restrict
> get_soc_id_by_pci() in a way that the mvebu_pcie_of_match_table
> matching does not trigger on chips on which we don't want it to.
>

I think we'd need to add some kind of soc-id-from-pci node to indicate 
devices where the best ID is from the PCI registers. We'd also need to 
worry about backwards compatibility etc.

For now since nothing is relying on the rev and the SoC ID is correct 
coming from the PCI registers I'm happy to sit on this patch until a 
need to get the rev arises.
