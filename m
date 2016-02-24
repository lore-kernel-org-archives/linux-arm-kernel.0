From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 24 Feb 2016 13:47:36 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <20160224113549.GN19428@n2100.arm.linux.org.uk>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com> <20160224113549.GN19428@n2100.arm.linux.org.uk>
Message-ID: <56CD9858.40104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/16 13:35, Russell King - ARM Linux wrote:

> If the connector is a flexi-strip or LVDS connector designed to be
> connected directly to a panel, it is not designed as a user connector,
> and the display can be regarded as part of the board: the connector
> probably isn't rated for a large number of mating cycles.
> 
> If the connector is a board-edge external-unit connector, then the
> panel is not part of the board.

Ok, I see. I presumed the display-board was attached directly to the
mainboard. Of course, we could still argue about the difference, with
the exact same pins used with an external connector and with an on-board
connector, but lets not go there.

I agree in this case the panels are external devices =).

However, I would still be interested in opinions how to implement the
exact same case, but for boards where the panels were considered
on-board panels.

> The displays are not built for "this single board" but for a family of
> boards: not only Versatile PB/AB, but also the Realview family of boards
> too.

Alright.

So, if this is to be done correctly, we need to disconnect the display
board code from the CLCD code, as they really have nothing to do with
each other.

Perhaps a panel driver which covers the display boards used here, which
does the probing and contains the video timings for the panels in question?

One could then use that panel driver with other display controllers too.
Although the probing part is perhaps difficult to make generic, but that
board specific code should still be part of the panel-board driver, not
CLCD driver.

>> But I cannot accept that as a general solution for all similar cases
>> going forward, especially when moving to DRM world, that's just bad SW
>> design.
> 
> I think that's a matter of personal opinion, perspective and situation.
> What is good design today is not necessary good design yesterday or
> tomorrow.  I thought we already ascertained that earlier in this
> discussion. :)

Well, I was mostly referring to combining separate devices into single
driver. CLCD and the external displays, in this case. Then again,
"complexity" is part of the SW design, and splitting the devices drivers
into independent pieces often increases complexity, so...

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/2f80fff6/attachment-0001.sig>
