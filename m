From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jun 2016 13:37:42 +0100
Subject: [PATCH] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <575EA0DC.2080801@arm.com>
References: <1465571984-18776-1-git-send-email-suzuki.poulose@arm.com>
 <20160610170220.GC23223@arm.com> <575EA0DC.2080801@arm.com>
Message-ID: <20160613123742.GD1605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 01:02:36PM +0100, Suzuki K Poulose wrote:
> On 10/06/16 18:02, Will Deacon wrote:
> >On Fri, Jun 10, 2016 at 04:19:44PM +0100, Suzuki K Poulose wrote:
> >>From: Steve Capper <steve.capper@linaro.org>
> >>
> >>It can be useful for JIT software to be aware of MIDR_EL1 and
> >>REVIDR_EL1 to ascertain the presence of any core errata that could
> >>affect codegen.
> >>
> >>This patch exposes these registers through sysfs:
> >>
> >>/sys/devices/system/cpu/cpu$ID/identification/midr
> >>/sys/devices/system/cpu/cpu$ID/identification/revidr
> 
> 
> >>+
> >>+#define CPUINFO_ATTR_RO(_name)							\
> >>+	static ssize_t show_##_name (struct device *dev,			\
> >>+			struct device_attribute *attr, char *buf)		\
> >>+	{									\
> >>+		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, dev->id);	\
> >>+		if (!cpu_present(dev->id))					\
> >>+			return -ENODEV;						\
> >>+										\
> >>+		if (info->reg_midr)						\
> >>+			return sprintf(buf, "0x%016x\n", info->reg_##_name);	\
> >
> >Should this be 0x%08x, as these are 32-bit registers?
> 
> Yes. Will change it. As per Mark's comments, I can change them to 64bit in
> a separate patch

No -- this is a sysfs ABI and I think we should be consistent from the
beginning. I'm fine with having them 64-bit, since Mark's comments make
sense, but a comment justifying that would be a good idea.

Will
