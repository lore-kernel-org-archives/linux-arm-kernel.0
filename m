From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 28 Dec 2011 20:05:20 +0800
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111228114237.GF24405@opensource.wolfsonmicro.com>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
 <20111228031409.GL15863@b20223-02.ap.freescale.net>
 <20111228033128.GM15863@b20223-02.ap.freescale.net>
 <20111228114237.GF24405@opensource.wolfsonmicro.com>
Message-ID: <20111228120517.GA1691@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 11:42:37AM +0000, Mark Brown wrote:
> On Wed, Dec 28, 2011 at 11:31:29AM +0800, Richard Zhao wrote:
> > On Wed, Dec 28, 2011 at 11:14:10AM +0800, Richard Zhao wrote:
> 
> > > > +		if (cpu_reg) {
> > > > +			ret = regulator_is_supported_voltage(cpu_reg,
> > > > +					cpu_volts[i * 2], cpu_volts[i * 2 + 1]);
> 
> > > Is there any reason you didn't export symbol regulator_is_supported_voltage?
> > > and also it don't have !REGULATOR dummy implementation.
> 
> > regulator_set_voltage_time and some other functions don't have dummy one
> > either.
> 
> You can't usefully work with voltages without knowing what the actual
> voltages are - the only sensible stubs we could provide would return
> errors but then any driver using the stubs would probably fail to do
> whatever it was doing.  With enable and disable we can sensibly stub
> things out with an always on regulator.
Sorry, I can not get your point here. Let me describe the problem I met:
 - regulator_is_supported_voltage is not exported. when I build clk-reg-cpufreq
   as kernel module, there's a link error.
 - I saw linux/regulator/consumer.h has some dummy functions if !REGULATOR. I
   tried to make clk-reg-cpufreq driver work even !REGULATOR. I think that's
   why the dummy functions are there. If regulator_get return NULL, it'll avoid
   calling other regulator functions. But regulator_is_supported_voltage and
   regulator_set_voltage_time don't have such dummy ones. Undefined functions.

Thanks
Richard
