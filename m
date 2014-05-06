From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 May 2014 11:32:22 +0200
Subject: [PATCH RESEND 1/5] ARM: BCM63XX: add basic support for the
 Broadcom BCM63138 DSL SoC
In-Reply-To: <CAGVrzcaoxiwTzduK7_uTLsM=oyzT_2FYkiSS=m0rz5AEJrJRkw@mail.gmail.com>
References: <1398130758-19456-1-git-send-email-f.fainelli@gmail.com>
 <5674507.GGRAhKo0Eq@wuerfel>
 <CAGVrzcaoxiwTzduK7_uTLsM=oyzT_2FYkiSS=m0rz5AEJrJRkw@mail.gmail.com>
Message-ID: <6183628.TOzU0KjZQs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014 15:41:43 Florian Fainelli wrote:
> 2014-05-02 0:55 GMT-07:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 01 May 2014 22:32:27 Florian Fainelli wrote:
> > If you remove the call to iotable_init,
> > you obviously can't access the registers through BCM63XX_{AHB,PERIPH}_VIRT
> > any longer, but accesses through a pointer returned from ioremap()
> > should keep working as before.
> >
> > The DEBUG_LL early output is a special case here, these need one
> > of three options:
> >
> > - .map_io is NULL (preferred)
> > - .map_io points to a function that calls debug_ll_io_init()
> > - .map_io points to a function that calls iotable_init with
> >   an equivalent or larger mapping as debug_ll_io_init() would.
> >
> > I suspect you were doing the third here for historic reasons.
> 
> I think you are right, I was in the 3rd case where accessing the UART
> using its virtual address would make the system. Reading through
> devicemaps_init(), defining a custom map_io() functions means you are
> in control and you explicitely need to call debug_ll_io_init(), which
> I was not doing when I removed my custom map_io() implementation.

Ok, so I guess it should all work now if you remove the function from
the submission, or keep one in your private tree that sets up any
mapping needed by drivers that are not converted along with
debug_ll_io_init().

	Arnd
