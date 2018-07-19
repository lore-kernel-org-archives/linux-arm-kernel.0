From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Jul 2018 07:54:50 +0800
Subject: [PATCH v2 1/2] tty/serial_core: add ISO7816 infrastructure
In-Reply-To: <20180719084737.1490-2-ludovic.desroches@microchip.com>
References: <20180719084737.1490-2-ludovic.desroches@microchip.com>
Message-ID: <201807200737.cwPwFKNL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.18-rc5 next-20180719]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ludovic-Desroches/tty-serial_core-add-ISO7816-infrastructure/20180719-183102
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: parisc-generic-64bit_defconfig (attached as .config)
compiler: hppa64-linux-gnu-gcc (GCC) 7.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.3.0 make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

   drivers/tty/serial/serial_core.c: In function 'uart_ioctl':
>> drivers/tty/serial/serial_core.c:1448:7: error: 'TIOCSISO7816' undeclared (first use in this function); did you mean 'TIOCSRS485'?
     case TIOCSISO7816:
          ^~~~~~~~~~~~
          TIOCSRS485
   drivers/tty/serial/serial_core.c:1448:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/serial_core.c:1452:7: error: 'TIOCGISO7816' undeclared (first use in this function); did you mean 'TIOCSISO7816'?
     case TIOCGISO7816:
          ^~~~~~~~~~~~
          TIOCSISO7816

vim +1448 drivers/tty/serial/serial_core.c

  1362	
  1363	/*
  1364	 * Called via sys_ioctl.  We can use spin_lock_irq() here.
  1365	 */
  1366	static int
  1367	uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
  1368	{
  1369		struct uart_state *state = tty->driver_data;
  1370		struct tty_port *port = &state->port;
  1371		struct uart_port *uport;
  1372		void __user *uarg = (void __user *)arg;
  1373		int ret = -ENOIOCTLCMD;
  1374	
  1375	
  1376		/*
  1377		 * These ioctls don't rely on the hardware to be present.
  1378		 */
  1379		switch (cmd) {
  1380		case TIOCGSERIAL:
  1381			ret = uart_get_info_user(port, uarg);
  1382			break;
  1383	
  1384		case TIOCSSERIAL:
  1385			down_write(&tty->termios_rwsem);
  1386			ret = uart_set_info_user(tty, state, uarg);
  1387			up_write(&tty->termios_rwsem);
  1388			break;
  1389	
  1390		case TIOCSERCONFIG:
  1391			down_write(&tty->termios_rwsem);
  1392			ret = uart_do_autoconfig(tty, state);
  1393			up_write(&tty->termios_rwsem);
  1394			break;
  1395	
  1396		case TIOCSERGWILD: /* obsolete */
  1397		case TIOCSERSWILD: /* obsolete */
  1398			ret = 0;
  1399			break;
  1400		}
  1401	
  1402		if (ret != -ENOIOCTLCMD)
  1403			goto out;
  1404	
  1405		if (tty_io_error(tty)) {
  1406			ret = -EIO;
  1407			goto out;
  1408		}
  1409	
  1410		/*
  1411		 * The following should only be used when hardware is present.
  1412		 */
  1413		switch (cmd) {
  1414		case TIOCMIWAIT:
  1415			ret = uart_wait_modem_status(state, arg);
  1416			break;
  1417		}
  1418	
  1419		if (ret != -ENOIOCTLCMD)
  1420			goto out;
  1421	
  1422		mutex_lock(&port->mutex);
  1423		uport = uart_port_check(state);
  1424	
  1425		if (!uport || tty_io_error(tty)) {
  1426			ret = -EIO;
  1427			goto out_up;
  1428		}
  1429	
  1430		/*
  1431		 * All these rely on hardware being present and need to be
  1432		 * protected against the tty being hung up.
  1433		 */
  1434	
  1435		switch (cmd) {
  1436		case TIOCSERGETLSR: /* Get line status register */
  1437			ret = uart_get_lsr_info(tty, state, uarg);
  1438			break;
  1439	
  1440		case TIOCGRS485:
  1441			ret = uart_get_rs485_config(uport, uarg);
  1442			break;
  1443	
  1444		case TIOCSRS485:
  1445			ret = uart_set_rs485_config(uport, uarg);
  1446			break;
  1447	
> 1448		case TIOCSISO7816:
  1449			ret = uart_set_iso7816_config(state->uart_port, uarg);
  1450			break;
  1451	
> 1452		case TIOCGISO7816:
  1453			ret = uart_get_iso7816_config(state->uart_port, uarg);
  1454			break;
  1455		default:
  1456			if (uport->ops->ioctl)
  1457				ret = uport->ops->ioctl(uport, cmd, arg);
  1458			break;
  1459		}
  1460	out_up:
  1461		mutex_unlock(&port->mutex);
  1462	out:
  1463		return ret;
  1464	}
  1465	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19052 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180720/baff1ff9/attachment-0001.gz>
