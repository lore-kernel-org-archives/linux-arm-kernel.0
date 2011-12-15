From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 15 Dec 2011 08:44:48 +0800
Subject: serial tty name
In-Reply-To: <20111214183341.GK4585@pengutronix.de>
References: <20111214144344.GA2090@richard-laptop>
 <4EE8BC52.5060905@compulab.co.il>
 <20111214183341.GK4585@pengutronix.de>
Message-ID: <20111215004447.GO28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 07:33:41PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Dec 14, 2011 at 05:10:10PM +0200, Igor Grinberg wrote:
> > Hi Richard,
> > 
> > On 12/14/11 16:43, Richard Zhao wrote:
> > > How to map different uart port to ttymxc0 (take imx for example)?
> > > 
> > > In rootfs, it usually "getty ttymxc0"  to get
> > > serial console. And the rootfs may be shared by different boards.
> > > Traditionaly way is to set right platform device ID.
> > > 
> > > But with DT, UART2 always generate ttymxc1, UART3 for ttymxc2. You
> > > always needs to modify the getty command when your change another board.
> > > 
> > > Is there a way to fix it?
> > 
> > As for fix in userspace, you can spawn getty on every ttymxc*,
> > so you will get it always.
> > 
> > Another (userspace) fix would be:
> > Instead of getty, add a script (say getty.sh) which will do something like:
> > -----------
> > CONSOLE=`cat /proc/cmdline | tr " " "\n" | grep console= | tr "=" " " | tr "," " "`
> > TTY=`echo $CONSOLE | cut -d' ' -f 2`
> > SPEED=`echo $CONSOLE | cut -d' ' -f 3`
> > 
> > /sbin/getty -L $TTY $SPEED vt100
> > --------------
> 
> what about:
> 
> 	eval "$(sed 's/.*console=\([^,]*\),\([0-9]*\).*/tty=\1; speed=\2/'" /proc/cmdline)"
> 
> this should prevent getting a "useless use of cat award".
Thanks.
Richard
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
