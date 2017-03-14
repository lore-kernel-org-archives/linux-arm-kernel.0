From: lkp@intel.com (kbuild test robot)
Date: Tue, 14 Mar 2017 13:25:27 +0800
Subject: [PATCH V7 7/7] LPC: Add the ACPI LPC support
In-Reply-To: <1489372963-9000-8-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201703141328.GuJzQrFz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LPC-legacy-ISA-I-O-support/20170314-114635
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/list.h:8:0,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/bus/hisi_lpc.c:19:
   drivers/bus/hisi_lpc.c: In function 'hisilpc_host_io_register':
>> include/linux/list.h:463:43: error: dereferencing pointer to incomplete type 'struct acpi_device'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                                               
   include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:477:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(child, &root->children, node) {
      ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c: In function 'hisilpc_probe':
   drivers/bus/hisi_lpc.c:550:4: error: implicit declaration of function 'acpi_walk_dep_device_list' [-Werror=implicit-function-declaration]
       acpi_walk_dep_device_list(adev->handle);
       ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +463 include/linux/list.h

^1da177e Linus Torvalds 2005-04-16  457   * list_for_each_entry	-	iterate over list of given type
8e3a67a9 Randy Dunlap   2006-06-25  458   * @pos:	the type * to use as a loop cursor.
^1da177e Linus Torvalds 2005-04-16  459   * @head:	the head for your list.
3943f42c Andrey Utkin   2014-11-14  460   * @member:	the name of the list_head within the struct.
^1da177e Linus Torvalds 2005-04-16  461   */
^1da177e Linus Torvalds 2005-04-16  462  #define list_for_each_entry(pos, head, member)				\
93be3c2e Oleg Nesterov  2013-11-12 @463  	for (pos = list_first_entry(head, typeof(*pos), member);	\
e66eed65 Linus Torvalds 2011-05-19  464  	     &pos->member != (head);					\
8120e2e5 Oleg Nesterov  2013-11-12  465  	     pos = list_next_entry(pos, member))
^1da177e Linus Torvalds 2005-04-16  466  

:::::: The code at line 463 was first introduced by commit
:::::: 93be3c2eb3371f022ad88acf1ab6bee8e3c38378 list: introduce list_last_entry(), use list_{first,last}_entry()

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43892 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/47c800d5/attachment-0001.gz>
