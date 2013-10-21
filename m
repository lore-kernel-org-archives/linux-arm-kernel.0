From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 21 Oct 2013 09:24:34 +0200
Subject: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
In-Reply-To: <20131020163819.GO2443@sirena.org.uk>
References: <20131018203555.4d974251@armhf>
 <20131020163819.GO2443@sirena.org.uk>
Message-ID: <20131021092434.02966f5e@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Oct 2013 17:38:19 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Oct 18, 2013 at 08:35:55PM +0200, Jean-Francois Moine wrote:
> > At probe time, when the clock driver is not yet initialized, the
> > external clock of the kirkwood sound device will not be usable.  
> 
> This doesn't apply against -next, could you please check and resend?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broone/sound.git topic/kirkwood
> 
> or the for-next branch.

Not easy to find :)

> > It also removes the test about same internal and external clocks which
> > can never occur.
> 
> It seems like reasonable defensiveness to have the test there in case
> someone has a broken DT, though it'd be better to complain about the DT.

The removed test run into:

	clocks = <&si5351 2>, <&si5351 2>;
	clock-names = "internal", "extclk";

where it seems that the user really wanted to make a mistake.
Then, the actual code just wants the si5351 2 to work as the internal
clock, and that cannot be.

Also, about errors, you may see that a `normal` error as:

	clocks = <&si5351 2>, <&gate_clk 13>;
	clock-names = "internal", "extclk";

i.e. inversion of the internal and external clock phandle's, cannot be
detected...

So, it is better to remove the useless test.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
