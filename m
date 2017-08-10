From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 10 Aug 2017 12:38:09 +0800
Subject: [arm64:for-next/kernel-mode-neon 5/8]
 arch/arm64/crypto/sha1-ce-glue.c:41:2: error: implicit declaration of
 function 'kernel_neon_begin_partial'
Message-ID: <201708101207.xeLMkhqW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/kernel-mode-neon
head:   66c3ec5a712005625437474cf5a04148d7890350
commit: cb84d11e1625aa3a081d898ca2640bf3a9ca0e96 [5/8] arm64: neon: Remove support for nested or hardirq kernel-mode NEON
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cb84d11e1625aa3a081d898ca2640bf3a9ca0e96
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm64/for-next/kernel-mode-neon HEAD 66c3ec5a712005625437474cf5a04148d7890350 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/crypto/sha1-ce-glue.c: In function 'sha1_ce_update':
>> arch/arm64/crypto/sha1-ce-glue.c:41:2: error: implicit declaration of function 'kernel_neon_begin_partial' [-Werror=implicit-function-declaration]
     kernel_neon_begin_partial(16);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/arm64/crypto/sha2-ce-glue.c: In function 'sha256_ce_update':
>> arch/arm64/crypto/sha2-ce-glue.c:43:2: error: implicit declaration of function 'kernel_neon_begin_partial' [-Werror=implicit-function-declaration]
     kernel_neon_begin_partial(28);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/arm64/crypto/ghash-ce-glue.c: In function 'ghash_update':
>> arch/arm64/crypto/ghash-ce-glue.c:70:3: error: implicit declaration of function 'kernel_neon_begin_partial' [-Werror=implicit-function-declaration]
      kernel_neon_begin_partial(8);
      ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/arm64/crypto/aes-ce-cipher.c: In function 'aes_cipher_encrypt':
>> arch/arm64/crypto/aes-ce-cipher.c:47:2: error: implicit declaration of function 'kernel_neon_begin_partial' [-Werror=implicit-function-declaration]
     kernel_neon_begin_partial(4);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/arm64/crypto/aes-ce-ccm-glue.c: In function 'ccm_encrypt':
>> arch/arm64/crypto/aes-ce-ccm-glue.c:162:2: error: implicit declaration of function 'kernel_neon_begin_partial' [-Werror=implicit-function-declaration]
     kernel_neon_begin_partial(6);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/kernel_neon_begin_partial +41 arch/arm64/crypto/sha1-ce-glue.c

f4857f4c Ard Biesheuvel 2017-04-26  34  
07eb54d3 Ard Biesheuvel 2015-04-09  35  static int sha1_ce_update(struct shash_desc *desc, const u8 *data,
2c98833a Ard Biesheuvel 2014-03-06  36  			  unsigned int len)
2c98833a Ard Biesheuvel 2014-03-06  37  {
07eb54d3 Ard Biesheuvel 2015-04-09  38  	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
2c98833a Ard Biesheuvel 2014-03-06  39  
07eb54d3 Ard Biesheuvel 2015-04-09  40  	sctx->finalize = 0;
2c98833a Ard Biesheuvel 2014-03-06 @41  	kernel_neon_begin_partial(16);
07eb54d3 Ard Biesheuvel 2015-04-09  42  	sha1_base_do_update(desc, data, len,
07eb54d3 Ard Biesheuvel 2015-04-09  43  			    (sha1_block_fn *)sha1_ce_transform);
2c98833a Ard Biesheuvel 2014-03-06  44  	kernel_neon_end();
2c98833a Ard Biesheuvel 2014-03-06  45  
2c98833a Ard Biesheuvel 2014-03-06  46  	return 0;
2c98833a Ard Biesheuvel 2014-03-06  47  }
2c98833a Ard Biesheuvel 2014-03-06  48  

:::::: The code at line 41 was first introduced by commit
:::::: 2c98833a42cd194ba0f537cd21917e15e5593715 arm64/crypto: SHA-1 using ARMv8 Crypto Extensions

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36345 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/a8501fdb/attachment-0001.gz>
