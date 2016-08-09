From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 9 Aug 2016 10:42:38 +0100
Subject: [PATCH v6 4/8] arm64: parse cpu capacity-dmips-mhz from DT
In-Reply-To: <1468932048-31635-5-git-send-email-juri.lelli@arm.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-5-git-send-email-juri.lelli@arm.com>
Message-ID: <20160809094238.GA23236@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patch needs the fix below, since platforms can boot without a
cpu-map.

On 19/07/16 13:40, Juri Lelli wrote:
[...]
> @@ -185,6 +328,8 @@ static int __init parse_dt_topology(void)
>  	if (ret != 0)
>  		goto out_map;
>  
> +	normalize_cpu_capacity();
> +
>  	/*
>  	 * Check that all cores are in the topology; the SMP code will
>  	 * only mark cores described in the DT as possible.
> -- 

--->8---
 arch/arm64/kernel/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 56bbd6d41daf..288f511a5f29 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -394,8 +394,10 @@ static int __init parse_dt_topology(void)
 	 * cluster with restricted subnodes.
 	 */
 	map = of_get_child_by_name(cn, "cpu-map");
-	if (!map)
+	if (!map) {
+		cap_parsing_failed = true;
 		goto out;
+	}
 
 	ret = parse_cluster(map, 0);
 	if (ret != 0)
-- 
2.7.0
