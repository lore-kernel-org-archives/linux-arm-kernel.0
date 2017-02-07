From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 14:54:55 +0800
Subject: [hisi:topic-lpc-4.10-libio 134/148] include/linux/list.h:463:43:
 error: dereferencing pointer to incomplete type 'struct acpi_device'
Message-ID: <201702071445.eXp5vCCS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: 0ccaa690913e8dc13f3bbdfff3c059dc3c2ae936 [134/148] LPC: Add the ACPI LPC support
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0ccaa690913e8dc13f3bbdfff3c059dc3c2ae936
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/list.h:8:0,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/bus/hisi_lpc.c:19:
   drivers/bus/hisi_lpc.c: In function 'hisilpc_bus_platform_notify':
>> include/linux/list.h:463:43: error: dereferencing pointer to incomplete type 'struct acpi_device'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                                               
   include/linux/kernel.h:850:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:596:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(child, &root->children, node) {
      ^~~~~~~~~~~~~~~~~~~

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
Size: 48647 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/899929fd/attachment-0001.gz>
