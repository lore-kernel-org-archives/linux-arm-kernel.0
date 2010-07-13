From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Jul 2010 10:07:05 +0200
Subject: optimized script [Was: ARM defconfig files]
In-Reply-To: <20100713070741.GB26442@pengutronix.de>
References: <20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<AANLkTinOuU-VVXaMwMp69CBp2Y4wxpoWybEQ34H5j0lJ@mail.gmail.com>
	<alpine.LFD.2.00.1007121510260.10598@xanadu.home>
	<AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com>
	<AANLkTilDoGbCx_0oKKPOeGG7TKL2VSNVII5ydmnQ77B7@mail.gmail.com>
	<20100713070741.GB26442@pengutronix.de>
Message-ID: <20100713080705.GA20978@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 13, 2010 at 09:07:41AM +0200, Uwe Kleine-K?nig wrote:
> Hi
> 
> On Mon, Jul 12, 2010 at 01:50:47PM -0600, Grant Likely wrote:
> > On Mon, Jul 12, 2010 at 1:34 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Mon, Jul 12, 2010 at 12:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > >> I think Uwe could provide his script and add it to the kernel tree.
> > >> Then all architectures could benefit from it. ?Having the defconfig
> > >> files contain only those options which are different from the defaults
> > >> is certainly more readable, even on x86.
> > >
> > > Quite possible. But maintainers would need to be on the lookout of
> > > people actually using the script, and refusing to apply patches that
> > > re-introduce the whole big thing.
> > 
> > I can (partially) speak for powerpc.  If ARM uses this approach, then
> > I think we can do the same.  After the defconfigs are trimmed, I
> > certainly won't pick up any more full defconfigs.
> I just restarted my script on the powerpc defconfigs basing on rc5, I
> assume they complete in a few days time.
So Stephen was faster than me.  I don't know yet how he optimised my
script, meanwhile I put some efforts into it, too by just checking lines
that match "^(# )?CONFIG_".

Find it attached.

I will start to reduce the remaining configs (i.e. all but arm and
powerpc).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
#! /usr/bin/env python
# vim: set fileencoding=utf-8 :
# Copyright (C) 2010 by Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

import getopt
import re
import os
import subprocess
import sys

# This prevents including a timestamp in the .config which makes comparing a
# bit easier.
os.environ['KCONFIG_NOTIMESTAMP'] = 'Yes, please'

re_interesting = re.compile(r'^(# )?CONFIG_')

opts, args = getopt.getopt(sys.argv[1:], '', ['arch=', 'src='])

src = ''
arch = 'arm'

for o, a in opts:
    if o == '--arch':
        arch = a
    elif o == '--src':
        src = a

configdir = os.path.join(src, 'arch', arch, 'configs')

def all_defconfigs():
    lc = len(configdir)
    for root, dirs, files in os.walk(configdir):
        root = root[lc + 1:]
        for f in filter(lambda s: s.endswith('_defconfig'), files):
            yield os.path.join(root, f)

if not args:
    args = all_defconfigs()

for target in args:
    defconfig_src = os.path.join(configdir, target)

    subprocess.check_call(['make', '-s', 'ARCH=%s' % arch, target])
    origconfig = list(open('.config'))
    config = list(origconfig)
    config_size = os.stat('.config').st_size

    i = 0

    while i < len(config):
        mo = re_interesting.match(config[i])
        if mo:
            defconfig = open(defconfig_src, 'w')
            defconfig.writelines(config[:i])
            defconfig.writelines(config[i + 1:])
            defconfig.close()
            subprocess.check_call(['make', '-s', 'ARCH=%s' % arch, target])
            if os.stat('.config').st_size == config_size and list(open('.config')) == origconfig:
                print '-%s' % config[i][:-1]
                del config[i]
            else:
                print ' %s' % config[i][:-1]
                i += 1
        else:
            del config[i]

    defconfig = open(defconfig_src, 'w')
    defconfig.writelines(config)
    defconfig.close()
