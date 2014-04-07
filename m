From: matthew_minter@xyratex.com (Matthew Minter)
Date: Mon, 7 Apr 2014 14:03:55 +0100
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <20140403202455.599d1c6b@skate>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
 <20140401164110.GA26093@obsidianresearch.com>
 <CAFJTrDu1=Hoa6NS3DaFphMUXgJYunybbdCoGiBVe1qKNQ4s3MA@mail.gmail.com>
 <20140403182322.GA9509@obsidianresearch.com>
 <20140403202455.599d1c6b@skate>
Message-ID: <CAFJTrDuQv87t4N1pbw_mCZ=pZ82pX6cab+PmuhO1Fvvax==xdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

This is not a proper update yet, however as a test to confirm if the
issue is indeed relating to the address mapping, I modified the ahci
code to use a hard coded ioremap to the correct address range
0xe0200000-0xe0201fff. This did not affect the error in any way and I
still have the same problem. Thus I can conclude that the ahci driver
pointing to the wrong address does not seem to be the problem. However
I am somewhat stumped on where to look next. I am going to read over
the PLX datasheet in case there is a known issue with my
configuration. Again, I will post if I have any more information. I
will also see if I can try jtaging the chip so I can check the state
of the PCI bus and mmu at the time of failure.

Many thanks,
Matt

On 3 April 2014 19:24, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Jason Gunthorpe,
>
> On Thu, 3 Apr 2014 12:23:22 -0600, Jason Gunthorpe wrote:
>
>> Your oops seem to suggest that the very first MMIO read from the AHCI
>> is causing this:
>>
>> > [  191.654496] Unhandled fault: external abort on non-linefetch
>> > (0x1008) at 0xf0460004
>>
>> And the address 0xf0460004 is certainly funny - that doesn't look like
>> it is valid at all, but prehaps it is a bogus report (?)
>
> Notice that the address reported by the Unhandled fault message is a
> *virtual* address, not a *physical* address. So you have to look to
> what physical address it corresponds to draw some conclusions, I
> believe.
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
