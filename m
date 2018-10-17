From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 Oct 2018 22:00:31 +0800
Subject: [xlnx:master 2059/2087] drivers/tty/serial/uartlite.c:774:33: error:
 'ulite_of_match' undeclared; did you mean 'ulite_set_mctrl'?
Message-ID: <201810172227.gSD7xMmL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4d97746570a6e51f834bbf2758a4b4c33308428d
commit: 967c635b02189fe38adbc264793129c87be15ddf [2059/2087] serial-uartlite: Remove ULITE_NR_PORTS macro
config: x86_64-randconfig-e0-201841 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 967c635b02189fe38adbc264793129c87be15ddf
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/tty/serial/uartlite.c: In function 'ulite_get_id':
>> drivers/tty/serial/uartlite.c:774:33: error: 'ulite_of_match' undeclared (first use in this function); did you mean 'ulite_set_mctrl'?
      ret = of_alias_get_alias_list(ulite_of_match, "serial",
                                    ^~~~~~~~~~~~~~
                                    ulite_set_mctrl
   drivers/tty/serial/uartlite.c:774:33: note: each undeclared identifier is reported only once for each function it appears in

vim +774 drivers/tty/serial/uartlite.c

   769	
   770		mutex_lock(&bitmap_lock);
   771	
   772		/* Alias list is stable that's why get alias bitmap only once */
   773		if (!alias_bitmap_initialized) {
 > 774			ret = of_alias_get_alias_list(ulite_of_match, "serial",
   775						      alias_bitmap, MAX_UART_INSTANCES);
   776			if (ret) {
   777				mutex_unlock(&bitmap_lock);
   778				return ret;
   779			}
   780	
   781			alias_bitmap_initialized++;
   782		}
   783	
   784		/* Make sure that alias ID is not taken by instance without alias */
   785		bitmap_or(bitmap, bitmap, alias_bitmap, MAX_UART_INSTANCES);
   786	
   787		dev_dbg(&pdev->dev, "Alias bitmap: %*pb\n",
   788			MAX_UART_INSTANCES, bitmap);
   789	
   790		/* Look for a serialN alias */
   791		if (id < 0)
   792			id = of_alias_get_id(pdev->dev.of_node, "serial");
   793	
   794		if (id < 0) {
   795			dev_warn(&pdev->dev,
   796				 "No serial alias passed. Using the first free id\n");
   797	
   798			/*
   799			 * Start with id 0 and check if there is no serial0 alias
   800			 * which points to device which is compatible with this driver.
   801			 * If alias exists then try next free position.
   802			 */
   803			id = 0;
   804	
   805			for (;;) {
   806				dev_info(&pdev->dev, "Checking id %d\n", id);
   807				id = find_next_zero_bit(bitmap, MAX_UART_INSTANCES, id);
   808	
   809				/* No free empty instance */
   810				if (id == MAX_UART_INSTANCES) {
   811					dev_err(&pdev->dev, "No free ID\n");
   812					mutex_unlock(&bitmap_lock);
   813					return -EINVAL;
   814				}
   815	
   816				dev_dbg(&pdev->dev, "The empty id is %d\n", id);
   817				/* Check if ID is empty */
   818				if (!test_and_set_bit(id, bitmap)) {
   819					/* Break the loop if bit is taken */
   820					dev_dbg(&pdev->dev,
   821						"Selected ID %d allocation passed\n",
   822						id);
   823					break;
   824				}
   825				dev_dbg(&pdev->dev,
   826					"Selected ID %d allocation failed\n", id);
   827				/* if taking bit fails then try next one */
   828				id++;
   829			}
   830		}
   831	
   832		mutex_unlock(&bitmap_lock);
   833	
   834		return id;
   835	}
   836	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25621 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/6a6ecf46/attachment-0001.gz>
