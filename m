From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 6 Jul 2017 13:41:38 +0100
Subject: [PATCH] arm64: dts: marvell: mcbin: Enable PCIe interface
In-Reply-To: <87r2xtepfq.fsf@free-electrons.com>
References: <20170705161333.9315-1-gregory.clement@free-electrons.com>
 <20170705171607.GG4902@n2100.armlinux.org.uk>
 <CAKv+Gu9DXFDDdx3Vrmo20cRtMcbS-MUa4MF5r-Odje68FinGOw@mail.gmail.com>
 <20170705174403.GH4902@n2100.armlinux.org.uk>
 <20170706143151.26e485fa@xhacker>
 <CAKv+Gu-uU7SqcDZdoBfcJHjNMYYVtoH_QfQa7sffcLLOY=iQHQ@mail.gmail.com>
 <87r2xtepfq.fsf@free-electrons.com>
Message-ID: <CAKv+Gu-MRXXEvDHuWfbRJ=if6sGGOScTCe8a97CCRp97O15RkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 July 2017 at 13:10, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Ard,
>
>  On jeu., juil. 06 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 6 July 2017 at 07:31, Jisheng Zhang <jszhang@marvell.com> wrote:
>>> On Wed, 5 Jul 2017 18:44:03 +0100 Russell King - ARM Linux wrote:
>>>
>>>> On Wed, Jul 05, 2017 at 06:36:53PM +0100, Ard Biesheuvel wrote:
>>>> > On 5 July 2017 at 18:16, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>>>> > > On Wed, Jul 05, 2017 at 06:13:33PM +0200, Gregory CLEMENT wrote:
>>>> > >> Enable the PCIe interface on the MACCHIATOBin board. It is located on
>>>> > >> CON12 and is 4 lanes capable.
>>>> > >>
>>>> > >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>> > >
>>>> > > Why do you folk at free-electrons like doing half a job all the friggin
>>>> > > time?
>>>> > >
>>>> > > You know I have complete patches for mcbin, but you pointedly won't look
>>>> > > at them at all - except when you have a problem and want to test my tree.
>>>> > > And even then, you ignore my work (despite testing that it works), and
>>>> > > you still recreate my patches.
>>>> > >
>>>> > > This is really frustrating and insane behaviour on your part.
>>>> > >
>>>> > > Here's what I have:
>>>> > >
>>>> > > +&cpm_pcie0 {
>>>> > > +       pinctrl-names = "default";
>>>> > > +       pinctrl-0 = <&cpm_pcie_pins>;
>>>> > > +       num-lanes = <4>;
>>>> > > +       reset-gpio = <&cpm_gpio1 20 GPIO_ACTIVE_LOW>;
>>>> > > +       status = "okay";
>>>> >
>>>> > This needs 'num-viewport = <8>' as well, or the crazy Synopsys DWC
>>>
>>> IMHO, maybe putting this property into dtsi is better.
>>>
>>
>> Good point. Do all instances of this IP that live on the SoC have 8
>> viewports?
>
> In the Armada 80x0 datasheet there is no mention of viewport. However 2
> days ago you said that "What I do know is that boards like the Marvell
> 8040 based MacchiatoBin uses this IP in RC mode, and exposes config,
> MMIO and IO space windows using only 2 viewports. Note that this is
> essentially a bug in the DT description, given that its version of the
> IP supports 8 viewports."[1]
>
> So you seem to know that the version of the IP used support the 8
> viewports!
>
> What I can also say is that the in the datasheet there is no mention of
> difference between the instance. The only thing that can differ is the
> number of lane for each PCIe Port.
>

I am sure I found it in the datasheet somewhere. It is the number of
ATU windows.

In any case, I implemented ACPI firmware for the MacchiatoBin, which
also involves programming the PCIe RC in a mode that is compatible
with ECAM. This turns out to be impossible (which means you cannot
implement a SBSA compatible platform with this SoC), but in attempting
to do so, I used five different windows, for type 0 config cycles,
type 1 config cycles, IO space, MMIO32 space and MMIO64 space (which
the Synopsys DW PCIe controller does not even implement,
unfortunately)

Note that this also involved reprogramming all the memory translation
windows from the secure firmware, to free up the region 0xc000_0000 -
0xefff_ffff for use by PCIe (config and MMIO32 space), and assigning a
window 0x8_0000_0000 - 0x8_ffff_ffff for 64-bit MMIO BARs.
