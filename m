From: lkp@intel.com (kbuild test robot)
Date: Fri, 30 Mar 2018 17:34:42 +0800
Subject: [PATCH v3 5/8] arm: shmobile: Add the RZ/N1 arch to the shmobile
 Kconfig
In-Reply-To: <1522309629-10152-6-git-send-email-michel.pollet@bp.renesas.com>
References: <1522309629-10152-6-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <201803301704.07lgB3Zq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on renesas/devel]
[also build test ERROR on v4.16-rc7 next-20180329]
[cannot apply to robh/for-next power-supply/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michel-Pollet/arm-Base-support-for-Renesas-RZN1D-DB-Board/20180330-103029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git devel
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/power/reset/rzn1-reboot.c: In function 'rzn1_reboot_probe':
>> drivers/power/reset/rzn1-reboot.c:70:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (!parent || !parent->of_node)
     ^~
   drivers/power/reset/rzn1-reboot.c:72:3: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      return -ENODEV;
      ^~~~~~
   drivers/power/reset/rzn1-reboot.c:66:6: warning: unused variable 'err' [-Wunused-variable]
     int err;
         ^~~
   drivers/power/reset/rzn1-reboot.c: At top level:
>> drivers/power/reset/rzn1-reboot.c:74:2: warning: data definition has no type or storage class
     sysctrl = syscon_node_to_regmap(parent->of_node);
     ^~~~~~~
>> drivers/power/reset/rzn1-reboot.c:74:2: error: type defaults to 'int' in declaration of 'sysctrl' [-Werror=implicit-int]
>> drivers/power/reset/rzn1-reboot.c:74:2: error: conflicting types for 'sysctrl'
   drivers/power/reset/rzn1-reboot.c:37:23: note: previous declaration of 'sysctrl' was here
    static struct regmap *sysctrl;
                          ^~~~~~~
>> drivers/power/reset/rzn1-reboot.c:74:34: error: 'parent' undeclared here (not in a function); did you mean 'pte_t'?
     sysctrl = syscon_node_to_regmap(parent->of_node);
                                     ^~~~~~
                                     pte_t
>> drivers/power/reset/rzn1-reboot.c:75:2: error: expected identifier or '(' before 'if'
     if (IS_ERR(sysctrl)) {
     ^~
   drivers/power/reset/rzn1-reboot.c:79:2: warning: data definition has no type or storage class
     err = register_restart_handler(&rzn1_reboot_nb);
     ^~~
>> drivers/power/reset/rzn1-reboot.c:79:2: error: type defaults to 'int' in declaration of 'err' [-Werror=implicit-int]
>> drivers/power/reset/rzn1-reboot.c:79:8: error: initializer element is not constant
     err = register_restart_handler(&rzn1_reboot_nb);
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/reset/rzn1-reboot.c:80:2: error: expected identifier or '(' before 'if'
     if (err) {
     ^~
>> drivers/power/reset/rzn1-reboot.c:85:2: error: expected identifier or '(' before 'return'
     return err;
     ^~~~~~
>> drivers/power/reset/rzn1-reboot.c:86:1: error: expected identifier or '(' before '}' token
    }
    ^
   cc1: some warnings being treated as errors

vim +74 drivers/power/reset/rzn1-reboot.c

a673cd20 Michel Pollet 2018-03-29  63  
a673cd20 Michel Pollet 2018-03-29  64  static int rzn1_reboot_probe(struct platform_device *pdev)
a673cd20 Michel Pollet 2018-03-29  65  {
a673cd20 Michel Pollet 2018-03-29 @66  	int err;
a673cd20 Michel Pollet 2018-03-29  67  	struct device *parent;
a673cd20 Michel Pollet 2018-03-29  68  
a673cd20 Michel Pollet 2018-03-29  69  	parent = pdev->dev.parent;
a673cd20 Michel Pollet 2018-03-29 @70  	if (!parent || !parent->of_node)
a673cd20 Michel Pollet 2018-03-29  71  		dev_err(&pdev->dev, "couldn't find sysctrl node\n");
a673cd20 Michel Pollet 2018-03-29 @72  		return -ENODEV;
a673cd20 Michel Pollet 2018-03-29  73  	}
a673cd20 Michel Pollet 2018-03-29 @74  	sysctrl = syscon_node_to_regmap(parent->of_node);
a673cd20 Michel Pollet 2018-03-29 @75  	if (IS_ERR(sysctrl)) {
a673cd20 Michel Pollet 2018-03-29  76  		dev_err(&pdev->dev, "couldn't find find regmap\n");
a673cd20 Michel Pollet 2018-03-29  77  		return PTR_ERR(sysctrl);
a673cd20 Michel Pollet 2018-03-29  78  	}
a673cd20 Michel Pollet 2018-03-29 @79  	err = register_restart_handler(&rzn1_reboot_nb);
a673cd20 Michel Pollet 2018-03-29  80  	if (err) {
a673cd20 Michel Pollet 2018-03-29  81  		dev_err(&pdev->dev, "register restart handler failed(err=%d)\n",
a673cd20 Michel Pollet 2018-03-29  82  			err);
a673cd20 Michel Pollet 2018-03-29  83  	}
a673cd20 Michel Pollet 2018-03-29  84  
a673cd20 Michel Pollet 2018-03-29 @85  	return err;
a673cd20 Michel Pollet 2018-03-29 @86  }
a673cd20 Michel Pollet 2018-03-29  87  

:::::: The code at line 74 was first introduced by commit
:::::: a673cd202aba1924128e65ccd880b1eb5201c559 reset: Renesas RZ/N1 reboot driver

:::::: TO: Michel Pollet <michel.pollet@bp.renesas.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65137 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180330/904dfbd4/attachment-0001.gz>
