From: lkp@intel.com (kbuild test robot)
Date: Wed, 1 Feb 2017 02:04:42 +0800
Subject: [PATCH 4/7] efi: Get the secure boot status [ver #7]
In-Reply-To: <148587562967.4026.18171897997650345605.stgit@warthog.procyon.org.uk>
Message-ID: <201702010101.EljWXBuB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

[auto build test ERROR on efi/next]
[also build test ERROR on v4.10-rc6 next-20170130]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Howells/efi-Pass-secure-boot-mode-to-kernel-ver-7/20170131-232202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/firmware/efi/libstub/secureboot.c:15:0:
   drivers/firmware/efi/libstub/secureboot.c: In function 'efi_get_secureboot':
>> arch/arm64/include/asm/efi.h:52:34: error: called object is not a function or function pointer
    #define efi_call_runtime(f, ...) sys_table_arg->runtime->f(__VA_ARGS__)
                                     ^
>> drivers/firmware/efi/libstub/secureboot.c:27:2: note: in expansion of macro 'efi_call_runtime'
     efi_call_runtime(get_variable, \
     ^~~~~~~~~~~~~~~~
>> drivers/firmware/efi/libstub/secureboot.c:41:11: note: in expansion of macro 'get_efi_var'
     status = get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
              ^~~~~~~~~~~
>> arch/arm64/include/asm/efi.h:52:34: error: called object is not a function or function pointer
    #define efi_call_runtime(f, ...) sys_table_arg->runtime->f(__VA_ARGS__)
                                     ^
>> drivers/firmware/efi/libstub/secureboot.c:27:2: note: in expansion of macro 'efi_call_runtime'
     efi_call_runtime(get_variable, \
     ^~~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/secureboot.c:47:11: note: in expansion of macro 'get_efi_var'
     status = get_efi_var(efi_SetupMode_name, &efi_variable_guid,
              ^~~~~~~~~~~

vim +52 arch/arm64/include/asm/efi.h

a13b00778 Ard Biesheuvel 2014-07-02  46   */
a13b00778 Ard Biesheuvel 2014-07-02  47  #define EFI_FDT_ALIGN	SZ_2M   /* used by allocate_new_fdt_and_exit_boot() */
a13b00778 Ard Biesheuvel 2014-07-02  48  #define MAX_FDT_OFFSET	SZ_512M
a13b00778 Ard Biesheuvel 2014-07-02  49  
a13b00778 Ard Biesheuvel 2014-07-02  50  #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
fc3720642 Ard Biesheuvel 2016-04-25  51  #define __efi_call_early(f, ...)	f(__VA_ARGS__)
2fb88d885 David Howells  2017-01-31 @52  #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
fc3720642 Ard Biesheuvel 2016-04-25  53  #define efi_is_64bit()			(true)
a13b00778 Ard Biesheuvel 2014-07-02  54  
3552fdf29 Lukas Wunner   2016-11-12  55  #define efi_call_proto(protocol, f, instance, ...)			\

:::::: The code at line 52 was first introduced by commit
:::::: 2fb88d8858497455db948de0d2488b35ef2bd874 arm/efi: Allow invocation of arbitrary runtime services [ver #7]

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32973 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170201/b1cd1c3c/attachment-0001.gz>
