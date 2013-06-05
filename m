From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Jun 2013 09:23:25 -0400
Subject: DT version of kirkwood_ge0x_init()
In-Reply-To: <51AEFF26.8080004@gmail.com>
References: <51ADBEE0.5040500@keymile.com> <51ADC2C2.6010106@gmail.com>
 <51AE53D4.5070208@keymile.com> <51AEFF26.8080004@gmail.com>
Message-ID: <20130605132325.GI3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerlando,

On Wed, Jun 05, 2013 at 11:04:38AM +0200, Sebastian Hesselbarth wrote:
> On 06/04/13 22:53, Gerlando Falauto wrote:
...
> >Sorry, I am really more than lost when it's about tracking
> >how/where/when changes are pulled. Any "mainlining for dummies" pointer
> >would be more than appreciated.
> 
> Hmm, sometimes I am also lost especially about when branches will be
> merged. Jason can tell you for sure. Basically, patches go into some
> maintainer's or submaintainer's branch first.

In the simple case, we look at the diffstat to see what sections of the
kernel are being changed.  drivers/net, arch/arm, arch/arm/mach-mvebu,
arch/arm/mm are all maintained by different people.  Depending on where
the changes are, that dictates who it will go through, DaveM, LinusW,
Arnd and Olof, Russell King, etc.

Any code changes in arch/arm that are SoC dependent go through arm-soc.
Otherwise, it goes through Russell.  arm-soc is maintained by Arnd and
Olof.  It's so large, that they've broken it up into sub-archs with
maintainers for each.  Myself, Andrew Lunn, and Gregory Clemente
maintain code changes in
arch/arm/mach-{mvebu,kirkwood,orion5x,dove,mv78xx0}.  We feed those
changes in the form of branches to arm-soc, who put it all together and
send it to Linus.

It gets complicated when part of a patch series, like Sebastian's, needs
to go through -net, and the rest through arm-soc.  If the two halves
don't depend on one another, then it's easy.  In this case, the arm-soc
changes _do_ depend on the -net changes.  So, we wait for the -net
changes to get into mainline Linux (because all of the branches from
everyone will have merged together), in this case, in v3.11-rc1.  Once
that lands, I'll base a branch off of it and include Sebastian's changes
to mach-kirkwood.  It will then be sent up to arm-soc for inclusion in
v3.12-rc1.

There's also a corner case where a driver maintainer will Ack a patch
series he would normally take and allow arm-soc to take it.  Usually
this is only if the driver changes are limited to a SoC specific file,
eg drivers/clk/mvebu/*, and the driver maintainer doesn't anticipate any
drivers/clk/* changes that will conflict.  Then, we can take the whole
series in one merge window through arm-soc.  But that's purely up to the
driver maintainer(s), and is by exception, not the rule.

hth,

Jason.
