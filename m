From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 31 Oct 2013 15:11:46 -0500
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <20131031160901.GD16735@n2100.arm.linux.org.uk>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
 <20131031080326.GK24559@pengutronix.de>
 <20131031102908.GX16735@n2100.arm.linux.org.uk>
 <CAHCPf3vTcu9RCk8=9MUs4nkyJ-8jevh5koxfzdLzE5+qM0ZspQ@mail.gmail.com>
 <20131031160901.GD16735@n2100.arm.linux.org.uk>
Message-ID: <CAHCPf3vEs60zUUsGuY4sV-SW2ZWM+EzBLGBwNQbmWrBiK4597w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 11:09 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 31, 2013 at 10:45:08AM -0500, Matt Sealey wrote:
>> I suggested this to Shawn a couple weeks ago and got a bit of pushback.
>>
>> There's probably a ton more to do in this regard to keep the DT
>> per-board more concise, but this drops tree size by a respectable
>> amount on i.MX51 too (just on a tree I have internally, it's something
>> like 8.5KiB) and I can't see any redundant data in the ones he
>> patched.
>
> The issue I have is that this pushes support for Carrier-1 through to
> _six_ months before it appears in a mainline -final kernel - the timeline
> ends up looking like this:
>
> - Prepare and merge this patch to allow DAT3 to be configured in the
>   merge window starting next week.
> - Rebase Carrier-1 changes on that when it hits mainline
> - Wait for 3.13-rc1
> - Get Carrier-1 DT files merged into the IMX tree for the following
>   merge window at some point
> - Wait for v3.13 to be released about three months from now.
> - Carrier-1 support gets merged into mainline
> - Carrier-1 support appears in v3.14 three months after that.
>
> That's an awfully long turn-around time given that the DT description
> is functional today, and has been for the last month, and the only
> thing that's really blocking it is the problems of that DAT3 signal.

The DT description isn't changing at all - what comes out is going to
work either way. I don't understand Shawn's rejection of adding
another pinctrl definition for your board, as what the kernel parses
at the end of the day will be almost identical.

It's a weird issue, but there are two big things that bloat device
trees right now.

~

Problem #1: since "common" pinctrl definitions got moved into the
.dtsi files, every board including that .dtsi file gets every pinctrl
definition for every other board, whether they use the component that
it's for or not. Each .dts for each board would just refer to the
phandle for the definition in the .dtsi file, which made the .dts
files shorter.

That means for i.MX6 which has

* 4 SDHC
* 5 UART
* 5 eCSPI controllers

Most boards use at most a couple of those. For example on SabreSD:

* 3x SDHC (there are two SD card slots an an eMMC)
* 1x SPI
* 1x UART.

Common pinctrls are present for at all 4 SDHC, 4 of the UART (nobody
uses one of them), and a couple SPI controllers. That means SabreSD
contained pinctrl definitions for 1 extra SD card, 3 extra UARTs, and
2 or 3 SPI controllers. Less source code meant bigger binaries.

You can go see it today; make imx6q-sabresd.dtb and then "dtc -I dtb
-O dts imx6q-sabresd.dtb | less" and search for pinctrl nodes. There
are far, far too many for the SabreSD board.

So that's problem #1 which this patching is solving. Now, when you
build imx6q-sabresd.dtb you will only have pinctrl for the buses and
IO it actually uses, and in this case, that's a good few KiB of data
that was just redundant.. now gone away.

~

Problem #2: every node with status = "disabled" is bundled into the
device tree. This means for SabreSD even though now only the relevant
pinctrl nodes are present per-board, it still has nodes for 1 extra SD
card, 4 extra UARTs and 4 SPI controllers that aren't even muxed out,
and Linux ignores them anyway. This soaks up another goodly few KiB.

~

In total for Problem #1 and Problem #2 still existing, this is the
difference between a 46KiB device tree and a 25KiB device tree blob.
What HASN'T changed is how this all compiles down; it's in the .dts
file and not the .dtsi file, and the dts file uses some macros to make
life easier. This leads to slightly more device tree source code, but
a much smaller binary.  So you can just add:

&usdhc3 {
   pinctrl-names = "default";
   pinctrl-0 = <&russellsdcard>;
};

&iomuxc {
   usdhc3 {
      russellsdcard: russellgrp {
         fsl,pins = <MX6QDL_PAD1_FUNC 0x82828
                          MX6QDL_PAD2_FUNC 0x82828>;
      };
   };
};


What you'll be able to do later is:

&iomuxc {
  usdhc3 {
   russellsdcard: russellgrp {
        fsl,pins = <MX6QDL_WHATEVER_DEV_FUNC_VARIANT>;
   };
   };
};

And if Shawn doesn't like it, Shawn can go fish, because you're both
just being stubborn for different reasons :)

The important thing to note is that the label (russellsdcard) is
totally internal to the device tree compiler, it gets resolved to be a
phandle eventually pointing to the node containing fsl,pins. The
container node name (russellgrp) is also totally irrelevant here, and
the container node above it (usdhc3) is completely redundant except to
make the source (both in 'source' form and in 'disassembled' form)
look pretty.

As long as your binary comes out the same and it parses the same
things out, there's no waiting necessary because there's no ABI change
at all. It may cause a tiny bit of churn later to basically reduce the
amount of code (moving it from your file to pingrp.h) - is that what
you're waiting on?

I'd say screw it and just get the board support in there. Code
cleanups are a fact of life. This'd be like waiting 2 kernels for a
whitespace change.

Thanks,
Matt Sealey <neko@bakuhatsu.net>
