From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 9 May 2015 13:44:28 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <554A7DE5.6040406@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-6-git-send-email-jenskuske@gmail.com>
 <20150506121941.GD11057@lukather> <554A7DE5.6040406@gmail.com>
Message-ID: <20150509114428.GV11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 10:47:33PM +0200, Jens Kuske wrote:
> >> + *     You should have received a copy of the GNU General Public
> >> + *     License along with this file; if not, write to the Free
> >> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> >> + *     MA 02110-1301 USA
> > 
> > Could you remove that last paragraph?
> > It generates a checkpatch warning.
> 
> Sure, will be removed. Just copied it from some other sunxi dtsi.

Yeah, I know, I'm even the one that introduced this in the first place
:)

I sent a patch earlier this week to remove it from the other DT.

> >> +		ahb12_rst: reset at 01c202c0 {
> >> +			#reset-cells = <1>;
> >> +			compatible = "allwinner,sun6i-a31-clock-reset";
> >> +			reg = <0x01c202c0 0xc>;
> >> +		};
> > 
> > This reset controller also resets the timers, it should be initialised
> > much earlier.
> > 
> > What about having an allwinner,sun8i-h3-bus-reset, and adding it to
> > the list of compatibles to initialise earlier in
> > drivers/reset/reset-sunxi.c?
> > 
> > Of course, it would cover the other reset controllers that you have
> > below.
> > 
> 
> You mean using a single bus_rst instead of the three?

Yes.

> Or, why not using allwinner,sun6i-a31-ahb1-reset for ahb12_rst

Strictly speaking, they do not control the same set of devices. I'd
prefer to have a different compatible in case we need to setup a
particular behaviour on a given SoC (for example, force out of reset a
particular device, even if no driver is actually using it), without
impacting the other.

> and adding a .init_time = sun6i_timer_init to the sun8i machine.

But we will need to do that yes.

> I'm a bit confused here now, because for A23, which is almost
> identical, it got removed after your comment:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265064.html

Hmmmm, I think I somehow overlooked the fact that the timer was there,
even though Chen-Yu said it. My bad :/

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150509/9181af3e/attachment.sig>
