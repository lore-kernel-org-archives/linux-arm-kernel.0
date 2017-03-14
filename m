From: lkp@intel.com (kbuild test robot)
Date: Tue, 14 Mar 2017 12:27:31 +0800
Subject: [PATCH V7 6/7] LIBIO: Support the dynamically logical PIO
 registration of ACPI host I/O
In-Reply-To: <1489372963-9000-7-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201703141216.LokXDKIS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LPC-legacy-ISA-I-O-support/20170314-114635
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from arch/x86/boot/compressed/misc.h:24:0,
                    from arch/x86/boot/compressed/cmdline.c:1:
>> arch/x86/boot/compressed/../ctype.h:4:19: error: redefinition of 'isdigit'
    static inline int isdigit(int ch)
                      ^~~~~~~
   In file included from include/acpi/platform/aclinux.h:82:0,
                    from include/acpi/platform/acenv.h:186,
                    from include/acpi/acpi.h:56,
                    from include/linux/acpi.h:33,
                    from include/linux/libio.h:23,
                    from include/linux/io.h:27,
                    from arch/x86/boot/compressed/misc.h:17,
                    from arch/x86/boot/compressed/cmdline.c:1:
   include/linux/ctype.h:25:19: note: previous definition of 'isdigit' was here
    static inline int isdigit(int c)
                      ^~~~~~~
>> arch/x86/boot/compressed/../ctype.h:9:32: error: expected ')' before 'ch'
    static inline int isxdigit(int ch)
                                   ^
   include/linux/ctype.h:20:50: note: in definition of macro '__ismask'
    #define __ismask(x) (_ctype[(int)(unsigned char)(x)])
                                                     ^
   arch/x86/boot/compressed/../ctype.h:9:19: note: in expansion of macro 'isxdigit'
    static inline int isxdigit(int ch)
                      ^~~~~~~~
   include/linux/ctype.h:20:52: error: expected expression before ']' token
    #define __ismask(x) (_ctype[(int)(unsigned char)(x)])
                                                       ^
   include/linux/ctype.h:36:23: note: in expansion of macro '__ismask'
    #define isxdigit(c) ((__ismask(c)&(_D|_X)) != 0)
                          ^~~~~~~~
   arch/x86/boot/compressed/../ctype.h:9:19: note: in expansion of macro 'isxdigit'
    static inline int isxdigit(int ch)
                      ^~~~~~~~
   include/linux/ctype.h:36:44: error: expected ')' before '!=' token
    #define isxdigit(c) ((__ismask(c)&(_D|_X)) != 0)
                                               ^
   arch/x86/boot/compressed/../ctype.h:9:19: note: in expansion of macro 'isxdigit'
    static inline int isxdigit(int ch)
                      ^~~~~~~~

vim +/isdigit +4 arch/x86/boot/compressed/../ctype.h

60b217a0 arch/x86/boot/ctype.h   Alexander Kuleshov 2015-01-03   1  #ifndef BOOT_CTYPE_H
60b217a0 arch/x86/boot/ctype.h   Alexander Kuleshov 2015-01-03   2  #define BOOT_CTYPE_H
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02   3  
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02  @4  static inline int isdigit(int ch)
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02   5  {
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02   6  	return (ch >= '0') && (ch <= '9');
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02   7  }
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02   8  
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02  @9  static inline int isxdigit(int ch)
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02  10  {
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02  11  	if (isdigit(ch))
f4ed2877 arch/x86/boot/isdigit.h Yinghai Lu         2010-08-02  12  		return true;

:::::: The code at line 4 was first introduced by commit
:::::: f4ed2877b16e8146427306aea8819adac5c88374 x86, setup: reorganize the early console setup

:::::: TO: Yinghai Lu <yinghai@kernel.org>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6522 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/367f20e7/attachment-0001.gz>
