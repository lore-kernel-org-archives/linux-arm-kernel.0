From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Jul 2010 13:04:02 -0500
Subject: optimized script [Was: ARM defconfig files]
In-Reply-To: <20100713080705.GA20978@pengutronix.de>
References: <AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<AANLkTinOuU-VVXaMwMp69CBp2Y4wxpoWybEQ34H5j0lJ@mail.gmail.com>
	<alpine.LFD.2.00.1007121510260.10598@xanadu.home>
	<AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com>
	<AANLkTilDoGbCx_0oKKPOeGG7TKL2VSNVII5ydmnQ77B7@mail.gmail.com>
	<20100713070741.GB26442@pengutronix.de>
	<20100713080705.GA20978@pengutronix.de>
Message-ID: <20100713180402.GA1422@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 10:07:05AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Jul 13, 2010 at 09:07:41AM +0200, Uwe Kleine-K?nig wrote:
> > Hi
> > 
> > On Mon, Jul 12, 2010 at 01:50:47PM -0600, Grant Likely wrote:
> > > On Mon, Jul 12, 2010 at 1:34 PM, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > > On Mon, Jul 12, 2010 at 12:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > >> I think Uwe could provide his script and add it to the kernel tree.
> > > >> Then all architectures could benefit from it. ?Having the defconfig
> > > >> files contain only those options which are different from the defaults
> > > >> is certainly more readable, even on x86.
> > > >
> > > > Quite possible. But maintainers would need to be on the lookout of
> > > > people actually using the script, and refusing to apply patches that
> > > > re-introduce the whole big thing.
> > > 
> > > I can (partially) speak for powerpc.  If ARM uses this approach, then
> > > I think we can do the same.  After the defconfigs are trimmed, I
> > > certainly won't pick up any more full defconfigs.
> > I just restarted my script on the powerpc defconfigs basing on rc5, I
> > assume they complete in a few days time.
> So Stephen was faster than me.  I don't know yet how he optimised my
> script, meanwhile I put some efforts into it, too by just checking lines
> that match "^(# )?CONFIG_".
> 
> Find it attached.
> 
> I will start to reduce the remaining configs (i.e. all but arm and
> powerpc).

I added just a simple heuristic: If I could remove a line, I attempted
to remove twice the amount next time around (and fall back to 1 if it failed).

I.e. main loop:

i = 0
lines = 1

while i < len(config):
    print 'test for %r + %d' % (config[i], lines)
    defconfig = open(defconfig_src, 'w')
    defconfig.writelines(config[:i])
    defconfig.writelines(config[i + lines:])
    defconfig.close()
    subprocess.check_call(['make', '-s', 'ARCH=%s' % arch, target])
    if os.stat('.config').st_size == config_size and list(open('.config')) == origconfig:
        del config[i:i+lines]
        lines *= 2
    else:
        if lines > 1:
            lines = 1
        else:
            i += 1


I didn't measure what the actual improvement was, but I saw a fair amount
of 2/4/8-attempts passing, so I let it run. Stephen beat me to posting
the resulting patch though. :P

While this script is great, it is somewhat painful to run given that it
attempts one config per line. Even on a fast machine that tends to take
a while.


-Olof
