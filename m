From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 20 Mar 2012 14:17:48 +0100
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <CAA+hA=R8hLZMyRASRim28MNzX4jyE3nsaJ3DPzgxDtUmqtH62w@mail.gmail.com>
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
 <20120318184749.BB15D3E07BF@localhost>
 <20326.55337.249575.289067@ipc1.ka-ro>
 <20120319150601.B783A3E05A5@localhost>
 <20327.25470.723875.916422@ipc1.ka-ro>
 <20120319220224.ABF5A3E0A04@localhost>
 <CAA+hA=R8hLZMyRASRim28MNzX4jyE3nsaJ3DPzgxDtUmqtH62w@mail.gmail.com>
Message-ID: <20328.33660.472382.117901@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng writes:
> On Mon, Mar 19, 2012 at 3:02 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Mon, 19 Mar 2012 17:49:02 +0100, Lothar Wa?mann <LW@KARO-electronics.de> wrote:
> >> Hi,
> >>
> >> Grant Likely writes:
> >> > On Mon, 19 Mar 2012 07:54:33 +0100, Lothar Wa?mann <LW@KARO-electronics.de> wrote:
> >> > > Grant Likely writes:
> >> > > > On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.dong@freescale.com> wrote:
> >> > > > > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Wa?mann wrote:
> >> > > > > > Dong Aisheng writes:
> >> > > > > > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Wa?mann wrote:
> >> > > > > > Anyway there is no definite spec how the MAC address(es) are stored
> >> > > > > > in the fuse map. Thus reading the MAC from there is more or less
> >> > > > > > platform specific.
> >> > > > > >
> >> > > > > It's just provide one more option since there are customers storing the MAC
> >> > > > > in the fuse map.
> >> > > >
> >> > > > That should be straight forward to support; have a property that
> >> > > > specifies the method used for fetching/calculating the MAC.
> >> > > >
> >> > > Executable code stored inside a DT blob? ;)
> >> >
> >> > I know you're joking here, but I'm going to answer seriously
> >> > anyway... Absolutely not. ?What I'm suggesting is a property that
> >> > specifies the method used to determine the mac address. ?Something
> >> > like (off the top of my head):
> >> >
> >> > ? ? local-mac-address = [01 02 03 00 00 00];
> >> > ? ? local-mac-mask = [0xff 0xff 0xff 0 0 0];
> >> > ? ? mac-encoding = "append-serial-number";
> >> >
> >> That still does not specify where the remaining part of the MAC is
> >> stored and how it should be retrieved.
> >
> > I'm suggesting that you define a string that means something specific;
> > that hopefully can be shared by multiple platforms. ?For example,
> > "append-serial-number" might mean start with the values selected by
> > AND of local-mac-address and local-mac-mask, and OR in the board's
> > serial number. ?You would need to define something that worked if this
> > was the solution you used.
> >
> I'm intend to Grant's this suggestion.
> This can be shared by all other imx platforms which stores mac address in
> fuse map and this is commonly used by customer.
> Then we do not need keep writing repeat code for different platforms
> via platform
> data.
> 
> For Lothar's question, we can add a property fuse_mac_offset to indicate
> read mac from fuse map and where to read it.
>
That's not really enough. The format (big-endian vs. little-endian)
may also differ. But it's not really necessary, if the solution with
prom_update_property() works, since then platform code has full
control over the MAC.

> For how many bytes to read, we can calculate it from the local-mac-mask.
> For example, local-mac-mask = [0xff 0xff 0xff 0 0 0], we can get the size
> as 3 bypes.
> 
> Then we have three properties:
> local-mac-address = [01 02 03 00 00 00];
> local-mac-mask = [0xff 0xff 0xff 0 0 0];
> fuse_mac_offset = <1>;
> 
> In fec driver, the final mac address can be got by:
> local-mac-address & local-mac-mask | (read_fuse(1) & 0xffffff)
> 
> Lathar,
> Do you think if this is ok?
>
No. IMO the FEC driver itself should not read any fuses.
Reading fuses is a SoC specific thing and the FEC driver should not
depend on the idiosyncrasies of some SoC wrt. anything else but the
implementation of the FEC itself.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
