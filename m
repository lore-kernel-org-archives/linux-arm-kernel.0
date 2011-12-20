From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Dec 2011 15:21:37 +0000
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <20111220015934.GD15863@b20223-02.ap.freescale.net>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <4EEF519C.4090808@gmail.com>
 <20111220015934.GD15863@b20223-02.ap.freescale.net>
Message-ID: <201112201521.37747.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 December 2011, Richard Zhao wrote:
> > >>>> +Generic cpufreq driver
> > >>>> +
> > >>>> +Required properties in /cpus/cpu at 0:
> > >>>> +- compatible : "generic-cpufreq"
> > >>>
> > >>> I'm not convinced this is the best way to do this.  By requiring a 
> > >>> generic-cpufreq compatible string we're encoding Linux driver 
> > >>> information into the hardware description.  The only way I can see to 
> > >>> avoid this is to provide a generic_clk_cpufreq_init() function that 
> > >>> platforms can call in their machine init code to use the driver.
> > 
> > Agreed on the compatible string.
> Assume you reject to use compatible string.
> > It's putting Linux specifics into DT.
> > 
> > You could flip this around and have the module make a call into the
> > kernel to determine whether to initialize or not. Then platforms could
> > set a flag to indicate this.
> Could you make it more clear? kernel global variable, macro, or function?
> 
> - Following your idea, I think, we can add in driver/cpufreq/cpufreq.c:
> int (*clk_reg_cpufreq_get_op_table) (struct op_table *tbl, int *size);
> SoC code set the callback. If it's NULL, driver will exit. We can get rid
> of DT. It'll make cpufreq core dirty, but it's the only file built-in.
> 
> - Drop module support. SoC call generic_clk_cpufreq_init as Jamie said.

I think you don't actually need a "compatible" property here, as long as we
ensure that the "cpu-freqs", "cpu-volts" and "trans-latency" properties are
present in the cpu node if and only if the machine works with this driver
(why else would you put them there?).

CPUs are special in the device trees in a number of ways, so I think we
can treat this as a logical extension. This way, you can still make the
generic cpufreq driver a loadable module. You don't get module autoloading
with this structure, but that is already the case because the cpu nodes
in the device tree are not translated into linux devices.

	Arnd
