From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Sep 2016 14:33:34 +0200
Subject: [PATCH 2/2] ARM: dts: add device tree for the RealView EB Rev D
In-Reply-To: <e396557c-774a-fbc7-b1d7-04d49b0287b8@arm.com>
References: <1473327043-31903-1-git-send-email-linus.walleij@linaro.org>
 <15288435.aYlmo6e5Gb@wuerfel>
 <CACRpkdZdY-knG+htdgZ0t80GLqC7aNujNf7mwUveDrAnCQ5yfQ@mail.gmail.com>
 <e396557c-774a-fbc7-b1d7-04d49b0287b8@arm.com>
Message-ID: <CACRpkdZDUPgsGAKMmactEpxzSC01NsKhOG8XBp14yDByn0ex9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 12:47 PM, Robin Murphy <robin.murphy@arm.com> wrote:

> I wonder if it would be feasible to simply add a disabled LAN91C111 next
> to the LAN9118 and have a hook in realview-dt.c to swizzle the status at
> runtime based on a read of SYS_ID? (Or is that utterly disgusting?)

I feel what you feel: runtime detection would be better.

The root cause that it is not happening is that device tree is essentially
static and hates scenarios to have its contents even augmented at
runtime. Especially plug-and-play type scenarios. So something that was
so easy to hack up in boardfiles is a nightmare in device tree.

It is technically feasible and I have even done it, in another context.

That was when I employed a "Schr?dinger's cat" approach to the
ARM Versatile display detection:

First I put all possible displays into the device tree, and at runtime
selected which one to connect using the endpoint graph mechanism
in device tree. This was frowned upon.

I then put a pretty standard VGA display in as default, and then added
code to augment that node to whatever display was actually found
by mangling several atributes of the node, rewriting, augmenting,
adding, subtracting. Mostly augmenting. This too, was frowned upon.

This can be done with the ethernet as well: I can just put
both of them in into "disabled" state and switch to "ok" on the one that is
actually there with some code in e.g. mach-realview.

Or I can put in the LAN91C111 and mange that DT node into a
LAN9118 by manipulating the DT node at runtime incl. changing the
compatible string with code.

However upstream developes nixed both approaches before. (After
developing quite a bit of code for each, so I was a bit burnt,
bitter? me? nah. Creative destruction let's say. We learnt something
in the process.)

I was instead told to go work on device tree overlays, or to let
the boot loader (in the RealView case, the abandonware that was
never integrated into upstream U-boot) to do DT augmentation.
One possibility was to let the kernel augment the device tree
before booting and the boot loader just line up a bunch of
overlays it should apply when parsing the DTB(s).

I haven't had time to catch up with what should actually be done
here. I felt a bit like a big piece of design and development was
dropped in my lap to get my boards converted to device tree.
I started looking at it, I might do it one day, but I have lots of other
stuff to do too.

Now it seems that at the finishing line of any Versatile family
device tree conversion I run into this kind of "reinvent DT overlays"
stuff...

Yours,
Linus Walleij
