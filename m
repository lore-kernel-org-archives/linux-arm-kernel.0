From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Wed, 18 Oct 2017 11:37:06 +0100
Subject: [PATCH v2 1/1] arm: topology: remove cpu_efficiency
In-Reply-To: <CAKfTPtARJC161pXeqrz_d5wxqXPLczGCm_dbZ3fW54CAXuDTmQ@mail.gmail.com>
References: <20171012140028.21599-1-dietmar.eggemann@arm.com>
 <20171012140028.21599-2-dietmar.eggemann@arm.com>
 <CAKfTPtARJC161pXeqrz_d5wxqXPLczGCm_dbZ3fW54CAXuDTmQ@mail.gmail.com>
Message-ID: <00d4d98e-3d75-377f-434d-dce47c0629dd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On 17/10/17 13:28, Vincent Guittot wrote:
> Hi Dietmar,
> 
> On 12 October 2017 at 16:00, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> Remove the 'cpu_efficiency/clock-frequency dt property' based solution
>> to set cpu capacity which was only working for Cortex-A15/A7 arm
>> big.LITTLE systems.
>>
>> I.e. the 'capacity-dmips-mhz' based solution is now the only one. It is
>> shared between arm and arm64 and works for every big.LITTLE system no
>> matter which core types it consists of.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Juri Lelli <juri.lelli@gmail.com>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

>> @@ -111,76 +50,15 @@ static void __init parse_dt_topology(void)
>>                         continue;
>>                 }
>>
>> -               if (topology_parse_cpu_capacity(cn, cpu)) {
>> +               if (topology_parse_cpu_capacity(cn, cpu))
>>                         of_node_put(cn);
> 
> We should call the of_node_put unconditionally  to balance the
> of_get_cpu_node, isn't it ?
> Note that this problem is also present without your change

Thanks for the review. Brendan mentioned this the other day already.

I could add an additional patch to the v3 with this code change. What do
you think?

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 15cc131ae387..81ec42333489 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -41,6 +41,7 @@ static void __init parse_dt_topology(void)
                pr_err("No CPU information found in DT\n");
                return;
        }
+       of_node_put(cn);

        for_each_possible_cpu(cpu) {
                /* too early to use cpu->of_node */
@@ -50,8 +51,8 @@ static void __init parse_dt_topology(void)
                        continue;
                }

-               if (topology_parse_cpu_capacity(cn, cpu))
-                       of_node_put(cn);
+               topology_parse_cpu_capacity(cn, cpu);
+               of_node_put(cn);
        }

        topology_normalize_cpu_scale();
