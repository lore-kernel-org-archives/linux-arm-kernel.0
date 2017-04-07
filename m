From: lkp@intel.com (kbuild test robot)
Date: Fri, 7 Apr 2017 21:51:41 +0800
Subject: [PATCH v3] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <1491309014-13967-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <201704072148.iWIGWjTi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.11-rc5 next-20170406]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/gabriel-fernandez-st-com/clk-stm32h7-Add-stm32h743-clock-driver/20170405-100654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-stm32_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/clk/clk-stm32h7.c: In function 'ready_gate_clk_disable':
>> drivers/clk/clk-stm32h7.c:250:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (rgate->backup_domain && dbp_status)
     ^~
   drivers/clk/clk-stm32h7.c:253:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
      clk_gate_ops.disable(hw);
      ^~~~~~~~~~~~

vim +/if +250 drivers/clk/clk-stm32h7.c

   234		return bit_status;
   235	}
   236	
   237	static void ready_gate_clk_disable(struct clk_hw *hw)
   238	{
   239		struct clk_gate *gate = to_clk_gate(hw);
   240		struct stm32_ready_gate *rgate = to_ready_gate_clk(gate);
   241		int dbp_status;
   242		int bit_status;
   243		unsigned int timeout = RGATE_TIMEOUT;
   244	
   245		if (!ready_gate_clk_is_enabled(hw))
   246			return;
   247	
   248		dbp_status = is_enable_power_domain_write_protection();
   249	
 > 250		if (rgate->backup_domain && dbp_status)
   251			disable_power_domain_write_protection();
   252	
   253			clk_gate_ops.disable(hw);
   254	
   255		do {
   256			bit_status = !!(readl(gate->reg) & BIT(rgate->bit_rdy));
   257	
   258			if (bit_status)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 9580 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170407/d9d660e8/attachment.gz>
