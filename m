From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 13 Jan 2014 17:07:07 +0100
Subject: [PATCH v2 15/28] drm/i2c: tda998x: use the tda998x video format
 when cea mode
In-Reply-To: <20140111181832.GD15937@n2100.arm.linux.org.uk>
References: <20140109120448.24d89eba@armhf>
 <20140111181832.GD15937@n2100.arm.linux.org.uk>
Message-ID: <20140113170707.10b908dc@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jan 2014 18:18:32 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Jan 09, 2014 at 12:04:48PM +0100, Jean-Francois Moine wrote:
> > This patch uses the tda998x video format tied to the CEA mode.
> > This reduces the number of i2c exchanges.
> 
> It is my understanding that one of the major design goals of this driver
> is to avoid the use of such a table, and therefore this change is
> undesirable by the original driver authors.  This is more a comment for
> Rob to pick up on.

I retrieved a message from Rabeeh who got this description from NXP
(http://www.solid-run.com/phpbb/viewtopic.php?f=9&t=1205&start=10
 Thu Mar 28, 2013 10:59 am):

1. write register FF of CEC device to &h87.
                (68ff = 87h)           -> activate all clock tree inc HDMI ones so you can then use HDMI device
2. select page 00 of HDMI device :  write 00 in FF
                (e0ff =00h)
3. write register A0 of HDMI device to select predefined format :
                (e0a0 = 06h)       -> select a predefined 1080p60 format
4. write registers A5 and A6 with total number of pixels per line (or greater value)
                (e0a5 = 08h)
                (e0a6 = 97h) for example
5. write register TBG_CTRL1 of HDMI device to select resync method
                (e0cb = 7ch)        -> select
6. write registers VIP_CTRL to configure RGB input ports :
                (e020 = 45h)       -> select VP port configuration
                (e021 = 01h)
                (e022 = 23h)
7. write register VIP_CTRL3 to 20h vto select external SP sync method
                (e023 = 20h)

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
