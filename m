From: balbi@ti.com (Felipe Balbi)
Date: Mon, 24 Mar 2014 13:50:27 -0500
Subject: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
In-Reply-To: <53304F76.8090703@ti.com>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
 <20140321055242.GA1959@saruman.home> <53304F76.8090703@ti.com>
Message-ID: <20140324185027.GC12500@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 24, 2014 at 10:29:58AM -0500, Dave Gerlach wrote:
> On 03/21/2014 12:52 AM, Felipe Balbi wrote:
> >On Fri, Mar 21, 2014 at 10:50:13AM +0530, Lokesh Vutla wrote:
> >>From: Dave Gerlach <d-gerlach@ti.com>
> >>
> >>Do not reset GPIO5 at boot-up because GPIO5_7 is used
> >>on AM437x GP-EVM to control VTT regulators on DDR3.
> >>Without this some GP-EVM boards will fail to boot because
> >>of DDR3 corruption.
> >>
> >>Reported-by: Nishanth Menon <nm@ti.com>
> >>Tested-by: Nishanth Menon <nm@ti.com>
> >>Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >>Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >
> >every now and again we see a patch like this because yet another board
> >is using a GPIO to toggle DDR regulators.
> >
> >Instead of constantly patching things like this, how about we try
> >something like below (build-tested only):
> 
> Why should we change all of them? Is it correct to leave every single GPIO
> at the mercy of the bootloader in every situation? The reason we see these

it's not leaving anything at the mercy of the bootloader. It's simply
looking at the HW itself and asking "what's the current state of this
GPIO ?"

> patches only every now and again is because it's a special case that should

I wouldn't call it "special". A GPIO block is pretty dumb, its registers
only give you current pin state, there's virtually no state machine
involved whatsoever.

> be handled only for that situation. I also don't think it makes sense
> to make gpio's a unique case that never gets reset while every other
> IP does by default.

Well, if it doesn't need to be reset, why would you spend that time
resetting it ? In the GPIO case, you gain nothing by resetting the IP,
nothing at all, other than "now I'm sure the IP is in
no-standby/no-idle" but that can be easily read back from SYS[SC]
registers anyway.

The point is that we have two choices here:

a) every time a new board comes around using GPIO as an enable signal
for DDR, we spend a few days debugging why it's not booting.

b) make sure no GPIO block is ever reset, so we never go through the
debugging cycle again.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/2ba8b747/attachment.sig>
