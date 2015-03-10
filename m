From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 08:38:22 +0100
Subject: [PATCH 00/15] musb: Add support for the Allwinner sunxi musb
 controller
In-Reply-To: <CAGb2v67GkL9Mdr98Chf6MhMff7CO8OGgfF2kaB3Xcnz=SkMG3w@mail.gmail.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <2227491.z0aBeXi5ZG@wuerfel>
 <CAGb2v67GkL9Mdr98Chf6MhMff7CO8OGgfF2kaB3Xcnz=SkMG3w@mail.gmail.com>
Message-ID: <54FE9F6E.1030903@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10-03-15 02:46, Chen-Yu Tsai wrote:
> Hi Arnd,
>
> On Tue, Mar 10, 2015 at 5:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Monday 09 March 2015 21:40:13 Hans de Goede wrote:
>>> Hi All,
>>>
>>> This patch set has been a while in the making, so I'm very happy to present
>>> the end result here, and I hope everyone likes it.
>>
>> Awesome work!
>>
>>> Before talking about merging this there are 2 things which I would like to
>>> point out:
>>>
>>> a) The musb controller in the sunxi SoCs uses some SRAM which needs to be
>>> mapped to the musb controller by poking some bits in the SRAM controller,
>>> just like the EMAC patches which were send a while back I've chosen to use
>>> syscon for this, actually 2 of the patches in this set come directly from the
>>> SRAM mapping patchset for the EMAC.
>>>
>>> I know that Maxime is not 100% in favor of using syscon:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/320221.html
>>>
>>> But I disagree with his arguments for writing a special driver for the SRAM
>>> controller:
>>> 1) syscon was specifically designed for global system control registers like
>>> this and is fine to use as long as there are no conflicts where 1 bit is of
>>> interest to multiple drivers, and there is no such conflict here
>>> 2) Maxime's other arguments seem to boil down to it would be nice / prettier
>>> to have a specific driver for this, without really proving a hard need for
>>> such a driver. But writing such a driver is going to be a lot of work, and
>>> we've a ton of other work to do, and as said there is no real need for a
>>> separate driver, syscon works fine for this.
>>> 3) I actually believe that having a specific driver for this is a bad idea,
>>> because that means inventing a whole new cross driver API for this, and
>>> getting those right is, hard, a lot of work, and even then one is still likely
>>> to get it wrong. We can avoid all this by going with the proven syscon solution.
>>>
>>> Maxime, can we please have your ack for moving forward with this using syscon?
>>> (see above for my arguments why)
>>
>> I'd like to understand here why we can't use the existing SRAM DT binding
>> instead of the syscon binding.
>
> I believe you are talking about "mmio-sram"?
>
> The syscon here represents a switch, to toggle whether a block of SRAM is
> mapped into the CPU memory space, or to a specific devices private address
> space. It is not the actual SRAM.
>
> The SRAM DT binding is orthogonal to this, if not irrelevant when the block
> is mapped privately, as it is no longer visible from the DT's PoV.
>
> Coincidentally, on the A23 this is no longer needed. The SRAM for the FIFO
> is wholly owned by MUSB and not available to the CPU.

What ChenYu said :)

Regards,

Hans
