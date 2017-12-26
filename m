From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Dec 2017 18:19:22 +0800
Subject: [PATCH v5 6/8] kernel/jump_label: abstract jump_entry member
 accessors
In-Reply-To: <20171225205440.14575-7-ard.biesheuvel@linaro.org>
References: <20171225205440.14575-7-ard.biesheuvel@linaro.org>
Message-ID: <201712261806.hJg043uc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15-rc5 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/add-support-for-relative-references-in-special-sections/20171226-164147
config: s390-allmodconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All error/warnings (new ones prefixed by >>):

   kernel/jump_label.c: In function 'jump_label_sort_entries':
>> kernel/jump_label.c:59:7: error: 'jump_label_swap' undeclared (first use in this function); did you mean 'jump_label_cmp'?
          jump_label_swap);
          ^~~~~~~~~~~~~~~
          jump_label_cmp
   kernel/jump_label.c:59:7: note: each undeclared identifier is reported only once for each function it appears in
   kernel/jump_label.c: In function 'jump_label_type':
>> kernel/jump_label.c:342:27: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct static_key *key = jump_entry_key(entry);
                              ^~~~~~~~~~~~~~
>> kernel/jump_label.c:344:16: error: implicit declaration of function 'jump_entry_is_branch'; did you mean 'jump_entry_key'? [-Werror=implicit-function-declaration]
     bool branch = jump_entry_is_branch(entry);
                   ^~~~~~~~~~~~~~~~~~~~
                   jump_entry_key
   kernel/jump_label.c: In function '__jump_label_update':
>> kernel/jump_label.c:354:50: warning: comparison between pointer and integer
     for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
                                                     ^~
   kernel/jump_label.c: In function 'jump_label_init':
>> kernel/jump_label.c:396:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      iterk = jump_entry_key(iter);
            ^
   kernel/jump_label.c: In function 'jump_label_init_type':
   kernel/jump_label.c:412:27: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct static_key *key = jump_entry_key(entry);
                              ^~~~~~~~~~~~~~
   kernel/jump_label.c: In function 'jump_label_add_module':
   kernel/jump_label.c:533:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      iterk = jump_entry_key(iter);
            ^
   kernel/jump_label.c: In function 'jump_label_del_module':
   kernel/jump_label.c:583:28: warning: comparison between pointer and integer
      if (jump_entry_key(iter) == key)
                               ^~
   kernel/jump_label.c:586:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      key = jump_entry_key(iter);
          ^
   cc1: some warnings being treated as errors

vim +59 kernel/jump_label.c

    50	
    51	static void
    52	jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
    53	{
    54		unsigned long size;
    55	
    56		size = (((unsigned long)stop - (unsigned long)start)
    57						/ sizeof(struct jump_entry));
    58		sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
  > 59		     jump_label_swap);
    60	}
    61	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48675 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171226/66a319a8/attachment-0001.gz>
