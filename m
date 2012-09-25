From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Sep 2012 20:02:10 +0000
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <CABLWKA9NjX0+cQZGBOGus99fFkcpwjPxnhmsBuZBz50VbxXyvw@mail.gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201209251233.09060.arnd@arndb.de>
 <CABLWKA9NjX0+cQZGBOGus99fFkcpwjPxnhmsBuZBz50VbxXyvw@mail.gmail.com>
Message-ID: <201209252002.11301.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 September 2012, sebastien requiem wrote:
> On Tue, Sep 25, 2012 at 2:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 25 September 2012, Arnd Bergmann wrote:
> >> On Tuesday 25 September 2012, Andrew Lunn wrote:
> >> > > Regarding mv78xx0, I agree that I'm not sure what to do. The number of
> >> > > supported platforms is small. Should we simply mark mv78xx0 deprecated
> >> > > now, wait a few release cycles to see if anyone shows up, and see what
> >> > > to do at this point?
> >>
> >> We should let Sebastien Requiem comment. He is the only person outside of
> >> Marvell who has contributed a board file for mv78xx0. If he's interested in
> >> keeping it alive, he's hopefully also able to find the time to test the
> >> devicetree version of that platform in mach-mvebu. Similarly, if anyone
> >> has the MASA reference design, that one could be moved over to mach-mvebu
> >> first.
> >>
> >> There is a much smaller user base for mv78xx0 than for orion5x, so as long
> >> as we can keep the support working with DT, we can throw out the legacy
> >> code much faster than for orion. If it doesn't get put into mach-mvebu
> >> and you can't find anyone who has hardware to test on, you could also
> >> stop maintaining it and leave it to bitrot, but I wouldn't just remove it
> >> on a fast track then.
> >
> > The address I used for Sebastien appears to be dead. Maybe this one still
> > works.
> 
> Yes, this one works. Sorry for not having updated my email address.
> 
> I would be happy to convert the mv78xx0 platform to DT (and also do
> the monkey work). My knowledge is quite limited regarding the recent changes
> but I am sure that some of you could help me in the process.
> 
> Moreover, I still have a board to test at home.

Ok, excellent!

If you want to start looking into things, I suggest you follow the
examples from the mach-dove directory, which is similar to mv78xx0 in
that it also has only a small number of boards that are supported,
and we can convert them all at the same time, rather than supporting
both methods in parallel as we do for orion5x and kirkwood.

The basic idea is to start with a DT_START_MACHINE section that will
end up being used for all machines and just initializes all the
devices that you have on your machine, but also calls of_platform_populate.
Then you can gradually move over one device at a time from being
statically initialized to being added to a board description in
arch/arm/boot/dts/*.dts.

One thing that seems to be special about mv78xx0 (though not the wxl
in particular) is that we can have Linux running in two instances on
either core of the machine and just give it a few of the devices.
I think this can be handled nicely with DT by having a .dtsi include
file that actually describes all of the machine but marks most of the
devices as disabled, and then have different .dts files including
the main file and selectively enabling the parts that are used there.

	Arnd
