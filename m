From: w@1wt.eu (Willy Tarreau)
Date: Fri, 29 May 2015 08:47:41 +0200
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <556747E4.6070403@melag.de>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com> <1432322832.5304.63.camel@opteya.com>
 <CAOS_Y6Q37ps+VEnzUZ_uwX++qrRm9Hgx45Q_pmiZSLSNjmKwZg@mail.gmail.com>
 <55670AD4.8020705@melag.de> <20150528133429.GD2067@n2100.arm.linux.org.uk>
 <556747E4.6070403@melag.de>
Message-ID: <20150529064741.GB25351@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 06:52:52PM +0200, Enrico Weigelt, metux IT consult wrote:
> Am 28.05.2015 um 15:34 schrieb Russell King - ARM Linux:
> 
> >>What's the big deal with having DTS/DTB under GPL ?
> >
> >It's really quite simple.  Other open source projects won't touch
> >_our_ DTB with a barge pole through fear of GPL contamination.
> 
> Which other foss projects do you have in mind ?

Any other OS that's not GPL'd and that might be able to run on the
same board. For example FreeBSD (though that's just an example, some
boards might be compatible with tens of OS).

> And why should they fear "poisoning" ?

Search for "GPL contamination", the problem is quite common, GPL
can turn anything GPL-compatible into GPL. So for a non-GPL project
it's very hard to adopt GPL code.

> The DTB is an entirely separate file. Just like various firmware
> blobs, startup scripts, etc, etc.

Yes, one more reason for considering whether we need to force the
same license on it or not.

> Just shipping that file (be it in
> some source tarball or in the flash of some device) doesn't make
> everything else an derived work.

It becomes quite difficult when contributors send patches which affect
both some code and such files. Keep in mind that very often a contributor
doesn't care about the licenses of the file he proposes changes to, he
just wants to have his feature merged to fix his usecase.

> Of course, the viral effect of the GPL could catch in if somebody
> directly compiles-in the dtb into something else (so it cant be
> easily separated / replaced) - but why should anybody wanna do that ?
> Sounds to me like defeating the whole purpose of DTB.

The DTB should even not be in the kernel to start with. Since it's
supposed to describe a board in a portable way to embed it into a
boot loader, it should be OS-agnostic. It just happens that these
days Linux is where most of the work is being done and naturally
it's easier to maintain the projects together. But think of it like
a BIOS on your PC. You wouldn't want to have that BIOS project driven
by a single OS, or you would be extremely careful about the possibility
for other OS to use it without any trouble. Here people do care for the
same things by ensuring that their work on DTB can be safely used, and
even attractive to avoid competing designs that ruin the experience of
users and divide developer's work.

> >So what we'll end up with is other projects creating their own DTB
> >descriptions for the same hardware, with different properties (which
> >they'll do in an effort to ensure that it isn't a "derived work" of
> >the GPL version) and the whole thing turning into a right mess - and
> >a poor experience for users because they then end up with OS specific
> >DT files.
> 
> Anybody is free do to everything on his own. Same as everybody is free
> to write his own kernel, etc.

Yes but in practice, operating systems have become so much complex that
they're not a week-end project anymore, so everyone starts from something
that already exists nowadays. Projects coexist and they need to cooperate
to avoid seeing developers do the same work in parallel and waste their
time doing the same work, the same mistakes, fixing the same bugs etc.

> But I dont see a practical usecase where the GPL's viral effect could
> catch in here in the first place.

When you're a developer and you're scratching your head wondering if
you are taking legal risks by adopting some code, if you see that simply
writing your own code fixes your doubts, you tend to prefer that way
because most developers are not lawyers and don't have the money to
consult them. And believe me, this trouble can happen at any scale,
not just large projects.

> >Alternatively, as Rob points out, people will just go the ACPI route
> >to avoid the GPL contamination problem.
> 
> If they really wanna go that ugly route ... just let them go.
> I don't see where I could care at all.

I think you don't get it : the ugly route as you say could be seen as
still better than the trouble they're scared about. Now you can probably
understand how scary it is if they'd prefer that ugly route.

> As I'm primarily concerned w/ embedded systems, I'll need full
> documentation and control over the device, I won't trust vendor DTBs
> anyways. And I won't help people doing crippled proprietary stuff,
> not at this critical point.

Nobody's talking about making stuff proprietary, just helping friend
projects adopt our work, creating de-facto standards and avoid
fragmentation. In fact proprietary stuff is often the result of a
failure to standardize something. When you're a board vendor and
you see that everyone is using the same DTB, and you want to improve
it, you know that simply sending your update to a few projects will
be enough to make it propagate everywhere. When you see that everyone
uses their own version, at that point it's cheaper to make another
fork than trying to feed everyone with updates in their respective
formats.

> Even for larger systems - except the crippled x86 world - I won't even
> allow any proprietary bootloader/firmware.

Ah ? Have you got the source of the BootRom code of the SoC on your
board to ensure it loads your bootloader as you expect it to and that
it doesn't recognize a signature and jumps to a different address or
whatever ? It's nice to care a lot about openness, but bold statements
like this don't make you look serious nor aware of what you're using,
I'm sorry. When you buy some hardware, it comes with some interfacing
with software, and you have to trust that interface at some point, or
you build your own hardware, CPU etc. This interface can be very low
level (eg: CPU jumps to 0xffff0000 upon reset), run a little bit of
code to initialize some on-chip controllers and start a boot loader
(eg: bootrom), embed the bootloader to load your OS, or come with a
complete OS. You have to decide what's acceptable to you. We all do
that. But simply saying you won't allow *any* proprietary bl/fw doesn't
make much sense.

Cheers,
Willy
