From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 27 Jul 2018 09:55:12 +1000
Subject: [PATCH 5/5] arm: dts: aspeed: Add power9 CFAM dtsi and use it
 on OpenPower P9 machines
In-Reply-To: <CAOesGMjAGb7T-89C3eYPf7zsPYSp=7CVx756PNngs73ue27Jhw@mail.gmail.com>
References: <20180724042406.15374-1-benh@kernel.crashing.org>
 <20180724042406.15374-6-benh@kernel.crashing.org>
 <CAOesGMjAGb7T-89C3eYPf7zsPYSp=7CVx756PNngs73ue27Jhw@mail.gmail.com>
Message-ID: <7b95c1781f954ad757382a635157eb151f975d52.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-26 at 21:50 +0200, Olof Johansson wrote:
> 
> > +++ b/arch/arm/boot/dts/ibm-power9-cfam.dtsi
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright 2018 IBM Corp
> > +
> > +#define __MAKE_LABEL(p,i)      p##i
> > +#define _MAKE_LABEL(p,i)       __MAKE_LABEL(p,i)
> > +#define HUB_LABEL              _MAKE_LABEL(fsi_hub,CFAM_CHIP_ID)
> > +#define I2C_LABEL(n)           _MAKE_LABEL(_MAKE_LABEL(cfam,CFAM_CHIP_ID),_i2c##n)
> 
> This is a red flag with respect to obscurity. It's a magic dtsi file
> that has to be included at the right spot in the dts file or things
> will break horribly -- we really try to avoid those kind of
> constructs.

I agree it sucks :-) I couldn't find any other way though. dtc seems to
be extremely limited in its ability to override node content. See
below.
 
> Also, you use it by passing in a predefined CHIP_ID, so you have
> #define / #include / #undef. And on top of that you have open-coded
> actual stable naming references to nodes that can't be found because
> they're created by macros.

Correct, as I said, I couldn't find a different way to do it.

> I know you want this to instantiate a bunch of boilerplate, so if you
> want to do that, maybe you'd be better off having this file just
> define a couple of macros, and then instantiate the actual subtrees
> with that macro (the macro can then take the chipid).

I'm not sure what you mean... the entire subtree being one giant macro
? That sounds scary ... I'll describe what I'm trying to do below.

>  That way you can
> still expose the same label-making macros in the locations where you
> setup the stable naming. Much less cognitive load on someone trying to
> read it and figure out just what's being instantiated where, and what
> nodes the i2c<#> aliases are referring to.

I'm sorry, I don't quite get what you suggest...
> 
> Also:
> 
> > +/ {
> > +       aliases {
> > +               i2c100 = &cfam0_i2c0;
> > +               i2c101 = &cfam0_i2c1;
> > +               i2c102 = &cfam0_i2c2;
> > +               i2c103 = &cfam0_i2c3;
> > +               i2c104 = &cfam0_i2c4;
> > +               i2c105 = &cfam0_i2c5;
> > +               i2c106 = &cfam0_i2c6;
> > +               i2c107 = &cfam0_i2c7;
> > +               i2c108 = &cfam0_i2c8;
> > +               i2c109 = &cfam0_i2c9;
> > +               i2c110 = &cfam0_i2c10;
> > +               i2c111 = &cfam0_i2c11;
> > +               i2c112 = &cfam0_i2c12;
> > +               i2c113 = &cfam0_i2c13;
> > +               i2c114 = &cfam0_i2c14;
> > +               i2c200 = &cfam1_i2c0;
> > +               i2c201 = &cfam1_i2c1;
> > +               i2c202 = &cfam1_i2c2;
> > +               i2c203 = &cfam1_i2c3;
> > +               i2c204 = &cfam1_i2c4;
> > +               i2c205 = &cfam1_i2c5;
> > +               i2c206 = &cfam1_i2c6;
> > +               i2c207 = &cfam1_i2c7;
> > +               i2c208 = &cfam1_i2c8;
> > +               i2c209 = &cfam1_i2c9;
> > +               i2c210 = &cfam1_i2c10;
> > +               i2c211 = &cfam1_i2c11;
> > +               i2c212 = &cfam1_i2c12;
> > +               i2c213 = &cfam1_i2c13;
> > +               i2c214 = &cfam1_i2c14;
> 
> This is... unconventional. Fixed mapping but up at a high bus range
> such that it won't conflict with other SoC busses?

Yes. I'll describe the topology below.

> Just make your tools figure out what bus to use with sysfs or DT
> entries instead, much less of a hack. We've done these things to IRQs
> and GPIOs in the past, and it's a pain to clean up later.

Well, fixing the tools is ... hard and fixing the users of those tools
harder. Chances are people are just going to keep out of tree kernel
hacks rather than fixing their tools if that's what it gets to but we
can hope...

Ideally we could try creating a bunch of udev scripts that create named
symlinks for those i2c busses but that will take time. Anyway, here's
what we are trying to do:

So you may remember from your days at IBM :-) The FSI bus is the
service interface to the POWER chips (a bit like PECI on x86 I think).
It also connect to things like memory buffer chips etc...

This is the view of the system from the perspective of the BMC
management controller (or the FSP, same deal).

The BMC is typically master of one FSI bus to one chip, let's say P9
for now, and can access more chips via cascaded FSI masters (aka FSI
"hubs") in that chip. Those secondary chips can themselves have hubs to
other chips etc...

So we want a dtsi file that represent a "chip". ie, a power9.dtsi, a
power8.dtsi, a centaur.dtsi (centaur is the mem buffer) etc... There's
a while bunch of things in such a chip, the current patch only has a
portion of what will eventually be there. Via FSI we can access the OCC
thermal control processor, the i2c masters, the XSCOM engine, the scan
engine, etc. etc... Each of these will bind with drivers in the BMC
kernel.

And we want the top-level "system" file to instanciate them all in the
right places to represent a given system topology.

In addition, we do need some properties to uniquely identify a
chip/socket in the system in a stable manner. If anything to provide
meaningful data to the user, but also to cross-match with corresponding
fans etc...

Originally, I thought I could just use the DT "override" constructs to
do something like:

&bmc_fsi {
#include "power9.dtsi"
}

But then I couldn't find a way to then add the chip id to power9. dts
can't do things like

&bmc_fsi/cfam at 0 {
	chip-id = <...>;
};

It seems.

I tried without using the bmc_fsi label, using a full path but that
failed too, dtc thought I was trying to create a duplicate node rather
than appending to an existing one.

Then I need to add another chip to one of the hub legs. Here too, how ?
I can have power9.dtsi define labels for its hub legs but then it will
clash when I bring in the second one...

So even ignoring the business with the i2c aliases, I'm a bit stuck.

I didn't quite get what you proposed with using the macros differently,
any chance you can throw a small example ? I'm hoping it doesn't
involve having the entire power9 chip content be a giant macro :-)

Cheers,
Ben.
