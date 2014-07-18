From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 18 Jul 2014 12:10:08 +0530
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
Message-ID: <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2014 11:47, Olof Johansson <olof@lixom.net> wrote:
> Why complicate it by using two properties?
>
> If there is no property, then the CPUs are assumed to be controlled
> independently.
>
> if there is a clock-master = <phandle> property, then that points at
> the cpu that is the main one controlling clock for the group.
>
> There's really no need to label the master -- it will be the only one
> with incoming links but nothing outgoing. And a master without slaves
> is an independently controlled cpu so you should be fine in that
> aspect too.

I thought so earlier, but then I remembered something I read long back.
Don't remember which thread now, but I *might* be wrong..

"Bindings are like APIs and new bindings shouldn't break existing stuff.."

And:

> If there is no property, then the CPUs are assumed to be controlled
> independently.

seems to break the existing API.

But if that isn't the case, the bindings are very simple & clear to handle.
Diff for new bindings:

diff --git a/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
b/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
index 30ce9ad..d127bba 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
@@ -9,15 +9,14 @@ Clock lines may or may not be shared among different
CPUs on a platform.
     separate line for itself

 Optional Properties:
-- clock-master: This declares cpu as clock master. Other CPUs can either define
-  "clock-ganged" or "clock-master" property, but shouldn't be missing both.
+- clock-master: Contains phandle of the master cpu controlling clocks.

-- clock-ganged: Should have phandle of a cpu declared as "clock-master".
-
-If any cpu node, doesn't have both "clock-master" and "clock-ganged" properties
-defined, it would be assumed that all CPUs on that platform share a
single clock
-line. This will help supporting already upstreamed platforms.
+  Ideally there is nothing like a "master" CPU as any CPU can play with DVFS
+  settings. But we have to choose one cpu out of a group, so that others can
+  point to it.

+  If there is no "clock-master" property for a cpu node, it is considered as
+  master. It may or may not have other slave CPUs pointing towards it.

 Examples:
 1.) All CPUs share a single clock line
@@ -30,34 +29,6 @@ cpus {
                compatible = "arm,cortex-a15";
                reg = <0>;
                next-level-cache = <&L2>;
-               clock-master;
-               operating-points = <
-                       /* kHz    uV */
-                       792000  1100000
-                       396000  950000
-                       198000  850000
-               >;
-               clock-latency = <61036>; /* two CLK32 periods */
-       };
-
-       cpu1: cpu at 1 {
-               compatible = "arm,cortex-a15";
-               reg = <1>;
-               next-level-cache = <&L2>;
-               clock-ganged = <&cpu0>;
-       };
-};
-
-OR (clock-master/ganged aren't defined)
-
-cpus {
-       #address-cells = <1>;
-       #size-cells = <0>;
-
-       cpu0: cpu at 0 {
-               compatible = "arm,cortex-a15";
-               reg = <0>;
-               next-level-cache = <&L2>;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
@@ -71,6 +42,7 @@ cpus {
                compatible = "arm,cortex-a15";
                reg = <1>;
                next-level-cache = <&L2>;
+               clock-master = <&cpu0>;
        };
 };

@@ -83,7 +55,6 @@ cpus {
                compatible = "arm,cortex-a15";
                reg = <0>;
                next-level-cache = <&L2>;
-               clock-master;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
@@ -97,7 +68,6 @@ cpus {
                compatible = "arm,cortex-a15";
                reg = <1>;
                next-level-cache = <&L2>;
-               clock-master;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
@@ -119,7 +89,6 @@ cpus {
                compatible = "arm,cortex-a15";
                reg = <0>;
                next-level-cache = <&L2>;
-               clock-master;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
@@ -133,14 +102,13 @@ cpus {
                compatible = "arm,cortex-a15";
                reg = <1>;
                next-level-cache = <&L2>;
-               clock-ganged = <&cpu0>;
+               clock-master = <&cpu0>;
        };

        cpu2: cpu at 100 {
                compatible = "arm,cortex-a7";
                reg = <100>;
                next-level-cache = <&L2>;
-               clock-master;
                operating-points = <
                        /* kHz    uV */
                        792000  950000
@@ -154,6 +122,6 @@ cpus {
                compatible = "arm,cortex-a7";
                reg = <101>;
                next-level-cache = <&L2>;
-               clock-ganged = <&cpu2>;
+               clock-master = <&cpu2>;
        };
 };
