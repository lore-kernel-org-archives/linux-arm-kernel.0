From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 22 Sep 2015 12:46:54 -0700
Subject: [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock
 implementation details
In-Reply-To: <1442723397-26329-6-git-send-email-scottwood@freescale.com>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <1442723397-26329-6-git-send-email-scottwood@freescale.com>
Message-ID: <20150922194654.GJ24314@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-09-15, 23:29, Scott Wood wrote:
> Get the CPU clock's potential parent clocks from the clock interface
> itself, rather than manually parsing the clocks property to find a
> phandle, looking at the clock-names property of that, and assuming that
> those are valid parent clocks for the cpu clock.
> 
> This is necessary now that the clocks are generated based on the clock
> driver's knowledge of the chip rather than a fragile device-tree
> description of the mux options.
> 
> We can now rely on the clock driver to ensure that the mux only exposes
> options that are valid.  The cpufreq driver was currently being overly
> conservative in some cases -- for example, the "min_cpufreq =
> get_bus_freq()" restriction only applies to chips with erratum
> A-004510, and whether the freq_mask used on p5020 is needed depends on
> the actual frequencies of the PLLs (FWIW, p5040 has a similar
> limitation but its .freq_mask was zero) -- and the frequency mask
> mechanism made assumptions about particular parent clock indices that
> are no longer valid.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v3: was patch 1/5 and patch 4/5, plus blacklist e6500 and changes
> to clk api usage
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 137 ++++++++++++----------------------------
>  1 file changed, 40 insertions(+), 97 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
