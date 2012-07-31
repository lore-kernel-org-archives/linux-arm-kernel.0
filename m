From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jul 2012 12:20:52 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120730185344.GT4468@opensource.wolfsonmicro.com>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120726131121.GB7306@sirena.org.uk>
 <20120730065218.GB31509@S2101-09.ap.freescale.net>
 <20120730185344.GT4468@opensource.wolfsonmicro.com>
Message-ID: <20120731042050.GF762@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 07:53:45PM +0100, Mark Brown wrote:
> Quite honestly this seems totally unrealistic for the majority of users,

I doubt that.  Searching drivers/cpufreq folder, I can see there are
several cpufreq drivers scaling voltage with regulator API, but none
of them is calling regulator_set_voltage_time to find voltage latency.
That said, all these users are specify transition latency on their own.

> especially given the very poor documentation for this stuff which SoC
> vendors typically provide.  It's a reasonable amount of work to go back
> and figure this stuff out (especially given that it should be varying
> depending on the transition in question), and it's going to give us a
> bunch of magic numbers in people's bindings.
> 
There will be only one magic number, and it can easily become "magic"
with some comments put there.

> No, add a new API.
> 
Is the following patch what you are ordering here?

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index da339fd..bfd3cfb 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -352,4 +352,11 @@ static inline void regulator_set_drvdata(struct regulator *regulator,

 #endif

+static inline int regulator_set_voltage_tolerance(struct regulator *regulator,
+                                                 int new_uV, int tol_uV)
+{
+       return regulator_set_voltage(regulator,
+                                    new_uV - tol_uV, new_uV + tol_uV);
+}
+
 #endif

-- 
Regards,
Shawn
