From: marcel@holtmann.org (Marcel Holtmann)
Date: Sat, 17 Oct 2015 11:15:17 +0200
Subject: [PATCH] bluetooth: bpa10x: fix BT_HCIUART dependency
In-Reply-To: <4199320.WWtqtXexhZ@wuerfel>
References: <4199320.WWtqtXexhZ@wuerfel>
Message-ID: <A0A720F0-8950-4B1D-99A9-6A0059E8BF8B@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> The change to bpa10x to use the h4_recv_buf helper added a dependency
> on BT_HCIUART. This was incorrectly added to Kconfig by adding a
> 'select' statement, which now in turn causes build failures
> when CONFIG_TTY is not set:
> 
> warning: (BT_HCIBPA10X) selects BT_HCIUART which has unmet direct dependencies (NET && BT && TTY)
> vers/built-in.o: In function `hci_uart_tty_receive':
> fpga-mgr.c:(.text+0x282824): undefined reference to `tty_unthrottle'
> drivers/built-in.o: In function `hci_uart_tty_ioctl':
> fpga-mgr.c:(.text+0x282aa0): undefined reference to `n_tty_ioctl_helper'
> drivers/built-in.o: In function `hci_uart_flush':
> 
> This replaces the 'select BT_HCIUART' dependency with 'depends on', which
> does not have this kind of problem. Alternatively, one could add 'depends
> on TTY', but avoiding 'select' on user-visible options is generally the
> preferred choice as that does not introduce the potential for dependency
> loops or incomplete dependency chains.

the intention here was to use select, but that seems to open all sorts of problems. Since I am most likely the only person that still has this device and attaches it to Linux, I am fine in going the easier path with depends on.

Patch has been applied to bluetooth-next tree.

Regards

Marcel
