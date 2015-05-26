From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 26 May 2015 10:21:24 +0530
Subject: [PATCH V5 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <555D6E77.3060206@ti.com>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <4690ad854263d6553debab67d65d230105c206ec.1432091956.git.viresh.kumar@linaro.org>
 <555D6E77.3060206@ti.com>
Message-ID: <20150526045124.GH23464@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-05-15, 00:34, Nishanth Menon wrote:
> > +	cpu0_opp0: opp0 {
> 
> Maybe we should rename these as cpu0_opp_table_slow opp_table-fast
> 
> > +		compatible = "operating-points-v2";
> > +		opp-name = "opp-slow";
> 
> just name = "slow" ?
> 
> > +		opp-shared;
> > +
> > +		entry00 {
> 
> rename these as opp0, opp01 etc?
> these are the actual OPP description, while, what we call "cpu0_opp0" is
> actually an OPP table choice we have.

What about this now:
+Example 5: Multiple OPP tables
+
+/ {
+       cpus {
+               cpu at 0 {
+                       compatible = "arm,cortex-a7";
+                       ...
+
+                       opp-supply = <&cpu_supply>
+                       operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
+               };
+       };
+
+       cpu0_opp_table_slow: opp_table_slow {
+               compatible = "operating-points-v2";
+               opp-name = "slow";
+               opp-shared;
+
+               opp00 {
+                       opp-hz = <600000000>;
+                       ...
+               };
+
+               opp01 {
+                       opp-hz = <800000000>;
+                       ...
+               };
+       };
+
+       cpu0_opp_table_fast: opp_table_fast {
+               compatible = "operating-points-v2";
+               opp-name = "fast";
+               opp-shared;
+
+               opp10 {
+                       opp-hz = <1000000000>;
+                       ...
+               };
+
+               opp11 {
+                       opp-hz = <1100000000>;
+                       ...
+               };
+       };
+};

May I carry your Ack or you want to give it again?

-- 
viresh
