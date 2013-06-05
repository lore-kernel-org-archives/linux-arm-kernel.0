From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Wed, 5 Jun 2013 19:07:07 -0400
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
 <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
Message-ID: <CAKON4OxwyV2f_iTEb5RnP_azc7EsSxPdku_TY5WLWxN7USiY1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 6:47 PM, luke.leighton <luke.leighton@gmail.com> wrote:
> On Wed, Jun 5, 2013 at 10:59 PM, Henrik Nordstr?m
> <henrik@henriknordstrom.net> wrote:
>
>>>  .... and then there's the boot0 and boot1 loaders, these *do* have
>
>> no, these are not tiny. boot0 is 24KB to fit the initial embedded SRAM
>> (not cache), but boot1 is on pair with u-boot in size and runs from
>> DRAM.
>
>  btw, please listen to henrik: he knows what he's talking about, as
> you can see :)   henrik, thank you for correcting my technical
> misunderstandings, i'll try to remember them and not propagate
> incorrect stuff.

This is not about the fex syntax or uboot. The root problem is needing
two sets of binding for every device driver in the kernel. Pick a
random driver like gpio-pca953x.c and look at the source. In that file
there are #ifdef CONFIG_OF_ sections. Those sections are directly
reading the FDT binary via calls like of_get_property(node,
"linux,gpio-base", &size);. If fex is added to the kernel every driver
driver will now need both a #ifdef CONFIG_OF_ section and also a
#ifdef CONFIG_FEX_ section. Doing that is just crazy. Is Allwinner
going to add fex support to every single device driver in the kernel?
Of course not, that task is far too large. What Allwinner needs to do
is come onto the common API that everyone else is using.

So consider what is going to happen if you try to use a pca953x chip
in an Allwinner system. You're going to have to rewrite part of the
device driver. You're going to have to do that for every chip you try
to use. Those forks won't be accepted back into the kernel, etc. And
you'll end up as yet another port and forget embedded developer.

As for uboot I hope you are using the SPL support and haven't
reimplemented it. If the full uboot has been modified to dynamically
read a script.bin then it shouldn't be much of a stretch to teach it
about FDT instead. That would be a useful feature to add to mainline
uboot.

As for fex2bin and bin2fex you already have the equivalent tool on
your machine. It is called dtc. Check out scripts/dtc.

So if you are in love with fex syntax write a script that converts it
into device tree syntax. Then compile the DTS using dtc into a DTB.
When the DTB is in memory it is a FDT (flattened device tree). It's
that FDT format in memory that has become fixed in stone.

--
Jon Smirl
jonsmirl at gmail.com
