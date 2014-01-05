From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 5 Jan 2014 15:33:58 +0100
Subject: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201401051533.58931.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014, Gregory CLEMENT wrote:
> The first variants of Armada XP SoCs (A0 stepping) have issues related
> to the i2c controller which prevent to use the offload mechanism and
> lead to a kernel hang during boot.
> 
> The driver now check the revision of the SoC. If the revision is not
> more recent than the A0 or if the driver can't get the SoC revision
> then it disables the offload mechanism.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Relying on the soc id patch for a "stable" bug fix seems a little
far-reaching to me. I would be happier to first try to do a local
detection based on the i2c bus device node itself. Do you know how
common the A0 revision is? You mention "early release of the
OpenBlocks AX3-4 boards". Any others that you suspect? If not,
how about adding either a boolean property in the node or a
new "compatible" value to distinguish the working version from
the broken one?

If A0 is very common, you might do the same thing in the opposite
way and default to "broken" unless it is explicitly known to be
the good version. In general, I'm much in favor of keeping "quirks"
local to device drivers if possible and not rely on global system
state.

	Arnd
