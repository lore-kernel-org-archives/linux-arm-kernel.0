From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2015 12:03:18 +0000
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
Message-ID: <20151123120317.GN8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 02:59:06PM +0300, nyushchenko at dev.rtsoft.ru wrote:
> From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
> 
> While running an imx6s boasrd, I got following message in boot log:
> 
> [    0.032414] CPU1: failed to boot: -38
> 
> This looked strange: imx6s is singe-core and kernel perfectly knows
> that. However, for some reason it tries to initialize CPU 1?
> 
> I found this to be caused by
> - CONFIG_SMP_ON_UP successfully detects that system is single core,
> - this causes is_smp() to return false,
> - this causes setup_arch() to skip smp_init_cpus() call,
> - this skips board-specific code that sets cpu_possible mask.

Right, so you should end up with the possible and present masks
containing just one CPU, which should prevent the kernel trying to
bring any secondary CPUs online.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
