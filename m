From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Feb 2013 13:16:52 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support again
In-Reply-To: <CANqRtoQtROi1cD3MmykhKLqY+1Y2=f+1Qkmw2bjAaP6yZRPW=Q@mail.gmail.com>
References: <1360813381-3416-1-git-send-email-horms+renesas@verge.net.au>
 <87a9r7v8xd.wl%kuninori.morimoto.gx@renesas.com>
 <CANqRtoQtROi1cD3MmykhKLqY+1Y2=f+1Qkmw2bjAaP6yZRPW=Q@mail.gmail.com>
Message-ID: <20130214041651.GB6036@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 01:04:35PM +0900, Magnus Damm wrote:
> On Thu, Feb 14, 2013 at 1:03 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> > Hi Simon
> >
> >> This partially reverts 58079fa7d54a0929d304054ee759187a2ccd3cdf
> >> (ARM: shmobile: r8a7779: Correct TMU clock support) and fixes
> >> a regression introduced by that patch.
> >>
> >> Although the documentation I have indicates that the patch above is
> >> correct it appears that the change causes the Marzen board to fail to boot
> >> as follows.
> > (snip)
> >> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> >> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> >> @@ -161,7 +161,7 @@ static struct clk_lookup lookups[] = {
> >>       CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
> >>       CLKDEV_DEV_ID("ohci-platform.0", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
> >>       CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
> >> -     CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
> >> +     CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
> >>       CLKDEV_DEV_ID("sh_tmu.2", &mstp_clks[MSTP014]), /* TMU02 */
> >>       CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
> >>       CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
> >
> > Really ???

I am surprised too!

> > Is MSTP value of TMU01 same as TMU00 ?

With the patch above the board appears to boot.
Without the patch, it doesn't.

> Usually, the TMU channels are bundled together. So TMU00 may be for
> channel 0->3 and TMU01 for 4->6.

Ok, so in that case the correct value for "sh_tmu.2" might actually
be MSTP016 or MSTP015 depending on the bundle size. I am unsure how to test
sh_tmu.2.

However, the documentation I have seems to talk about channels
being TMU0..TMU2 and control of them being via MSTP016..MSTP014.
I.e. what the code currently is but not what seems to work for
TMU1 in practice.
