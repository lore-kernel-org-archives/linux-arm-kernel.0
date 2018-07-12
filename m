From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu, 12 Jul 2018 15:29:49 +0300
Subject: [PATCH V4 0/5] soc: imx: add scu firmware api support
In-Reply-To: <73f7f126-6497-7ae9-49b2-082fbc18508d@arm.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <24505e51-3a5d-4f34-7ba6-262e118d070e@arm.com>
 <AM0PR04MB42113AC1D31A193E40F259CC80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <73f7f126-6497-7ae9-49b2-082fbc18508d@arm.com>
Message-ID: <c12939870af73a9a8d590a558a3ca7d070fd0b69.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-12 at 11:32 +0100, Sudeep Holla wrote:
> On 12/07/18 04:46, A.s. Dong wrote:
> > Hi Sudeep,
> > > On 08/07/18 15:56, Dong Aisheng wrote:
> > > > Unlike the former i.MX Architectures, the new generation i.MX8 SoCs
> > > > (e.g. MX8QXP and MX8QM) contain a system controller which runs on a
> > > > dedicated Cortex-M core to provide power, clock, Pad, and resource
> > > > management. Communication between the host processor running an OS and
> > > > the system controller happens through a SCU protocol.
> > > > This patchset adds the SCU APIs which is implemented based on MU and
> > > > will be used by different system components.
> > > > 
> > > > It mainly consists of below parts:
> > > > 1) MU mailbox driver
> > > > 1) Implementation of the IPC functions based on MUs (client side).
> > > 
> > > I do understand the firmware might be already released for the current
> > > generation of platforms, but instead of adding to the fragmentation, it would
> > > be good to migrated to ARM SCMI for future platforms.
> > > 
> > > This system controller communication protocol is already so fragmented (we
> > > have TI SCI, QCOM RPM, Nvidia Tegra BPMP, ARM SCPI and so on..
> > > and now this i.MX specific one added to that), the main intention of ARM
> > > SCMI is to stop that. The idea is for any Power Control System
> > > Architecture(PCSA) compliant systems or any similar systems, SCMI should
> > > be the standard communication protocol.
> > 
> > That sounds good and worth a look.
> > Copy SCU firmware guys if more comments.
> > BTW, i.MX SCU provides more services than just power related. 
> > Not sure if ARM SCMI can cover it.
> 
> Sure, we can extend the specification to cover those as generic
> protocols. If they are too NXP specific, then SCMI has options to
> use vendor specific protocols. I am interested to know the requirements.

On major thing that is missing is pin control: on 8qm/8qx this is done
through the SCU but SCMI doesn't define a protocol for this. It would
be a big thing to implement as a vendor extension and is required for
basic functionality. Maybe SCMI will handle this in the future? If SCMI
eventually includes this imx might be asked to rewrite the vendor-
specific stuff anyway.

Another issue is that there doesn't seem to be any way to implement
clk_set_parent through SCMI (SC API does have this). This might be
intentional ("protocol does not cover discovery of clock dependencies,
which must be described through firmware tables instead"). But how
would the "assigned-clock-parents" DT property be implemented through
SCMI?

Even if SCMI doesn't define a clock tree it might be still have
something for explicit clk mux control?

One possible path to eventually using SCMI would be to define a SMC
"transport" and implement SCMI calls inside ATF on top of SC API. This
way ATF would hide clk implementation details in the same way that it
hides hotplug and suspend details. Does this make sense?
