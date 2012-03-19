From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 19 Mar 2012 15:06:01 +0000
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <20326.55337.249575.289067@ipc1.ka-ro>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314124512.GG1180@shlinux2.ap.freescale.net>
 <20120314141643.GP3852@pengutronix.de>
 <20120315030206.GB13022@shlinux2.ap.freescale.net>
 <20321.37353.63115.664975@ipc1.ka-ro>
 <20120315105927.GE13022@shlinux2.ap.freescale.net>
 <20321.53468.310199.875966@ipc1.ka-ro>
 <20120316030134.GA5161@shlinux2.ap.freescale.net>
 <20120318184749.BB15D3E07BF@localhost> <20326.55337.249575.289067@ipc1.ka-ro>
Message-ID: <20120319150601.B783A3E05A5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Mar 2012 07:54:33 +0100, Lothar Wa??mann <LW@KARO-electronics.de> wrote:
> Grant Likely writes:
> > On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.dong@freescale.com> wrote:
> > > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Wa??mann wrote:
> > > > Dong Aisheng writes:
> > > > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Wa??mann wrote:
> > > > Anyway there is no definite spec how the MAC address(es) are stored
> > > > in the fuse map. Thus reading the MAC from there is more or less
> > > > platform specific.
> > > > 
> > > It's just provide one more option since there are customers storing the MAC
> > > in the fuse map.
> > 
> > That should be straight forward to support; have a property that
> > specifies the method used for fetching/calculating the MAC.
> > 
> Executable code stored inside a DT blob? ;)

I know you're joking here, but I'm going to answer seriously
anyway... Absolutely not.  What I'm suggesting is a property that
specifies the method used to determine the mac address.  Something
like (off the top of my head):

	local-mac-address = [01 02 03 00 00 00];
	local-mac-mask = [0xff 0xff 0xff 0 0 0];
	mac-encoding = "append-serial-number";

> 
> > > > Currently I'm setting up the MAC address for our TX28 from the fuses
> > > > in the platform code passed via platform_data, but that will obviously
> > > > not work with DT.
> > > > 
> > > Non-dt can also use my proposal, then you only need to pass the fixed part of
> > > MAC via platfrom data, the left will be read by fec driver.
> > > 
> > > > The correct way would probably be to pass the MAC from the bootloader
> > > > via a DT blob. But that would require all bootloaders to be updated
> > > > first to support DTS. :(
> > > > 
> > > But uboot will face the same problem that can not define a valid MAC
> > > in dts, did i undertand correctly?
> > > 
> > > > An intermediate solution could be using OF_DEV_AUXDATA to pass a
> > > > platform_data struct that may contain a MAC address set up by the
> > > > platform code.
> > > > 
> > > Yes, it's a way but i'm afraid will not get accepted by dt people.
> > 
> > The problem remains; where does the platform code get the MAC address
> > from?  The kernel has to devise it from *somewhere* and the best place
> > for that should be in the MAC driver itself.
> > 
> The platform code knows how and where the MAC is stored on a specific
> platform. The driver has no business in knowing platform details like
> this. Thus only platform code (or the bootloader) can provide the MAC
> to the driver.

Okay, if so then it would be wise to have a reliable function for the
MAC driver to call to lookup it's address as determined by platform
code.  Alternately, the platform code can write the correct mac
address into the device tree node at init time (see
prom_update_property() and prom_add_property()).

BTW, prom_update_property() currently fails if the property doesn't
actually exist yet which isn't what we want I think.  Also, there are
only two users so it would be easy to change to make it add-or-update
instead of update-only.

> > I've got no problem with the idea of only specifying the OUI in the DT
> > and the driver extracting the remaining 3 bytes from the hardware.
> > 
> > In principle, that's the design intent for DT systems anyway; it
> > describes things which cannot be probed from the hardware, or tells
> > the OS how the data is encoded in the hardware.
> > 
> If all bootloaders were aware of DT this wouldn't be a problem,
> because they could place the correct MAC inside the DT blob right
> away.
> But in the mean time (AKA forever) we need some other solution.

You'll notice I haven't disputed that.

g.
