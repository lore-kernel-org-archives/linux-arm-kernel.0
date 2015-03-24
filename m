From: p.pisati@gmail.com (Paolo Pisati)
Date: Tue, 24 Mar 2015 13:04:47 +0100
Subject: [PATCH 0/3] CONFIG_DEBUG_SET_MODULE_RONX fixups
In-Reply-To: <CAGXu5jKKn1f7bnp3Ezsc3o_iqV19Gu62-83ub3s7Rwu=oK7kBA@mail.gmail.com>
References: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jKKn1f7bnp3Ezsc3o_iqV19Gu62-83ub3s7Rwu=oK7kBA@mail.gmail.com>
Message-ID: <20150324120447.GA3570@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 02:17:55PM -0800, Kees Cook wrote:
> On Wed, Feb 25, 2015 at 2:14 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> > Hi,
> >
> > CONFIG_DEBUG_SET_MODULE_RONX is currently non-functional on arm and arm64
> > because of changes in behavior of is_module_addr. This series fixes
> > both arm and arm64 to work correctly and corrects a minor bug
> > related to section alignment in modules.
> >
> > Laura Abbott (3):
> >   arm64: Don't use is_module_addr in setting page attributes
> >   arm: Don't use is_module_addr in setting page attributes
> >   kernel/module.c: Update debug alignment after symtable generation
> >
> >  arch/arm/mm/pageattr.c   | 5 ++++-
> >  arch/arm64/mm/pageattr.c | 5 ++++-
> >  kernel/module.c          | 2 ++
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> Thanks for fixing this!
> 
> Out of curiosity, which change broke DEBUG_SET_MODULE_RONX ? (i.e.
> does this need a CC: stable, and if so, through which release?)

we need it for 3.19.x too:

without your patches:

root at beaglebone:~# cat /sys/module/bridge/sections/.text
0xbf199000
root at beaglebone:~# cat /sys/module/bridge/sections/.data
0xbf1ae000
root at beaglebone:~# grep -e 0xbf199000 -e 0xbf1ae000 /sys/kernel/debug/kernel_page_tables
0xbf199000-0xbf1b6000         116K     RW x      MEM/CACHED/WBRA

with you patches:

root at beaglebone:~# cat /sys/module/bridge/sections/.text                                                                                   
0xbf191000
root at beaglebone:~# cat /sys/module/bridge/sections/.data
0xbf1a6000
root at beaglebone:~# grep -e 0xbf191000 -e 0xbf1a6000 /sys/kernel/debug/kernel_page_tables                                                   
0xbf191000-0xbf1a2000          68K     ro x      MEM/CACHED/WBRA
0xbf1a2000-0xbf1a6000          16K     ro NX     MEM/CACHED/WBRA
0xbf1a6000-0xbf1ae000          32K     RW NX     MEM/CACHED/WBRA
root at beaglebone:~# uname -a
Linux beaglebone 3.19.0-9-generic #9~RONXFIX SMP Tue Mar 24 10:34:39 UTC 2015
armv7l armv7l armv7l GNU/Linux
root at beaglebone:~#

can you cc: stable@ ?
-- 
bye,
p.
