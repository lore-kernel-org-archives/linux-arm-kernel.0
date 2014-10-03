From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Oct 2014 12:19:16 +0100
Subject: [RFC PATCH 3/4] arm64:thunder: Add initial dts for Cavium
 Thunder SoC in 2 Node topology.
In-Reply-To: <1411635840-24038-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1411635840-24038-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <20141003111916.GF26643@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 10:03:58AM +0100, Ganapatrao Kulkarni wrote:
> adding devicetree definition for thunder's 2 node topology.
> Defined cpu-map for all 96 cores of 2 node system.

[...]

> +               CPU0: cpu at 000 {
> +                       device_type = "cpu";
> +                       compatible = "cavium,thunder", "arm,armv8";
> +                       reg = <0x0 0x000>;
> +                       enable-method = "psci";
> +               };
> +               CPU1: cpu at 001 {
> +                       device_type = "cpu";
> +                       compatible = "cavium,thunder", "arm,armv8";
> +                       reg = <0x0 0x001>;
> +                       enable-method = "psci";
> +               };

This is going to take up an awful lot of space.  Perhaps we should follwo ePAPR
and allow for common properties to go in /cpus (as I believe we do for arm). We
might not be able to do that for device_type given how we detect CPU nodes at
present, but we could certainly do it for the enable-method:

---->8----
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index cce9524..733b3ed 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -54,7 +54,18 @@ static const struct cpu_operations * __init cpu_get_ops(const char *name)
  */
 int __init cpu_read_ops(struct device_node *dn, int cpu)
 {
-       const char *enable_method = of_get_property(dn, "enable-method", NULL);
+       const char *enable_method = NULL;
+       of_property_read_string(dn, "enable-method", &enable_method);
+
+       if (!enable_method) {
+               /*
+                * Perhaps we have a common /cpus/enable-method
+                */
+               struct device_node *cpus = of_get_parent(dn);
+               of_property_read_string(cpus, "enable-method", &enable_method);
+               of_node_put(cpus);
+       }
+
        if (!enable_method) {
                /*
                 * The boot CPU may not have an enable method (e.g. when
---->8----

I don't believe we check the compatible string at the moment, so that should be
safe to make common too.

Mark.
