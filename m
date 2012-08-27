From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Aug 2012 06:33:05 +0800
Subject: [PATCH 1/2] tty: serial: imx: console write routing is unsafe on
 SMP
In-Reply-To: <1346053012-25686-2-git-send-email-dirk.behme@de.bosch.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
 <1346053012-25686-2-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120827223304.GE2281@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 09:36:51AM +0200, Dirk Behme wrote:
> From: Xinyu Chen <xinyu.chen@freescale.com>
> 
> The console feature's write routing is unsafe on SMP with
> the startup/shutdown call.
> 
> There could be several consumers of the console
> * the kernel printk
> * the init process using /dev/kmsg to call printk to show log
> * shell, which open /dev/console and write with sys_write()
> 
> The shell goes into the normal uart open/write routing,
> but the other two go into the console operations.
> The open routing calls imx serial startup, which will write USR1/2
> register without any lock and critical with imx_console_write call.
> 
> Add a spin_lock for startup/shutdown/console_write routing.
> 
> This patch is a port from Freescale's Android kernel.
> 
> Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
