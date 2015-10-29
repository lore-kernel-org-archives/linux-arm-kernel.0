From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Oct 2015 15:09:22 +0000
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call
 into nop
In-Reply-To: <201510292118.ZYBYzBGa%fengguang.wu@intel.com>
References: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
 <201510292118.ZYBYzBGa%fengguang.wu@intel.com>
Message-ID: <20151029150922.GE3440@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 09:35:42PM +0800, kbuild test robot wrote:
> [auto build test ERROR on arm64/for-next/core -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/Li-Bin/recordmcount-arm64-replace-the-ignored-mcount-call-into-nop/20151028-160846
> config: arm64-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
> >> /bin/bash: line 1: 117734 Segmentation fault      ./scripts/recordmcount "arch/arm64/kernel/traps.o"
> --
> >> /bin/bash: line 1: 113824 Segmentation fault      ./scripts/recordmcount "arch/arm64/mm/fault.o"

I can reproduce this locally with an allmodconfig build. The offset
parameter to make_nop_arm64 is nuts:

  Program received signal SIGSEGV, Segmentation fault.
  make_nop_arm64 (map=0x7ffff7fef000, offset=2600547309829750784) at scripts/recordmcount.c:170
  170		if (*ptr != 0x94000000)

Both shdr->sh_offset (0x17000000000000) and relp->r_offset (0x2400000000000000)
look dodgy in the caller.

Li, can you take a look please?

Will
