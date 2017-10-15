From: lkp@intel.com (kbuild test robot)
Date: Sun, 15 Oct 2017 11:10:09 +0800
Subject: [PATCH v5 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <20171010063619.6303-4-takahiro.akashi@linaro.org>
Message-ID: <201710151012.LrDReBSM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.14-rc4 next-20171013]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/AKASHI-Takahiro/arm64-kexec-add-kexec_file_load-support/20171012-003448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: powerpc-powernv_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/machine_kexec_file_64.c: In function 'arch_kexec_kernel_image_probe':
>> arch/powerpc/kernel/machine_kexec_file_64.c:43:25: error: unused variable 'fops' [-Werror=unused-variable]
     struct kexec_file_ops *fops;
                            ^~~~
>> arch/powerpc/kernel/machine_kexec_file_64.c:42:9: error: unused variable 'ret' [-Werror=unused-variable]
     int i, ret = -ENOEXEC;
            ^~~
>> arch/powerpc/kernel/machine_kexec_file_64.c:42:6: error: unused variable 'i' [-Werror=unused-variable]
     int i, ret = -ENOEXEC;
         ^
   cc1: all warnings being treated as errors

vim +/fops +43 arch/powerpc/kernel/machine_kexec_file_64.c

a0458284 Thiago Jung Bauermann 2016-11-29  38  
a0458284 Thiago Jung Bauermann 2016-11-29  39  int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
a0458284 Thiago Jung Bauermann 2016-11-29  40  				  unsigned long buf_len)
a0458284 Thiago Jung Bauermann 2016-11-29  41  {
a0458284 Thiago Jung Bauermann 2016-11-29 @42  	int i, ret = -ENOEXEC;
a0458284 Thiago Jung Bauermann 2016-11-29 @43  	struct kexec_file_ops *fops;
a0458284 Thiago Jung Bauermann 2016-11-29  44  
a0458284 Thiago Jung Bauermann 2016-11-29  45  	/* We don't support crash kernels yet. */
a0458284 Thiago Jung Bauermann 2016-11-29  46  	if (image->type == KEXEC_TYPE_CRASH)
a0458284 Thiago Jung Bauermann 2016-11-29  47  		return -ENOTSUPP;
a0458284 Thiago Jung Bauermann 2016-11-29  48  
6b2bef33 AKASHI Takahiro       2017-10-10  49  	return _kexec_kernel_image_probe(image, buf, buf_len);
a0458284 Thiago Jung Bauermann 2016-11-29  50  }
a0458284 Thiago Jung Bauermann 2016-11-29  51  

:::::: The code at line 43 was first introduced by commit
:::::: a0458284f0625ade5eff2118bab89b2d4bbacc3e powerpc: Add support code for kexec_file_load()

:::::: TO: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22990 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171015/663b5936/attachment-0001.gz>
