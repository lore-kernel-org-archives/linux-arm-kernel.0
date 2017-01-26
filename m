From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jan 2017 15:57:25 +0000
Subject: [PATCH] arm64: skip register_cpufreq_notifier on ACPI-based
 systems
In-Reply-To: <20170126155229.GB1194@red-moon>
References: <1485304992-26888-1-git-send-email-pprakash@codeaurora.org>
 <20170126121811.GD14167@arm.com> <20170126155229.GB1194@red-moon>
Message-ID: <20170126155724.GI14167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 03:52:29PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Jan 26, 2017 at 12:18:11PM +0000, Will Deacon wrote:
> > [adding Sudeep and Lorenzo for comment]
> > 
> > On Tue, Jan 24, 2017 at 05:43:12PM -0700, Prashanth Prakash wrote:
> > > On ACPI based systems where the topology is setup using the API
> > > store_cpu_topology, at the moment we do not have necessary code
> > > to handle a cpufreq notifier, thus resulting in a crash.
> > 
> > What is the "necessary code" that we're missing? Wouldn't it be better
> > to add that, or explicitly avoid the cpufreq notifier registration if
> > we're using ACPI?
> 
> Necessary code is, in DT, code parsing bindings to provide capacity
> values and allocate the raw_capacity array; there is no ACPI counterpart
> for those bindings (well..there is a byte length field in the GICC MADT
> entry "Processor Power Efficiency Class" but as far as I understand,
> currently, it would be more reliable as a random seed than a useful
> capacity scale, I just do not know why it is there) so the whole CPUfreq
> notifier thing is basically useless when booting with ACPI.

Ok, thanks for the explanation.

> How about using (or put the ACPI bit in a separate line with a
> comment):
> 
> 	if (!acpi_disabled || cap_parsing_failed)
> 
> to prevent registering the CPUfreq notifier ? Using raw_capacity check
> this patch achieves the same in a much more opaque way (you will have to
> include <linux/acpi.h> to make use of acpi_disabled).

That looks good to me. If somebody sends a v2, I can apply it for 4.11.

Thanks,

Will
