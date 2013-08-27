From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 27 Aug 2013 15:55:19 -0600
Subject: [PATCH RFC v2 3/5] spmi: add generic SPMI controller binding
 documentation
In-Reply-To: <20130827170120.GR4035@joshc.qualcomm.com>
References: <cover.1377202730.git.joshc@codeaurora.org>
 <e42576b69ef3d4e624fbfa2f32f6f79a931b55d6.1377202730.git.joshc@codeaurora.org>
 <5217DB0C.7000101@wwwdotorg.org> <20130827170120.GR4035@joshc.qualcomm.com>
Message-ID: <521D2047.8030300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2013 11:01 AM, Josh Cartwright wrote:
...
> If we want to ensure for the generic bindings that we are fulling
> characterizing/describing the SPMI bus, then we'll additionally need to
> tackle an additional identified assumption:
> 
>   4. One master per SPMI bus.  (The SPMI spec allows for up to 4
>      masters)
> 
> On the Snapdragon 800 series, there exists only one software-controlled
> master, but it is conceivably possible to have a setup with two
> software-controlled masters on the same SPMI bus.
> 
> This necessarily means that the description of the slaves and the
> masters will need to be decoupled; I'm imagining a generic binding
> supporting multiple masters would look something like this:

Is there a need to represent the other masters in the DT? Sure they're
there in HW, but if there's no specific way for the
CPU-to-which-the-DT-applies to actually interact with those other
masters (except perhaps by experiencing some arbitration delays) then
presumably there's no need to represent the other masters in DT?

> 	master0: master at 0 {
> 		compatible = "...";
> 		#spmi-master-cells = <0>;
> 		spmi-mid = <0>;
> 
> 		...
> 	};
> 
> 	master2: master at 2 {
> 		compatible = "...";
> 		#spmi-master-cells = <0>;
> 		spmi-mid = <2>;
> 
> 		...
> 	};
> 
> 	spmi_bus {
> 		compatible = "...";
> 
> 		spmi-masters = <&master0 &master2>;
> 
> 		foo at 0 {
> 			compatible = "...";
> 			reg = <0 ...>;
> 		};
> 
> 		foo at 8 {
> 			compatible = "...";
> 			reg = <8 ...>;
> 		};
> 	};
> 
> (This will also necessitate a change in the underlying SPMI driver
> model, in the current implementation, a SPMI master 'owns' a particular
> device.  This is not a valid assumption to make.)
> 
> Would this property-containing-phandle-vector be considered the
> canonical way of representing nodes with multiple parents in the device
> tree?

I don't think I've seen anything like this before, although that
in-and-of-itself doesn't make it wrong.

Another approach might be to encode master-vs-slave into a cell in the
reg property? Something like:

cell 0 - address type (0: master, 1: unique ID, 2: group ID, ...)
cell 1 - address value

I haven't thought much about that; perhaps there are disadvantages doing
that.
