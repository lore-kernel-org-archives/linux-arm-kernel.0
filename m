From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Mar 2017 11:01:11 +0800
Subject: [PATCHv2 10/14] bpf: Use set_memory.h header
In-Reply-To: <1488413706-9739-11-git-send-email-labbott@redhat.com>
Message-ID: <201703051002.3fhieTkA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

[auto build test ERROR on linus/master]
[also build test ERROR on next-20170303]
[cannot apply to tip/x86/core drm/drm-next v4.10]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/set_memory_-functions-header-refactor/20170305-062939
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/net/bpf_jit_32.c: In function 'bpf_jit_compile':
>> arch/arm/net/bpf_jit_32.c:1051:2: error: implicit declaration of function 'flush_icache_range' [-Werror=implicit-function-declaration]
     flush_icache_range((u32)header, (u32)(ctx.target + ctx.idx));
     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/flush_icache_range +1051 arch/arm/net/bpf_jit_32.c

ddecdfce Mircea Gherzan   2012-03-16  1035  		goto out;
ddecdfce Mircea Gherzan   2012-03-16  1036  
55309dd3 Daniel Borkmann  2014-09-08  1037  	ctx.target = (u32 *) target_ptr;
ddecdfce Mircea Gherzan   2012-03-16  1038  	ctx.idx = 0;
55309dd3 Daniel Borkmann  2014-09-08  1039  
ddecdfce Mircea Gherzan   2012-03-16  1040  	build_prologue(&ctx);
0b59d880 Nicolas Schichan 2015-05-07  1041  	if (build_body(&ctx) < 0) {
0b59d880 Nicolas Schichan 2015-05-07  1042  #if __LINUX_ARM_ARCH__ < 7
0b59d880 Nicolas Schichan 2015-05-07  1043  		if (ctx.imm_count)
0b59d880 Nicolas Schichan 2015-05-07  1044  			kfree(ctx.imms);
0b59d880 Nicolas Schichan 2015-05-07  1045  #endif
0b59d880 Nicolas Schichan 2015-05-07  1046  		bpf_jit_binary_free(header);
0b59d880 Nicolas Schichan 2015-05-07  1047  		goto out;
0b59d880 Nicolas Schichan 2015-05-07  1048  	}
ddecdfce Mircea Gherzan   2012-03-16  1049  	build_epilogue(&ctx);
ddecdfce Mircea Gherzan   2012-03-16  1050  
ebaef649 Daniel Borkmann  2015-11-14 @1051  	flush_icache_range((u32)header, (u32)(ctx.target + ctx.idx));
ddecdfce Mircea Gherzan   2012-03-16  1052  
ddecdfce Mircea Gherzan   2012-03-16  1053  #if __LINUX_ARM_ARCH__ < 7
ddecdfce Mircea Gherzan   2012-03-16  1054  	if (ctx.imm_count)
ddecdfce Mircea Gherzan   2012-03-16  1055  		kfree(ctx.imms);
ddecdfce Mircea Gherzan   2012-03-16  1056  #endif
ddecdfce Mircea Gherzan   2012-03-16  1057  
ddecdfce Mircea Gherzan   2012-03-16  1058  	if (bpf_jit_enable > 1)
79617801 Daniel Borkmann  2013-03-21  1059  		/* there are 2 passes here */

:::::: The code at line 1051 was first introduced by commit
:::::: ebaef649c26b44ff28114b452fd067a270ca7f02 bpf, arm: start flushing icache range from header

:::::: TO: Daniel Borkmann <daniel@iogearbox.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61304 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170305/7bb6e2a1/attachment-0001.gz>
