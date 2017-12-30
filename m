From: peng.fan@nxp.com (Peng Fan)
Date: Sat, 30 Dec 2017 21:53:19 +0800
Subject: [PATCH 2/2] ARM: imx: cpuidle-imx6q: configure CCM to RUN mode when
 CPU is active
In-Reply-To: <1514641999-20521-1-git-send-email-peng.fan@nxp.com>
References: <1514641999-20521-1-git-send-email-peng.fan@nxp.com>
Message-ID: <1514641999-20521-2-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two states in i.MX6Q cpuidle driver.
state[1]: ARM WFI mode
state[2]: i.MX6Q WAIT mode

Take i.MX6DL as example, think out such a case:
1. CPU0/1 both run at normal mode
2. On CPU0, `sleep 1` is executed. And there are no workload on CPU1.
3. CPU0 first runs into state[2] and 'wfi' instruction. Switched to use
   GPT broadcast.
4. CPU1 runs into state[2] and configure CCM to WAIT MODE,
   then 'wfi' instruction. Now arm_clk and local timer clock are
   shutdown. Switched to use GPT broadcast
5. GPT broadcast timer interrupt comes to GPC/GIC, then CPU0 wakes up.
   CPU0 switched to use arm local timer. CPU1 is still sleeping.
6. No workload on CPU0, CPU0 runs into state[1]. But CCM register
   is still not restored to Normal RUN mode. 'wfi' + CCM WAIT will
   cause arm_clk and arm core clk.
   Now CPU0 stops, which is not correct.

So, need to make sure CCM configured to RUN mode when any cpu exit
state[2].

In this patch,
When CPU exits state[2], it configures CCM to RUN mode.
When all CPUs enters state[2], the last CPU needs to check
whether it's ok to configure CCM to WAIT mode or not.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 This is to upstream patch:
 http://git.freescale.com/git/cgit.cgi/imx/linux-imx.git/commit/?h=imx_4.9.11_1.0.0_ga&id=0d980646ee068b92db71fd5e4e4efcbc33749cbd

 arch/arm/mach-imx/cpuidle-imx6q.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index bfeb25aaf9a2..4d342e2fdfe6 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -30,6 +30,8 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
 		if (!spin_trylock(&master_lock))
 			goto idle;
 		imx6_set_lpm(WAIT_UNCLOCKED);
+		if (atomic_read(&master) != num_online_cpus())
+			imx6_set_lpm(WAIT_CLOCKED);
 		cpu_do_idle();
 		imx6_set_lpm(WAIT_CLOCKED);
 		spin_unlock(&master_lock);
@@ -41,6 +43,7 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
 done:
 	atomic_dec(&master);
 
+	imx6_set_lpm(WAIT_CLOCKED);
 	return index;
 }
 
-- 
2.14.1
