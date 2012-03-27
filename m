From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2012 13:59:16 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <CAOh2x==7gNt2Jb3-EHz9-R1pTy6zL93FmUmTBMdpYUnW3F=9Uw@mail.gmail.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203271159.35306.arnd@arndb.de>
 <CAOh2x==7gNt2Jb3-EHz9-R1pTy6zL93FmUmTBMdpYUnW3F=9Uw@mail.gmail.com>
Message-ID: <201203271359.16553.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 March 2012, viresh kumar wrote:
> On Mar 27, 2012 7:07 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
> >
> > On Tuesday 27 March 2012, Viresh Kumar wrote:
> > > On 3/27/2012 4:45 PM, Arnd Bergmann wrote:
> > > > On Tuesday 27 March 2012, Viresh Kumar wrote:
> > > > The normal way is to turn around the logic so you don't have to include this test
> > > > at all. Just have one soc-specific init_machine and map_io function, that calls
> > > > both soc-specific and shared soc functions, e.g.
> > >
> > > But with that, i need multiple DT_MACHINE_START(). Isn't it?
> > > Is this advisable?
> >
> > Having one DT_MACHINE_START per soc is ok if it helps you. Of course if you
> > have multiple ones that are basically identical, it's simpler to just
> > combine them.
> 
> That's what i have done in V1. And then only i came to
> The first problem i mentioned.

Right. I mean you can feel free to do whichever works best for you. If it's easy
to combine the DT_MACHINE_START sections, then do, otherwise don't.

> > Obviously that only works when you initialize the clocks from init_early()
> > instead of from map_io(), but I think that would be the cleanest choice
> > if you want to have single function with run-time dependencies.
> 
> But then why not use machine_init() for doing this too.

That would be even better. I think we should generally try do initialization
as late as possible, ideally from initcalls. The init_early() function should
only be used for code that absolutely has to be run from setup_arch() and
no later, while the map_io() function should ideally only be used to set up
the static mappings and nothing else.

	Arnd
