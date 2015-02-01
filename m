From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 1 Feb 2015 20:17:50 +0100
Subject: bq2415x_charger.c: battery is discharged (fast, 224mA) when it
 should be charged
In-Reply-To: <20150201113813.GA6570@amd>
References: <20150201094702.GA21628@amd> <201502011108.16071@pali>
 <20150201113813.GA6570@amd>
Message-ID: <20150201191750.GA27467@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2015-02-01 12:38:13, Pavel Machek wrote:
> Hi!
> 
> On Sun 2015-02-01 11:08:16, Pali Roh?r wrote:
> > On Sunday 01 February 2015 10:47:02 Pavel Machek wrote:
> > > Hi!
> > > 
> > > I connected N900 with full battery using USB. For some reason,
> > > charge limit was set to 100mA, battery was "full" and was
> > > discharging:
> > > 
> > 
> > Make sure you have loaded some usb gadget. Without it battery 
> > charging via dedicated wallcharger (and probably also usb host 
> > charger) does not working. g_nokia should be OK.
> 
> I had that loaded (was running from root over USB at the moment.)
> 
> > Try also compiling kernel with CONFIG_USB_GADGET_VBUS_DRAW=500
> > 
> > Also for charger autodetection you need to have loaded 
> > isp1704_charer.ko module (or compiled into kernel).
> > 
> > And make sure that isp1704_charger is loaded before module 
> > bq2415x_charger (there is some probe defer, no idea if it works 
> > as excepted).
> 
> It seems bq2415x_charger is the problem: it all started working when I
> did echo reset > mode... 

It does not switch from "Full" to "Charging", and it does not seem to
switch from "Charging" to "Full", either...:

root at n900:/my/tui/ofone# ./tefone
Ready.
Battery  4.152 V  4.161 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   40.876 / 650 / 500  mA
Battery  4.152 V  4.161 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   48.195 / 650 / 500  mA
Battery  4.152 V  4.164 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   43.554 / 650 / 500  mA
Battery  4.14 V  4.164 V  94 %  0 %  0 / 0 / 2056 mAh  Charging   40.162 / 650 / 500  mA
Battery  4.158 V  4.172 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   54.621 / 650 / 500  mA
Battery  4.158 V  4.175 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   33.736 / 650 / 500  mA
aHello, world
Battery  4.164 V  4.175 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   2.142 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   19.992 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   18.207 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   17.493 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   16.243 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   16.243 / 650 / 500  mA


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
