From: lkp@intel.com (kbuild test robot)
Date: Wed, 2 Mar 2016 01:19:46 +0800
Subject: [PATCH 4/6] parisc: rtc: provide rtc_class_ops directly
In-Reply-To: <1456851608-3374907-5-git-send-email-arnd@arndb.de>
Message-ID: <201603020101.PTQsR6V8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.5-rc6 next-20160301]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/rtc-generic-follow-up-for-COMPILE_TEST/20160302-011032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: parisc-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All error/warnings (new ones prefixed by >>):

   arch/parisc/kernel/time.c: In function 'rtc_generic_get_time':
>> arch/parisc/kernel/time.c:232:9: error: 'wtime' undeclared (first use in this function)
     memset(wtime, 0, sizeof(*wtime));
            ^
   arch/parisc/kernel/time.c:232:9: note: each undeclared identifier is reported only once for each function it appears in
>> arch/parisc/kernel/time.c:237:2: warning: passing argument 2 of 'rtc_time64_to_tm' from incompatible pointer type
     rtc_time64_to_tm(tod_data.tod_sec, &tm);
     ^
   In file included from arch/parisc/kernel/time.c:15:0:
   include/linux/rtc.h:23:13: note: expected 'struct rtc_time *' but argument is of type 'struct rtc_time **'
    extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
                ^

vim +/wtime +232 arch/parisc/kernel/time.c

   226	}
   227	
   228	static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
   229	{
   230		struct pdc_tod tod_data;
   231	
 > 232		memset(wtime, 0, sizeof(*wtime));
   233		if (pdc_tod_read(&tod_data) < 0)
   234			return -EOPNOTSUPP;
   235	
   236		/* we treat tod_sec as unsigned, so this can work until year 2106 */
 > 237		rtc_time64_to_tm(tod_data.tod_sec, &tm);
   238		return rtc_valid_tm(tm);
   239	}
   240	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43840 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160302/ca67cfe1/attachment-0001.obj>
