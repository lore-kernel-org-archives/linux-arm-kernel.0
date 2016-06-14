From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jun 2016 11:49:42 +0100
Subject: ARM physical memory map recommendation? (was RE: [RFC] arm64:
 defconfig: enable 48-bit VA by default)
In-Reply-To: <CAKv+Gu-Ra0sAbx1mmuN9o2LZ3Ccs7TsBRm7WyV8SxU6Y3fsEUA@mail.gmail.com>
References: <HE1PR04MB16416EEC1B49328C2C6F43FB8D500@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <CAKv+Gu9-p9_B-KbQ0Kh3VOrDXGj-5eHur-aEpostzu1L2Hgugw@mail.gmail.com>
 <HE1PR04MB1641BF6DC3931FEBEF9716998D530@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <CAKv+Gu-Ra0sAbx1mmuN9o2LZ3Ccs7TsBRm7WyV8SxU6Y3fsEUA@mail.gmail.com>
Message-ID: <20160614104942.GA14654@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 10:51:57AM +0200, Ard Biesheuvel wrote:
> On 13 June 2016 at 20:41, Stuart Yoder <stuart.yoder@nxp.com> wrote:
> > I guess how definitive someone might read it is open to interpretation
> > but our hardware guys intepreted it as the "ARM recommendation".
> > There are lot's of "must" statements in there, so its easy for me to
> > see how it can be intepreted to be fairly definitive.  It doesn't
> > say a 64GB DRAM part _could_ be sub-divided like...  It says "For example
> > a 64GB DRAM part _will_ be sub-divided into three regions."
> 
> Whether or not you interpret the tone as normative is only one side of
> it. The reason I quoted the paragraph above is to emphasize that the
> definition of an 'ARM system' is not clear either, i.e., whether it
> means 'any system that implements the ARM architecture' or simply 'a
> system created by ARM Ltd.'. The fact that the paragraph mentions
> software models and FPGA implementations leans to the latter IMO.

This document describes the reasoning behind the memory map decision of
the ARM Ltd SoC/FPGA/model implementations (and I'm not aware of any
with more than 32GB of RAM) with proposed extensions for higher range
address space. It could be used as a guideline by SoC vendors but it's
not something mandated (and it also allows for flexibility, see below).

> > In any case, we are not going to follow that document as definitive.
> > But, my question is whether there are any updated ARM recommendations?
> 
> That again suggests that the document in question is intended as a
> general recommendation, which I believe may not be the case. So if we
> could get some clarification on that as well from any of the ARM Ltd.
> cc'ees, that would be great.

I started a discussion within ARM about a year ago but we didn't reach
a clear conclusion on whether/how this document should be updated. It
was written in a way to cope with both hardware requirements (chip
select) and potential 32-bit software/peripheral needs.

If you are targeting a server platform, I strongly recommend SBSA which,
in 4.1.3, states: "This specification does not mandate a standard memory
map. It is expected that the system memory map is described to system
software by system firmware data". There are further clarifications on
the 64K granule size but that's about it.

Now, this "Principles of ARM memory maps" document could still be used
as a broad guideline as it allows some flexibility based on what
software you target. At the time it was written and still valid
currently, 32-bit software and 32-bit peripherals support is required in
certain configurations (e.g. mobile). I'm not talking about a high level
OS like Linux here but secure firmware already verified/certified that
cannot be easily changed. Such software runs at secure EL1 and, at least
for enabling the MMU, needs to run in a 32-bit physical address space
(hence the low DRAM alias). As for 32-bit peripherals, if present, they
may be behind an SMMU but it depends on whether the secure firmware is
able to configure it (and the feedback I got so far was "no"). That's
additional work which your partners may not be prepared to do.

If you don't have such 32-bit firmware requirements and any 32-bit
peripherals can always be routed via an SMMU, the memory maps
recommendations can be followed *without* the low aliases. For example,
4.3 "40-bit Memory Map" allows up to 512GB RAM at 512G phys addr
(usually chip select requirements) with the range between phys address
512G to 544G being optionally "hole or DRAM". That's where you can
choose DRAM and avoid the low aliases (at 2GB and 32GB). This would fit
well with the hardware chip selects for DRAM and it won't create a
sparse memory range for Linux.

(BTW, arm64 defconfig now enables the 48-bit VA option)

-- 
Catalin
