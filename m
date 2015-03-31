From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 31 Mar 2015 09:26:43 +0200
Subject: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150311164442.GA5264@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
Message-ID: <20150331072643.GB30788@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > >> +		io-channels = <&twl_madc 1>,
> > >> +	                      <&twl_madc 10>,
> > >> +			      <&twl_madc 12>;
> > >> +		io-channel-names = "temp",
> > >> +		                   "ichg",
> > >> +		                   "vbat";
> > >> +	};
> > > 
> > > Rather than just making platform_data into device tree properties..
> > > 
> > > Can't you hide the these custom properties behind the compatible flag?
> > > 
> > > You can initialize that data in the driver based on the compatible
> > > flag and the match data.
> > > 
> > > This makes sense if you can group things to similar configurations.
> > 
> > Maybe I have not completely understood your proposal.
> > 
> > Do you mean to go back to have big parameter tables for each device/battery
> > combination in the driver code and the compatible flag (e.g. compatible = ?board17?)
> > chooses the right data set for the charging map and channels?
> 
> If you can somehow group them, then yes. Not for every board if there
> are many of them naturally.
>  
> > I thought this is what the DT was introduced for - to have the same driver 
> > code but adapt to different boards depending on hardware variations.
> 
> Yeah but you also need to consider the issues related to introducing
> new device tree properties. The device tree properties introduced
> should be generic where possible.
> 
> > And batteries have very different characteristics and vary between devices?
> 
> Right. Maybe that has been already agreed on to use capacity-uah for
> batteries in general? In that case I have not problem with that as
> it's a generic property :)
>  
> > The charging maps are depending on the battery type connected to the twl4030
> > and which madc channel is which value is also a little hardware dependent
> > (although the twl4030 doesn?t give much choice).
> 
> Just to consider alternatives before introducing driver specific
> property for the maps.. Maybe here you could have few different type
> of maps and select something safe by default? Of course it could be this
> is higly board specific, I think some devices may be able to run below
> 3.3V for example..

As I explained in some other mail, those tables should not be
neccessary at all. They can be computed from li-ion characteristics
and internal resistance, and assumed current during charge and
discharge.

Running below 3.3V.. not really. At that point, the battery is really
_empty_, and voltage is going down really really fast.

Plus, you are damaging the battery at that point.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
