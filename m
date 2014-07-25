From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 25 Jul 2014 21:03:22 +0200
Subject: [PATCH] ARM: mvebu: armada xp: Generalize use of i2c quirk
In-Reply-To: <6576319.3qh6UrO3Zo@wuerfel>
References: <1406308951-14612-1-git-send-email-andrew@lunn.ch>
 <6576319.3qh6UrO3Zo@wuerfel>
Message-ID: <20140725190322.GA14713@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Based on the discussion on IRC, I think we can actually simplify the
> existing quirk and avoid spreading it further. Below would be my
> preferred approach.
> 
> 8<------
> [PATCH] ARM: mvebu: simplify openblocks ax3 quirk
> 
> We currently check the SoC revision in order to find out whether we
> have an old or new openblocks ax3 machine and apply a quirk to
> fix the compatible string for the old ones so the i2c driver does
> not crash.
> 
> As it turns out, that is not necessary because the code for the a0
> version also works on all following revisions, just slightly slower.
> As only an RTC is connected to this bus and there are no performance
> constraints in accessing that, we can easily apply that fixup
> for all ax3 machines.
> 
> This also fixes the dtb file to contain the specific revision for a0,
> so we can eventually run without the quirk. Other machines that may
> be based on the a0 revision should do the same.

So lets discuss this.

What we already has works fine for AX3. Your version just simplifies
it some more, forcing all AX3 to never use hardware offloading, with
the aim to reduce maintenance burden in the long run. To remove the
quirk we either need to know the last A0 based AX3 has given out the
magic smoke, or we have a ABI break forcing all AX3 owners to upgrade
there DT blobs. The first we can never know, and we really don't want
the second, it is against the principles of DT.

Your patch does nothing for other products out in the wild with A0
SoCs. We now know there are some IX4-400d with A0. And Benoit Masson
had to figure out the i2c issue the hard way. Although it appears that
WRT1900AC is using B0, maybe there are some early devices with A0?
Can we ever know if there are?

By detecting this issue at run time, we avoid these issues. We avoid
some poor developer bringing up a board has to work out why their
kernel hangs during boot. We avoid some poor potential OpenWRT user
finding out that A0 WRT1900AC does exist, and their box no longer
boots after installing OpenWRT. And are the other products we don't
know about yet using A0?

Is the potential maintenance burden savings worth the pain we might be
causing others by not doing this at runtime?

	Andrew
