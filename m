From: lkp@intel.com (kbuild test robot)
Date: Fri, 17 Aug 2018 17:34:13 +0800
Subject: [PATCH] arm64: kasan: add interceptors for strcmp/strncmp
 functions
In-Reply-To: <1534495075-82167-1-git-send-email-kyeongdon.kim@lge.com>
References: <1534495075-82167-1-git-send-email-kyeongdon.kim@lge.com>
Message-ID: <201808171700.mOY5aTu1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyeongdon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.18 next-20180817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kyeongdon-Kim/arm64-kasan-add-interceptors-for-strcmp-strncmp-functions/20180817-165304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: x86_64-randconfig-x012-201832 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   mm/kasan/kasan.c: In function 'strcmp':
>> mm/kasan/kasan.c:313:9: error: implicit declaration of function '__strcmp'; did you mean 'strcmp'? [-Werror=implicit-function-declaration]
     return __strcmp(cs, ct);
            ^~~~~~~~
            strcmp
   mm/kasan/kasan.c: In function 'strncmp':
>> mm/kasan/kasan.c:321:9: error: implicit declaration of function '__strncmp'; did you mean 'strncmp'? [-Werror=implicit-function-declaration]
     return __strncmp(cs, ct, len);
            ^~~~~~~~~
            strncmp
   cc1: some warnings being treated as errors

vim +313 mm/kasan/kasan.c

   298	
   299	#undef memcpy
   300	void *memcpy(void *dest, const void *src, size_t len)
   301	{
   302		check_memory_region((unsigned long)src, len, false, _RET_IP_);
   303		check_memory_region((unsigned long)dest, len, true, _RET_IP_);
   304	
   305		return __memcpy(dest, src, len);
   306	}
   307	#undef strcmp
   308	int strcmp(const char *cs, const char *ct)
   309	{
   310		check_memory_region((unsigned long)cs, 1, false, _RET_IP_);
   311		check_memory_region((unsigned long)ct, 1, false, _RET_IP_);
   312	
 > 313		return __strcmp(cs, ct);
   314	}
   315	#undef strncmp
   316	int strncmp(const char *cs, const char *ct, size_t len)
   317	{
   318		check_memory_region((unsigned long)cs, len, false, _RET_IP_);
   319		check_memory_region((unsigned long)ct, len, false, _RET_IP_);
   320	
 > 321		return __strncmp(cs, ct, len);
   322	}
   323	void kasan_alloc_pages(struct page *page, unsigned int order)
   324	{
   325		if (likely(!PageHighMem(page)))
   326			kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
   327	}
   328	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29183 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180817/a1e2e75a/attachment-0001.gz>
