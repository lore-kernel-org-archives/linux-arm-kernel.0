From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 24 Oct 2013 15:11:42 -0500
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <addbb1933c62983e0114eeda7ce51342.squirrel@twosheds.infradead.org>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <1382616801.6040.26.camel@sakura.staff.proxad.net>
 <3726fd81259f84ef308ba9011ae35174.squirrel@twosheds.infradead.org>
 <1382619952.6040.57.camel@sakura.staff.proxad.net>
 <addbb1933c62983e0114eeda7ce51342.squirrel@twosheds.infradead.org>
Message-ID: <CAHCPf3vtM4u6T3tnHa-UgV=WE_sJkojEpoLBpdpSdJ48NEbqQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 8:14 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>
>>
>> On Thu, 2013-10-24 at 12:22 +0000, David Woodhouse wrote:
>>
>>> If you are correct to insist that DMA needs yo be supported in the new
>>> driver *even* with old firmware, then yes, maybe.
>>
>> if DMA gives a performance boost for all workloads, what is the argument
>> for not always enabling it ?
>
> If DMA gives a performance boost for all workloads, what bloody idiot
> defined or reviewed a DT binding that didn't include the information which
> is required to uae DMA? :)

Two cases;

1) Where nobody documented that DMA was possible - if it is via an
external DMA controller with a configurable event number, then it is
not part of the binding for that IP block anyway except to optionally
specify what the dma controller in use is (phandle) and the event
number (irq, dma-channels, whatever)

2 a) Where there was not any driver for DMA so nobody even knew it
worked, but could only trust the documentation.

2 b) Where there are errata in older hardware which stopped it working
and consensus was that it shouldn't be defined until it works, and
then new hardware made it work

Either way, your fix is the correct one. If an interrupt or dma
channel for a device is totally fixed per SoC and that device is ONLY
used on that SoC, you can add a fixup in the driver to deal with older
bindings. This may be seen as a "huge leap backwards" but it is the
only way to do it and that is a fact of life.

This is the way the original Efika PPC was designed; Genesi/bplan did
not put a lot of properties (including interrupt numbers and DMA
functionality) in the tree because they were already used in pre-OF
drivers and the mappings were ostensibly fixed and in the manual. As
long as those drivers knew the values already, why describe them again
and have to write hundreds of lines of code to override a static value
with a dynamic DT-derived one?

Once it hits another SoC (i.e. number of users of the driver is >1)
then the property has to be required for the SECOND SoC unless it's
exactly the same mapping. Then you can mandate the property defining
the new values on newer hardware (with a particular compatible
property that differentiates it) for the purposes of future proofing
the driver, but on older hardware it can know what the real value is.
In the case where it's EXACTLY the same, the property stays optional
because drivers would always, as per older binding, know how to deal
with it.

Then came this edict that *absolutely everything* needed to be defined
in DT, even though there were no other platforms (and still aren't)
using those peripherals, and stuff like this got written:

http://www.powerdeveloper.org/platforms/efika/devicetree

Which I am quite proud of writing. And executing this script before
loading the OS meant Linux kept working - at least during 2008 - and
it is up to the user or distro to put that script in place when the OS
requires it. What is infuriating is the reluctance for the
distributions to mandate being able to script device tree changes when
they also want to mandate scriptable boot.. it seems like a lot of "we
don't want to, shove it on the vendors' back instead." All that is
going to do is piss off board designers and their software engineering
teams..

>> I don't understand why having the soc-foo.h with the internal interrupt
>> mapping in the kernel tree is a no-no, whereas it's ok to add the
>> missing part of it in the form of fixups or directly in driver code.
>
> It's the difference between doing it as a matter of course, and doing it
> only in the very rare "OMG we fucked up but we really *need* to fix it up
> this time" case.

Right. It doesn't need to be in a header or source just because it
exists - it needs to be there as, and ONLY as, it is used.

Most values are taken from the manuals anyway, so if they exist, they
exist in the manual even if they are unused in the OS.

If it really was as strict a process as some people would like it, the
i.MX NFC NAND driver and a couple others, none of the i.MX pinctrl
bindings currently existing or the very concept of defining clock
providers (&clocknode XY where XY is an arbitrary enum inside the OS)
would NEVER have hit. I absolutely loathe all 3 of these since they
make it very very difficult for everyone involved in bringing up OS
support on a new board, hardcoded values here and there but DT
properties elsewhere..constant cross-referencing of bindings and
headers and source code and Linux abstractions vs. manuals and host
controller specs. Some of that is a fact of life.. a lot of it is
definitely imposed by stupid design.

-- 
Matt Sealey <neko@bakuhatsu.net>
