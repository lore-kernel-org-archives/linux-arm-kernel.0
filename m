From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Mar 2017 08:03:08 +0800
Subject: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
Message-ID: <201703050744.8FbsoMEB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

[auto build test ERROR on linus/master]
[also build test ERROR on next-20170303]
[cannot apply to tip/x86/core drm/drm-next v4.10]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/set_memory_-functions-header-refactor/20170305-062939
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   sound/pci/intel8x0.c: In function 'fill_nocache':
>> sound/pci/intel8x0.c:736:3: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
      set_pages_uc(virt_to_page(buf), size);
      ^~~~~~~~~~~~
>> sound/pci/intel8x0.c:738:3: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]
      set_pages_wb(virt_to_page(buf), size);
      ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   sound/x86/intel_hdmi_audio.c: In function 'had_pcm_hw_params':
>> sound/x86/intel_hdmi_audio.c:1135:11: error: implicit declaration of function 'set_memory_uc' [-Werror=implicit-function-declaration]
     retval = set_memory_uc(addr, pages);
              ^~~~~~~~~~~~~
   sound/x86/intel_hdmi_audio.c: In function 'had_pcm_hw_free':
>> sound/x86/intel_hdmi_audio.c:1163:3: error: implicit declaration of function 'set_memory_wb' [-Werror=implicit-function-declaration]
      set_memory_wb(addr, pages);
      ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/set_pages_uc +736 sound/pci/intel8x0.c

631dd1a8 Justin P. Mattock 2010-10-18  730   *	http://download.intel.com/design/chipsets/specupdt/24505108.pdf
^1da177e Linus Torvalds    2005-04-16  731   */
^1da177e Linus Torvalds    2005-04-16  732  static void fill_nocache(void *buf, int size, int nocache)
^1da177e Linus Torvalds    2005-04-16  733  {
^1da177e Linus Torvalds    2005-04-16  734  	size = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
6d238cc4 Arjan van de Ven  2008-01-30  735  	if (nocache)
6d238cc4 Arjan van de Ven  2008-01-30 @736  		set_pages_uc(virt_to_page(buf), size);
6d238cc4 Arjan van de Ven  2008-01-30  737  	else
6d238cc4 Arjan van de Ven  2008-01-30 @738  		set_pages_wb(virt_to_page(buf), size);
^1da177e Linus Torvalds    2005-04-16  739  }
^1da177e Linus Torvalds    2005-04-16  740  #else
6d238cc4 Arjan van de Ven  2008-01-30  741  #define fill_nocache(buf, size, nocache) do { ; } while (0)

:::::: The code at line 736 was first introduced by commit
:::::: 6d238cc4dc8a36a3915c26202fe49f58a0683fb9 x86: convert CPA users to the new set_page_ API

:::::: TO: Arjan van de Ven <arjan@infradead.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58978 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170305/d6f4df6d/attachment-0001.gz>
