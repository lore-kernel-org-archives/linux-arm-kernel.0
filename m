From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 23 Sep 2013 21:16:18 +0200
Subject: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
In-Reply-To: <20130923180259.GJ2684@atomide.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309202122.06327@pali> <20130923180259.GJ2684@atomide.com>
Message-ID: <201309232116.19161@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday 23 September 2013 20:03:00 you wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [130920 12:29]:
> > On Sunday 08 September 2013 10:50:39 Pali Roh?r wrote:
> > > This patch will register bq24150a charger in RX-51 board
> > > data. Patch also adding platform function between isp1704
> > > and bq2415x drivers for detecting charger type.
> > > 
> > > So finally charging battery on Nokia N900 (RX-51) working
> > > automatically without any proprietary Nokia bits in
> > > userspace.
> 
> ...
> 
> > > @@ -277,6 +316,7 @@ static void
> > > rx51_charger_set_power(bool on)
> > > 
> > >  static struct isp1704_charger_data rx51_charger_data = {
> > >  
> > >  	.set_power	= rx51_charger_set_power,
> > > 
> > > +	.set_current	= rx51_charger_set_current,
> > > 
> > >  };
> 
> We want to get rid of the platform data callbacks here,
> there no longer any need to keep these under arch/arm.
> 

Where to put rx51 board specified functions?
It cannot go to DT, because DT does not support C/ASM code.

> > Tony, can you look and review this board patch?
> 
> Yes, looks like this can all be done in the driver nowadays.
> You can use drivers/reset for the set_power. Or if it's really
> controlling the regulator, then the regulator framework. The
> info can be passed in a .dts file for those.
> 
> The .set_current you can do in the driver based on the
> compatible flag.
> 

It is not as simple as it looks. This is reason why I submited 
this patch long time after I submited bq2415x driver.

Problem is that for rx51 is needed specific function which connect 
to two drivers (bq2415x and isp1704) plus it call specific rx51 
board functions.

Something which cannot be in DT (unless DT support C/ASM code).

> > I think that this patch series it the most important for
> > Nokia N900, because it finally bringing charging support.
> > And without charging battery it very hard to use phone
> > which has power supply only from battery.
> 
> Right, let's get this driver updated to use the device tree
> based init and that way this file is no longer needed.
> I would like to $ grep -i grandmom ~/.phonebook | call too :)
> 

Patches for modem support are being prepared for upstreaming :-) 
so after that it is up to you to create "call" script as you want

> I forgot how this charger is wired up, but maybe take a
> look at commit d7bf353f (bq24190_charger: Add support for TI
> BQ24190 Battery Charger) for the DT parts.
> 
> Regards,
> 
> Tony

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/2395c3e1/attachment.sig>
