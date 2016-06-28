From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 17:27:56 +0100
Subject: [PATCH v6] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <20160628153346.GF4585@e104818-lin.cambridge.arm.com>
References: <1466507556-9027-1-git-send-email-suzuki.poulose@arm.com>
 <20160628153346.GF4585@e104818-lin.cambridge.arm.com>
Message-ID: <20160628162755.GR31744@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 04:33:46PM +0100, Catalin Marinas wrote:
> On Tue, Jun 21, 2016 at 12:12:36PM +0100, Suzuki K. Poulose wrote:
> > +#define CPUINFO_ATTR_RO(_name)							\
> > +	static ssize_t show_##_name(struct device *dev,				\
> > +			struct device_attribute *attr, char *buf)		\
> > +	{									\
> > +		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, dev->id);	\
> > +										\
> > +		if (info->reg_midr)						\
> > +			return sprintf(buf, "0x%016x\n", info->reg_##_name);	\
> > +		else								\
> > +			return 0;						\
> > +	}									\
> > +	static DEVICE_ATTR(_name, 0444, show_##_name, NULL)
> > +
> > +CPUINFO_ATTR_RO(midr);
> > +CPUINFO_ATTR_RO(revidr);
> 
> Since exposing these values is aimed at JIT code (and not human
> readable), wouldn't it make more sense to present the binary value
> instead of the ascii transformation?

Per Documentation/filesystems/sysfs.txt, attributes should be ASCII text
files, with one value per file. I think they should stay as they are.

Thanks,
Mark.
