From: lkp@intel.com (kbuild test robot)
Date: Thu, 12 Jul 2018 05:52:15 +0800
Subject: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
In-Reply-To: <20180711131638.12622-2-ludovic.desroches@microchip.com>
References: <20180711131638.12622-2-ludovic.desroches@microchip.com>
Message-ID: <201807120503.pu8ziFZl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.18-rc4 next-20180711]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ludovic-Desroches/add-ISO7816-support/20180712-052207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   drivers/tty/serial/serial_core.c: In function 'uart_ioctl':
   drivers/tty/serial/serial_core.c:1430:7: error: 'TIOCSISO7816' undeclared (first use in this function); did you mean 'TIOCSRS485'?
     case TIOCSISO7816:
          ^~~~~~~~~~~~
          TIOCSRS485
   drivers/tty/serial/serial_core.c:1430:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/serial_core.c:1434:7: error: 'TIOCGISO7816' undeclared (first use in this function); did you mean 'TIOCSISO7816'?
     case TIOCGISO7816:
          ^~~~~~~~~~~~
          TIOCSISO7816

vim +1434 drivers/tty/serial/serial_core.c

  1344	
  1345	/*
  1346	 * Called via sys_ioctl.  We can use spin_lock_irq() here.
  1347	 */
  1348	static int
  1349	uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
  1350	{
  1351		struct uart_state *state = tty->driver_data;
  1352		struct tty_port *port = &state->port;
  1353		struct uart_port *uport;
  1354		void __user *uarg = (void __user *)arg;
  1355		int ret = -ENOIOCTLCMD;
  1356	
  1357	
  1358		/*
  1359		 * These ioctls don't rely on the hardware to be present.
  1360		 */
  1361		switch (cmd) {
  1362		case TIOCGSERIAL:
  1363			ret = uart_get_info_user(port, uarg);
  1364			break;
  1365	
  1366		case TIOCSSERIAL:
  1367			down_write(&tty->termios_rwsem);
  1368			ret = uart_set_info_user(tty, state, uarg);
  1369			up_write(&tty->termios_rwsem);
  1370			break;
  1371	
  1372		case TIOCSERCONFIG:
  1373			down_write(&tty->termios_rwsem);
  1374			ret = uart_do_autoconfig(tty, state);
  1375			up_write(&tty->termios_rwsem);
  1376			break;
  1377	
  1378		case TIOCSERGWILD: /* obsolete */
  1379		case TIOCSERSWILD: /* obsolete */
  1380			ret = 0;
  1381			break;
  1382		}
  1383	
  1384		if (ret != -ENOIOCTLCMD)
  1385			goto out;
  1386	
  1387		if (tty_io_error(tty)) {
  1388			ret = -EIO;
  1389			goto out;
  1390		}
  1391	
  1392		/*
  1393		 * The following should only be used when hardware is present.
  1394		 */
  1395		switch (cmd) {
  1396		case TIOCMIWAIT:
  1397			ret = uart_wait_modem_status(state, arg);
  1398			break;
  1399		}
  1400	
  1401		if (ret != -ENOIOCTLCMD)
  1402			goto out;
  1403	
  1404		mutex_lock(&port->mutex);
  1405		uport = uart_port_check(state);
  1406	
  1407		if (!uport || tty_io_error(tty)) {
  1408			ret = -EIO;
  1409			goto out_up;
  1410		}
  1411	
  1412		/*
  1413		 * All these rely on hardware being present and need to be
  1414		 * protected against the tty being hung up.
  1415		 */
  1416	
  1417		switch (cmd) {
  1418		case TIOCSERGETLSR: /* Get line status register */
  1419			ret = uart_get_lsr_info(tty, state, uarg);
  1420			break;
  1421	
  1422		case TIOCGRS485:
  1423			ret = uart_get_rs485_config(uport, uarg);
  1424			break;
  1425	
  1426		case TIOCSRS485:
  1427			ret = uart_set_rs485_config(uport, uarg);
  1428			break;
  1429	
> 1430		case TIOCSISO7816:
  1431			ret = uart_set_iso7816_config(state->uart_port, uarg);
  1432			break;
  1433	
> 1434		case TIOCGISO7816:
  1435			ret = uart_get_iso7816_config(state->uart_port, uarg);
  1436			break;
  1437		default:
  1438			if (uport->ops->ioctl)
  1439				ret = uport->ops->ioctl(uport, cmd, arg);
  1440			break;
  1441		}
  1442	out_up:
  1443		mutex_unlock(&port->mutex);
  1444	out:
  1445		return ret;
  1446	}
  1447	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54391 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/08b466ed/attachment-0001.gz>
