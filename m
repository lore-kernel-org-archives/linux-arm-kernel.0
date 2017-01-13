From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2017 11:02:40 +0000
Subject: [PATCH RFC 0/5] mvebu cleanups and preparation for Armada 7k/8k
Message-ID: <20170113110240.GA29164@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Resend including linux-arm-kernel)

This patch series cleans up the mvebu pin controller implementation
such that we can support multiple pin controllers as found in Armada
7k and 8k SoCs.

Currently, in order to do that, we would have to have static variables
and multiple implementations of functions whose only purpose is to
read from the correct static variable.  This is caused by a lack of
driver private data passed into the mvebu pin controller's methods.

Most mvebu pin controllers methods are performing exactly the same
action, so it makes sense to generalise the methods, which in turn
lets us come up with a fairly standardised set of methods.

Another important side effect of these changes is that the structures
with function pointers are now marked const - as they should be in
today's security concious kernel programming environment.

I've included everything except the 7k and 8k drivers, which, before
Thomas went away, he suggested changes to these, so they aren't ready
for submission yet.  However, the rest of the ground work is, and I'd
like users of this code to test it - I don't have all these platforms!

I'm aware of other mvebu SoC support, so I think it's probably a good
idea to get these patches out there and known about, so folk can
consider how they'd like to order merging the changes - obviously new
SoCs with new pinctrl files will need updates somewhere...

The cleanup side of these patches (without the last adding the regmap
support) shows a reduction in code size:

 drivers/pinctrl/mvebu/pinctrl-armada-370.c | 24 +-------
 drivers/pinctrl/mvebu/pinctrl-armada-375.c | 24 +-------
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 24 +-------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c | 24 +-------
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  | 35 +++--------
 drivers/pinctrl/mvebu/pinctrl-dove.c       | 96 +++++++++++++++++-------------
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   | 32 +++-------
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      | 77 +++++++++++++++++++++---
 drivers/pinctrl/mvebu/pinctrl-mvebu.h      | 51 +++++++---------
 drivers/pinctrl/mvebu/pinctrl-orion.c      |  8 ++-
 10 files changed, 183 insertions(+), 212 deletions(-)

Adding regmap support increases the code size again:

 drivers/pinctrl/mvebu/pinctrl-armada-370.c |  24 +----
 drivers/pinctrl/mvebu/pinctrl-armada-375.c |  24 +----
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c |  24 +----
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c |  24 +----
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  |  35 ++------
 drivers/pinctrl/mvebu/pinctrl-dove.c       |  96 +++++++++++---------
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   |  32 ++-----
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      | 137 +++++++++++++++++++++++++++--
 drivers/pinctrl/mvebu/pinctrl-mvebu.h      |  65 ++++++++------
 drivers/pinctrl/mvebu/pinctrl-orion.c      |   8 +-
 10 files changed, 257 insertions(+), 212 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
