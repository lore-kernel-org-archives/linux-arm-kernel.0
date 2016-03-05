From: lkp@intel.com (kbuild test robot)
Date: Sat, 5 Mar 2016 11:19:41 +0800
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1456945629-1793533-2-git-send-email-arnd@arndb.de>
Message-ID: <201603051128.RmeLnnZW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v4.5-rc6 next-20160304]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/isdn-icn-remove-a-warning/20160303-031435
config: m68k-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/io_mm.h:26:0,
                    from arch/m68k/include/asm/io.h:4,
                    from include/linux/io.h:25,
                    from drivers/staging/i4l/icn/icn.h:41,
                    from drivers/staging/i4l/icn/icn.c:12:
   drivers/staging/i4l/icn/icn.c: In function 'icn_shiftout':
   arch/m68k/include/asm/raw_io.h:43:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    #define out_8(addr,b) (void)((*(__force volatile u8 *) (addr)) = (b))
                                   ^
   arch/m68k/include/asm/io_mm.h:396:72: note: in expansion of macro 'out_8'
    #define outb(val, port) ((port) < 1024 ? isa_rom_outb((val), (port)) : out_8((port), (val)))
                                                                           ^
>> drivers/staging/i4l/icn/icn.h:59:16: note: in expansion of macro 'outb'
    #define OUTB_P outb
                   ^
>> drivers/staging/i4l/icn/icn.c:89:3: note: in expansion of macro 'OUTB_P'
      OUTB_P((u_char) ((val >> s) & 1) ? 0xff : 0, port);
      ^

vim +/outb +59 drivers/staging/i4l/icn/icn.h

^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  35  #ifdef __KERNEL__
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  36  /* Kernel includes */
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  37  
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  38  #include <linux/errno.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  39  #include <linux/fs.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  40  #include <linux/major.h>
2584cf83 drivers/isdn/icn/icn.h Dan Williams   2015-08-10 @41  #include <linux/io.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  42  #include <linux/kernel.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  43  #include <linux/signal.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  44  #include <linux/slab.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  45  #include <linux/mm.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  46  #include <linux/mman.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  47  #include <linux/ioport.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  48  #include <linux/timer.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  49  #include <linux/wait.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  50  #include <linux/delay.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  51  #include <linux/isdnif.h>
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  52  
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  53  #endif                          /* __KERNEL__ */
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  54  
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  55  /* some useful macros for debugging */
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  56  #ifdef ICN_DEBUG_PORT
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  57  #define OUTB_P(v, p) {printk(KERN_DEBUG "icn: outb_p(0x%02x,0x%03x)\n", v, p); outb_p(v, p);}
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  58  #else
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16 @59  #define OUTB_P outb
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  60  #endif
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  61  
^1da177e drivers/isdn/icn/icn.h Linus Torvalds 2005-04-16  62  /* Defaults for Port-Address and shared-memory */

:::::: The code at line 59 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35839 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160305/9e06a97b/attachment-0001.obj>
