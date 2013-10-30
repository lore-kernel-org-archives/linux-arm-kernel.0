From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 30 Oct 2013 11:49:12 +0000
Subject: [PATCH -next v2] arm64: use for_each_node_by_type() macro
In-Reply-To: <CAPgLHd_r3_svSfrraO-oHyZbXg0O9brsjheO6ds9jL9rYbOfmA@mail.gmail.com>
References: <CAPgLHd_aQROa0-vycghYz9A9Jx4MbC131C819xPHZg_hrTQC7w@mail.gmail.com>
 <52709A9E.8060800@gmail.com>
 <CAPgLHd_r3_svSfrraO-oHyZbXg0O9brsjheO6ds9jL9rYbOfmA@mail.gmail.com>
Message-ID: <5270F238.6010602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/13 05:54, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Use for_each_node_by_type() macro instead of open coding it.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> v1 -> v2: remove extra space
> ---
>  arch/arm64/kernel/cpu_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index aa0c9e7..37a4977 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -78,10 +78,10 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>  
>  void __init cpu_read_bootcpu_ops(void)
>  {
> -	struct device_node *dn = NULL;
> +	struct device_node *dn;
>  	u64 mpidr = cpu_logical_map(0);
>  
> -	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> +	for_each_node_by_type(dn, "cpu") {
>  		u64 hwid;
>  		const __be32 *prop;
>  

In fact this function can be simplified by making use of OF helper directly,
something like below snippet. But it requires [1] for correct functionality.

Regards,
Sudeep

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/206401.html

-->8
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index de78d22..f297a18 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -73,22 +73,10 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)

 void __init cpu_read_bootcpu_ops(void)
 {
-       struct device_node *dn = NULL;
-       u64 mpidr = cpu_logical_map(0);
-
-       while ((dn = of_find_node_by_type(dn, "cpu"))) {
-               u64 hwid;
-               const __be32 *prop;
-
-               prop = of_get_property(dn, "reg", NULL);
-               if (!prop)
-                       continue;
-
-               hwid = of_read_number(prop, of_n_addr_cells(dn));
-               if (hwid == mpidr) {
-                       cpu_read_ops(dn, 0);
-                       of_node_put(dn);
-                       return;
-               }
+       struct device_node *dn = of_get_cpu_node(0, NULL);
+       if (!dn) {
+               pr_err("failed to find device node for boot cpu\n");
+               return;
        }
+       cpu_read_ops(dn, 0);
 }
