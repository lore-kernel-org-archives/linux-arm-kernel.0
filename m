From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Jan 2014 11:24:53 +0100
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <52EA2875.5020807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 25/01/2014 19:19, Sebastian Hesselbarth wrote:
> This patch set fixes clk init order that went upside-down with
> v3.14. I haven't really investigated what caused this, but I assume
> it is related with DT node reordering by addresses.

Can you explain what kind of issue do you observe?

I have just tested the master branch of Linus and (excepted for SATA
but Andrew will send a patch set soon), I didn't experiment any
issues on Armada 370 and Armada XP based boards.

Thanks,

Gregory


> 
> Anyway, with v3.14 for MVEBU SoCs, the clock gating driver gets
> registered before core clocks driver. Unfortunately, we cannot
> return -EPROBE_DEFER in drivers initialized by clk_of_init. As the
> init order for our drivers is always core clocks before clock gating,
> we maintain init order ourselves by hooking CLK_OF_DECLARE to one
> init function that will register core clocks before clock gating
> driver.
> 
> This patch is based on pre-v3.14-rc1 mainline and should go in as
> fixes for it. As we now send MVEBU clk pull-requests to Mike directly,
> I suggest Jason picks it up as a topic branch.
> 
> The patches have been boot tested on Dove and compile-tested only
> for Kirkwood, Armada 370 and XP.
> 
> Sebastian Hesselbarth (4):
>   clk: mvebu: armada-370: maintain clock init order
>   clk: mvebu: armada-xp: maintain clock init order
>   clk: mvebu: dove: maintain clock init order
>   clk: mvebu: kirkwood: maintain clock init order
> 
>  drivers/clk/mvebu/armada-370.c | 21 ++++++++++-----------
>  drivers/clk/mvebu/armada-xp.c  | 20 +++++++++-----------
>  drivers/clk/mvebu/dove.c       | 19 +++++++++----------
>  drivers/clk/mvebu/kirkwood.c   | 34 ++++++++++++++++------------------
>  4 files changed, 44 insertions(+), 50 deletions(-)
> 
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
