From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Oct 2017 16:56:29 +0000
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
Message-ID: <20171031165629.GF9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 09:44:20AM -0700, Linus Torvalds wrote:
> On Tue, Oct 31, 2017 at 9:15 AM, Marc Gonzalez
> <marc_gonzalez@sigmadesigns.com> wrote:
> >
> > On arm32, it is possible to set up udelay() to be clock-based.
> 
> I'm not sure why this is discussed as some kind of generic problem.

Hi Linus,

Marc is stating something that's incorrect there.  On ARM32, we don't
have a TSC, and we aren't guaranteed to have a timer usable for delays.
Where there is a suitable timer, it can be used for delays.

However, where there isn't a timer, we fall back to using the software
loop, and that's where the problem lies.  For example, some platforms
have a relatively slow timer (32kHz).

This centres around is the discussion we had previously:

  http://lists.openwall.net/linux-kernel/2011/01/12/372

where errors of 5% are very much in the "don't care" category for
udelay() - so if udelay() returns early by 5%, we don't care.

Marc, however, does want to care about udelay() etc returning early,
because he wants his NAND driver to be performant, despite using
udelay()/ndelay() in critical paths.  So his argument is that udelay()
and ndelay() should be accurate, and certainly not return early.

Marc's motivation here is to try and force me to "fix" the ARM and
generic loops_per_jiffy code so that these functions provide accurate
delays.  I've said no, based on what we discussed back in 2011.

There's the issue too of the timer-based delay code possibly returning
one timer tick early, which at reasonable timer resolutions is pretty
small.  I don't want to do that, as it encourages people to use data-
sheet values in udelay() and ndelay() without any cushioning, and so
the drivers end up breaking if we fall back to using the software loop
delays - which we know for a fact will return early.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
