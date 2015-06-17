From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Jun 2015 13:04:20 -0500
Subject: [PATCH RESEND] i2c: omap: improve duty cycle on SCL
In-Reply-To: <20150617180052.GF18421@saruman.tx.rr.com>
References: <1434482445-1818-1-git-send-email-balbi@ti.com>
 <55813BA0.3010001@nokia.com>
 <20150617180052.GF18421@saruman.tx.rr.com>
Message-ID: <20150617180420.GG18421@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 01:00:52PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Jun 17, 2015 at 11:19:28AM +0200, Alexander Sverdlin wrote:
> > > With this patch we try to be as close to 50%
> > > duty cycle as possible. The reason for this
> > > is that some devices present an erratic behavior
> > > with certain duty cycles.
> > > 
> > > One such example is TPS65218 PMIC which fails
> > > to change voltages when running @ 400kHz and
> > > duty cycle is lower than 34%.
> > > 
> > > The idea of the patch is simple:
> > > 
> > > calculate desired scl_period from requested scl
> > > and use 50% for tLow and 50% for tHigh.
> > > 
> > > tLow is calculated with a DIV_ROUND_UP() to make
> > > sure it's slightly higher than tHigh and to make
> > > sure that we end up within I2C specifications.
> > > 
> > > Kudos to Nishanth Menon and Dave Gerlach for helping
> > > debugging the TPS65218 problem found on AM437x SK.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > 
> > NAK.
> > This is a direct violation of PHILIPS I2C-bus Specification v.2.1,
> > section 15.
> > Namely, you will have LOW period of SCL clock shorter than required
> > 1.3uS.
> 
> how is this out of spec ?
> 
> http://i.imgur.com/jEDlZT7.png
> 
> -Width = 1.4us, frequency 373.1kHz, duty cycle of 47.76%
> 
> In any case, I have to send v2 anyway (found a bug which would show up
> on frequencies above 400kHz), so I'll resend this patch.

Also, let's assume we can generate exactly 400kHz with the same duty
cycle. 400kHz has a period of 2500ns, so:

2500 * (1 - 0.4773) = 1306us

How is that out of spec ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/65aa5783/attachment-0001.sig>
