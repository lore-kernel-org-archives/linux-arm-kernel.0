From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 22 Jan 2015 14:29:49 +0800
Subject: [PATCH RFC 1/2] Documentation: arm: define DT bindings for
 system suspend
In-Reply-To: <20150122123314.0dc44b67@xhacker>
References: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
 <1421840155-18990-2-git-send-email-sudeep.holla@arm.com>
 <20150121212139.1cdc3fd5@xhacker> <20150121213507.695b871b@xhacker>
 <20150121135610.GA21950@e102568-lin.cambridge.arm.com>
 <20150122123314.0dc44b67@xhacker>
Message-ID: <20150122142949.64c41db6@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lorenzo and Sudeep,

On Wed, 21 Jan 2015 20:33:14 -0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> Dear Lorenzo,
> 
> On Wed, 21 Jan 2015 05:56:11 -0800
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Wed, Jan 21, 2015 at 01:35:07PM +0000, Jisheng Zhang wrote:
> > > Dear Sudeep,
> > > 
> > > On Wed, 21 Jan 2015 05:21:39 -0800
> > > Jisheng Zhang <jszhang@marvell.com> wrote:
> > > 
> > > > Dear Sudeep,
> > > > 
> > > > On Wed, 21 Jan 2015 03:35:54 -0800
> > > > Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > 
> > > > > ARM based platforms implement unique ways to enter system suspend
> > > > > (i.e. Suspend to RAM). The mechanism and the parameters defining the
> > > > > system state vary on a per-platform basis forcing the OS to handle
> > > > > it in very platform specific way.
> > > > > 
> > > > > Since ARM 32-bit systems had machine specific code, no attempts to
> > > > > standardize are being made as it provides easy way to implement
> > > > > suspend operations in a platform specific manner. However, this
> > > > > approach not only makes maintainance more difficult as the number of
> > > > > platforms supported increases but also not feasible for ARM64.
> > > > > 
> > > > > This DT binding aims at standardizing the system suspend for ARM
> > > > > platforms. ARM64 platforms mandates entry-method property in DT for
> > > > > this system suspend node.
> > > > > 
> > > > > On system implementing PSCI as an enable-method to enter system
> > > > > suspend, the PSCI CPU suspend method is used on versions upto v0.2
> > > > > and requires the power_state parameter to be passed to the PSCI CPU
> > > > > suspend function.
> > > > > 
> > > > > This parameter is platform specific, therefore must be provided by
> > > > > firmware to the OS in order to enable proper call sequence.
> > > > > 
> > > > > This ARM system suspend DT bindings rely on a property
> > > > > (i.e. arm,psci-suspend-param) in the PSCI DT bindings that describes
> > > > > how the PSCI CPU suspend power_state parameter should be defined in
> > > > > DT.
> > > > > 
> > > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/arm/psci.txt     | 11 +++
> > > > >  .../devicetree/bindings/arm/system-suspend.txt     | 93
> > > > > ++++++++++++++++++++++ 2 files changed, 104 insertions(+)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/arm/system-suspend.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/arm/psci.txt
> > > > > b/Documentation/devicetree/bindings/arm/psci.txt index
> > > > > 5aa40ede0e99..bd3977a2a333 100644 ---
> > > > > a/Documentation/devicetree/bindings/arm/psci.txt +++
> > > > > b/Documentation/devicetree/bindings/arm/psci.txt @@ -61,6 +61,14 @@
> > > > > Device tree nodes that require usage of PSCI CPU_SUSPEND function
> > > > > (ie idle Definition: power_state parameter to pass to the PSCI
> > > > > suspend call. 
> > > > > +PSCI v0.2 and earlier versions don't have explicit operation for
> > > > > system +suspend. However, one can implement system suspend using
> > > > > CPU_SUSPEND by +ensuring every other core except the one executing
> > > > > the CPU_SUSPEND call +has called into PSCI through a CPU_OFF call.
> > > > 
> > > > If users explicitly hot-unplug other cores when system load is low to
> > > > save power, then we want to suspend at some point, how does the
> > > > firmware know this case?
> > > 
> > > Sorry for confusion. I mean 
> > > 
> > > If users explicitly hot-unplug other cores when system load is low to
> > > save power, then at some point cpuidle want to suspend the cluster, how
> > > does the distinguish this case with suspend the system to ram.
> > 
> > Through the arm,psci-suspend-param DT property, ie PSCI CPU_SUSPEND
> > power_state parameter.
> > 
> > Did you read the patch :) ?
> 
> Yep, I do read the patch ;) To be honest, I implemented the s2ram similar as
> the patch does. But according to PSCI v0.2, "arm,psci-suspend-param =
> <0x1010000>" means suspend the cluster. I'm not sure I understand it
> correctly, "can implement system suspend using CPU_SUSPEND by ensuring
> every other core except the one executing the CPU_SUSPEND call has called
> into PSCI through a CPU_OFF call" intend to ask firmware to 
> 
> suspend the system if other cores has called into PSCI through a CPU_OFF
> 
> or
> 
> suspend the cpu cluster if other cores are not CPU_OFF.
> 
> 
> I extend the PSCI CPU_SUSPEND function's to use power_state bit[26] to tell
> firmware whether suspend to ram or not.
> 

I read the PSCI spec again, power_state bit[0:15] is "platform specific ID",
Is one of these bits used for suspend system?

Thanks,
Jisheng
