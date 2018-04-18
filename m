From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2018 10:59:50 +0100
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <da3be56b-29d3-72f3-5eba-d6a38ae500d0@ti.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
 <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
 <da3be56b-29d3-72f3-5eba-d6a38ae500d0@ti.com>
Message-ID: <20180418095950.GN10990@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 02:41:43PM +0530, Vignesh R wrote:
> 
> 
> On Tuesday 17 April 2018 02:50 PM, Vignesh R wrote:
> > 
> > 
> > On Monday 16 April 2018 09:15 PM, Tony Lindgren wrote:
> >> * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> >>> Hi,
> >>>
> >>> I'm not entirely sure what's going on, but I see corrupted characters
> >>> with the serial console on the OMAP4430 SDP board.  During boot,
> >>> everything seems fine, the problem appears to be userspace output.
> >>>
> >>> For example, if I edit a file, then quit vi:
> >>>
> >>> :q??%??B??Z?root at omap-4430sdp:~#
> >>
> >> I don't think I've seen that one. What I've seen few times is
> >> typing a key on the serial console echoing back the previous
> >> character typed while the new character won't get displayed
> >> until hitting keyboard again. Only rebooting the device seems
> >> to solve this. This is with 4430 ES2.3 revision.
> >>
> >> I wonder if we're missing some parts of errata i202 handling
> >> in omap_8250_mdr1_errataset()?
> >>
> 
> I wonder if the extra read of MDR1 register at the beginning of
> omap_8250_mdr1_errataset() compared to omap-serial is the issue.
> errata i202 says access to MDR1 can cause data corruption. 
> Assuming both reads and writes can cause glitch then, that read
> is not following advisory:
> 
> I don't have SDP board so, could you verify if below diff helps:
> 
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 6aaa84355fd1..8ab9d0a1b1eb 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -163,11 +163,6 @@ static void omap_8250_mdr1_errataset(struct uart_8250_port *up,
>                                      struct omap8250_priv *priv)
>  {
>         u8 timeout = 255;
> -       u8 old_mdr1;
> -
> -       old_mdr1 = serial_in(up, UART_OMAP_MDR1);
> -       if (old_mdr1 == priv->mdr1)
> -               return;
>  
>         serial_out(up, UART_OMAP_MDR1, priv->mdr1);
>         udelay(2);

That doesn't appear to help.

Looking at the bitstream and comparing what should have been sent with
what was sent, there appears to be some correlation between the two.
It looks like the FTDI is not properly synchronised to the bitstream
coming from the OMAP4430.

Setting two stop bits on both ends (OMAP4430 and FTDI) appears to
improve the issue, but not completely solve it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
