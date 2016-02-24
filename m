From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 24 Feb 2016 13:21:51 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <20160224104638.GL19428@n2100.arm.linux.org.uk>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
Message-ID: <56CD924F.50108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/16 12:46, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2016 at 02:45:30PM +0200, Tomi Valkeinen wrote:
>> My opinion is that the bootloader should be responsible for telling the
>> kernel what hardware there is on the board. For busses like PCI we have
>> proper probing mechanism with global unique identifiers for the devices,
>> and nothing is needed from the bootloader.
> 
> Exactly, but that is _NOT_ the case here, because we're not talking
> about an on-board display.

Ok, what is it then? I'm not familiar with the boards in question.

When does a display become an on-board display? All the panels I have
can be disconnected quite easily, but I still consider them as on-board
displays.

>> In the Versatile case the panels are kind of probeable, but not in the
>> same sense as PCI: all that can be probed on Versatile is a board
>> specific ID, which in itself doesn't tell what kind of panel there is.
>> In addition to the ID we need board specific tables listing the details
>> of the panels.
> 
> That argument does not stack up.  Just because you've plugged in a
> network device does not mean that the kernel can drive it: the kernel
> needs a device specific driver, which is determined by looking at the
> IDs.  There is no standard network driver PCI interface.

Yes, but you can connect the network device to any board with a PCI bus
and it works. Here, if I'm not mistaken, the displays are built for this
single board, making them board specific.

So sure, someone could build boards with the same connector, allowing
you to connect the same displays. If that's the case, then CLCD should
be taken out of this picture, as the board could have something else
than CLCD as the display controller.

>> I think one of the core questions here is: do we want to start adding
>> board specific drivers to the kernel, instead of dealing with it in the
>> bootloader when possible? My understanding is that we've been trying to
>> reduce board specific code from the kernel.
> 
> That's not really the question, because that question assumes that it
> isn't already present, which is not true.  The code is already present.
> The question is how to deal with this from the DT perspective.

Yes. As I commented in this (or the other thread), I'm looking for a
proper generic solution which can be recommended for all new boards.
When we know what that is, we can see if and how that could fit into
Versatile's case. Versatile is not the only board with the exact same
problem.

I wouldn't be at all surprised if the final solution is to just go with
Linus' current patches for Versatile, as everything else would break
compatibility or be overly complex.

But I cannot accept that as a general solution for all similar cases
going forward, especially when moving to DRM world, that's just bad SW
design.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/9d13a40f/attachment.sig>
