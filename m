From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 16 May 2018 12:23:38 +0100
Subject: [PATCH] arm64: dts: juno: fix graph node unit addresses for
 coresight components
In-Reply-To: <1526466862-19173-1-git-send-email-sudeep.holla@arm.com>
References: <1526466862-19173-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <574f6959-6a84-9e0e-3d89-84d2d75d9191@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 11:34 AM, Sudeep Holla wrote:
> Currently the coresight components graph node unit addresses are 
> continuous for both input and output ports while the "reg"
> properties are restarted for input and output ports separately. This
> results is the following DTC warnings:
> 
> (graph_port): /etf at 20010000/ports/port at 1: graph node unit address
> error, expected "0" (graph_port): /etf at 20140000/ports/port at 1: graph
> node unit address error, expected "0" (graph_port):
> /funnel at 20040000/ports/port at 1: graph node unit address error,
> expected "0" (graph_port): /funnel at 20040000/ports/port at 2: graph node
> unit address error, expected "1" (graph_port):
> /funnel at 20040000/ports/port at 3: graph node unit address error,
> expected "2" (graph_port): /funnel at 20130000/ports/port at 1: graph node
> unit address error, expected "0" (graph_port):
> /funnel at 20150000/ports/port at 1: graph node unit address error,
> expected "0" (graph_port): /funnel at 20150000/ports/port at 2: graph node
> unit address error, expected "1" (graph_port):
> /funnel at 220c0000/ports/port at 1: graph node unit address error,
> expected "0" (graph_port): /funnel at 220c0000/ports/port at 2: graph node
> unit address error, expected "1" (graph_port):
> /funnel at 230c0000/ports/port at 1: graph node unit address error,
> expected "0" (graph_port): /funnel at 230c0000/ports/port at 2: graph node
> unit address error, expected "1" (graph_port):
> /funnel at 230c0000/ports/port at 3: graph node unit address error,
> expected "2" (graph_port): /funnel at 230c0000/ports/port at 4: graph node
> unit address error, expected "3" (graph_port):
> /replicator at 20120000/ports/port at 2: graph node unit address error,
> expected "0"
> 
> This patch makes even the reg property to follow the continuous 
> numbering as in the graph node unit address.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com> Cc: Mathieu Poirier
> <mathieu.poirier@linaro.org> Cc: Liviu Dudau <liviu.dudau@arm.com> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>> --- 
> arch/arm64/boot/dts/arm/juno-base.dtsi    | 20 ++++++++++---------- 
> arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  8 ++++---- 
> arch/arm64/boot/dts/arm/juno.dts          |  2 +- 3 files changed, 15
> insertions(+), 15 deletions(-)
> 
> Hi Suzuki/Mathieu,
> 
> I did a quick scan @ drivers/hwtracing/coresight/of_coresight.c to
> check if reg field is being used or not and whether this change
> causes any regression. I don't think so, but I may be wrong, let me
> know.

Unfortunately, I think this would break the components like funnel,
where we need the input port number for the connected master to enable
the port. Similarly for the output port number for master components in
the paths. I have a set of patches which address this by taking care of
the port number order to find out the hardware port number.

I will dust it up and send it. That would bring up another important
question.

How do we deal with the change in the port number scheme ? e.g, should
the new kernel support DTBs with old scheme ? If so, how do we specify
that the DT uses new scheme.

Cheers
Suzuki
