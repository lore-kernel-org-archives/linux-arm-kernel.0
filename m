From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Feb 2017 17:17:32 +0100
Subject: [PATCH v3 5/6] ARM: mvebu: Add driver for mv98dx3236-soc-id
In-Reply-To: <be262173372a46be97f635e8ce9e36af@svr-chch-ex1.atlnz.lc>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
 <20170216085041.28337-6-chris.packham@alliedtelesis.co.nz>
 <28604982.PnlvXC13kC@wuerfel>
 <be262173372a46be97f635e8ce9e36af@svr-chch-ex1.atlnz.lc>
Message-ID: <CAK8P3a0Zyii5QbGAtR0TCEsUnGwkH1G5+_bPku4VYPKM-aTS8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 5:22 AM, Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> Hi Arnd,
> On 17/02/17 02:28, Arnd Bergmann wrote:
>> On Thursday, February 16, 2017 9:50:39 PM CET Chris Packham wrote:
>>> The DFX server on the 98dx3236 and compatible SoCs has an ID register
>>> that provides revision information that the PCI based ID register
>>> doesn't have. Use this if it's available.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>
>>
>> How about putting this new code into a separate driver in
>> drivers/soc/? I don't think you need the early probing we have
>> here, and not that much is shared otherwise.
>>
>
> Not putting it there means we'll get the pci fall-back behaviour which
> will result in a incorrect rev value. Having said that no callers of
> mvebu_get_soc_id() currently care about these specific SoCs so not
> having the right rev is not an issue at the moment.

We should still care about incorrect IDs as they are shown to user space,
which could start relying on it in theory.

However, the PCI ID should only be used on chips that have a PCI
host with an ID known to be correct, so maybe we can restrict
get_soc_id_by_pci() in a way that the mvebu_pcie_of_match_table
matching does not trigger on chips on which we don't want it to.

     Arnd
