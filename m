From: lkp@intel.com (kbuild test robot)
Date: Fri, 4 May 2018 08:29:14 +0800
Subject: [PATCH v2] tty: implement led triggers
In-Reply-To: <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
References: <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
Message-ID: <201805040805.knTZB7wP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.17-rc3 next-20180503]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Uwe-Kleine-K-nig/tty-implement-led-triggers/20180504-075232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: i386-randconfig-x014-201817 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/tty/tty_io.c: In function 'do_tty_write':
>> drivers/tty/tty_io.c:962:38: error: 'struct tty_port' has no member named 'led_trigger_tx'
      led_trigger_blink_oneshot(tty->port->led_trigger_tx, &delay, &delay, 0);
                                         ^~
--
   drivers/tty/tty_buffer.c: In function 'flush_to_ldisc':
>> drivers/tty/tty_buffer.c:526:33: error: 'struct tty_port' has no member named 'led_trigger_rx'
      led_trigger_blink_oneshot(port->led_trigger_rx, &delay, &delay, 0);
                                    ^~

vim +962 drivers/tty/tty_io.c

   893	
   894	/*
   895	 * Split writes up in sane blocksizes to avoid
   896	 * denial-of-service type attacks
   897	 */
   898	static inline ssize_t do_tty_write(
   899		ssize_t (*write)(struct tty_struct *, struct file *, const unsigned char *, size_t),
   900		struct tty_struct *tty,
   901		struct file *file,
   902		const char __user *buf,
   903		size_t count)
   904	{
   905		ssize_t ret, written = 0;
   906		unsigned int chunk;
   907	
   908		ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
   909		if (ret < 0)
   910			return ret;
   911	
   912		/*
   913		 * We chunk up writes into a temporary buffer. This
   914		 * simplifies low-level drivers immensely, since they
   915		 * don't have locking issues and user mode accesses.
   916		 *
   917		 * But if TTY_NO_WRITE_SPLIT is set, we should use a
   918		 * big chunk-size..
   919		 *
   920		 * The default chunk-size is 2kB, because the NTTY
   921		 * layer has problems with bigger chunks. It will
   922		 * claim to be able to handle more characters than
   923		 * it actually does.
   924		 *
   925		 * FIXME: This can probably go away now except that 64K chunks
   926		 * are too likely to fail unless switched to vmalloc...
   927		 */
   928		chunk = 2048;
   929		if (test_bit(TTY_NO_WRITE_SPLIT, &tty->flags))
   930			chunk = 65536;
   931		if (count < chunk)
   932			chunk = count;
   933	
   934		/* write_buf/write_cnt is protected by the atomic_write_lock mutex */
   935		if (tty->write_cnt < chunk) {
   936			unsigned char *buf_chunk;
   937	
   938			if (chunk < 1024)
   939				chunk = 1024;
   940	
   941			buf_chunk = kmalloc(chunk, GFP_KERNEL);
   942			if (!buf_chunk) {
   943				ret = -ENOMEM;
   944				goto out;
   945			}
   946			kfree(tty->write_buf);
   947			tty->write_cnt = chunk;
   948			tty->write_buf = buf_chunk;
   949		}
   950	
   951		/* Do the write .. */
   952		for (;;) {
   953			size_t size = count;
   954			unsigned long delay = 50 /* ms */;
   955	
   956			if (size > chunk)
   957				size = chunk;
   958			ret = -EFAULT;
   959			if (copy_from_user(tty->write_buf, buf, size))
   960				break;
   961	
 > 962			led_trigger_blink_oneshot(tty->port->led_trigger_tx, &delay, &delay, 0);
   963	
   964			ret = write(tty, file, tty->write_buf, size);
   965			if (ret <= 0)
   966				break;
   967			written += ret;
   968			buf += ret;
   969			count -= ret;
   970			if (!count)
   971				break;
   972			ret = -ERESTARTSYS;
   973			if (signal_pending(current))
   974				break;
   975			cond_resched();
   976		}
   977		if (written) {
   978			tty_update_time(&file_inode(file)->i_mtime);
   979			ret = written;
   980		}
   981	out:
   982		tty_write_unlock(tty);
   983		return ret;
   984	}
   985	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28533 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/6fa32491/attachment-0001.gz>
