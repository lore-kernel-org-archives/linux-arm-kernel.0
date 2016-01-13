From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Wed, 13 Jan 2016 09:44:24 +0100
Subject: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
In-Reply-To: <20160112215352.GA5248@amd>
References: <20160109230709.GA30551@amd> <5693BB75.70409@ti.com>
 <20160111214247.GA9735@amd> <56942344.9070609@ti.com>
 <56951A2C.9010602@ti.com> <20160112215352.GA5248@amd>
Message-ID: <20160113084424.GC11560@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 22:53:52 Pavel Machek wrote:
> Hi!
> 
> > >>If not, tell me, and I can do it, but it will involve a lot of swaring...
> > >
> > >I'll give it a look over.
> > 
> > OK, I'm still looking for a test setup, but this was definitely a problem,
> > could you give this a try?:
> 
> Well, search no more. I tested it and seems to work ok. There's one
> more blank line in the source, so I had to apply patch by hand.
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Cc: stable at vger.kernel.org
> 
> ? :-).
> 
> And... thanks!
> 									Pavel

There are more pending fixes for bq27xxx... Maybe your is duplicate?

http://thread.gmane.org/gmane.linux.power-management.general/70090
http://thread.gmane.org/gmane.linux.power-management.general/69716/focus=69714
http://thread.gmane.org/gmane.linux.power-management.general/69716/focus=2110580

Sebastian, please take them and ideally send to stable@ for backporting.

> 
> > diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> > index 880233c..4fec3cf 100644
> > --- a/drivers/power/bq27xxx_battery.c
> > +++ b/drivers/power/bq27xxx_battery.c
> > @@ -470,8 +470,9 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
> >  static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
> >  {
> >  	int soc;
> > +	bool single = di->chip == BQ27000 || di->chip == BQ27010;
> > -	soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
> > +	soc = bq27xxx_read(di, BQ27XXX_REG_SOC, single);
> >  	if (soc < 0)
> >  		dev_dbg(di->dev, "error reading State-of-Charge\n");
> 

-- 
Pali Roh?r
pali.rohar at gmail.com
