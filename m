From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Aug 2016 18:32:02 +0100
Subject: [arm64:ttbr0-pan 1/7] arch/arm64/lib/clear_user.S:40: Error:
 unknown mnemonic `user' -- `user(9f, str xzr,[x0],8)'
In-Reply-To: <201608130106.YbIf6lrl%fengguang.wu@intel.com>
References: <201608130106.YbIf6lrl%fengguang.wu@intel.com>
Message-ID: <20160812173202.GL12939@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 13, 2016 at 01:01:12AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git ttbr0-pan
> head:   d83997941fc4c1162a9084b8b7e98ed6dc130f84
> commit: 1209a972f4ffa3cbbb374be6145518f30cd30d6e [1/7] arm64: Factor out PAN enabling/disabling into separate uaccess_* macros
> config: arm64-allnoconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 1209a972f4ffa3cbbb374be6145518f30cd30d6e
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm64/lib/clear_user.S: Assembler messages:
> >> arch/arm64/lib/clear_user.S:40: Error: unknown mnemonic `user' -- `user(9f, str xzr,[x0],8)'
> >> arch/arm64/lib/clear_user.S:45: Error: unknown mnemonic `user' -- `user(9f, str wzr,[x0],4)'
> >> arch/arm64/lib/clear_user.S:49: Error: unknown mnemonic `user' -- `user(9f, strh wzr,[x0],2)'
> >> arch/arm64/lib/clear_user.S:53: Error: unknown mnemonic `user' -- `user(9f, strb wzr,[x0],0)'

I can reproduce it with allnoconfig as well (defconfig is fine). It
looks like a cyclic #include between alternative.h and assembler.h needs
sorted out (the USER macro is lost somewhere).

-- 
Catalin
