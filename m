From: broonie@kernel.org (Mark Brown)
Date: Sun, 16 Feb 2014 09:39:56 +0800
Subject: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140216013956.GV4451@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 02:17:53PM +0000, Lorenzo Pieralisi wrote:

> +According to the Server Base System Architecture document (SBSA, [3]), the
> +power states an ARM CPU can be put into are identified by the following list:

> +1 - Running
> +2 - Idle_standby
> +3 - Idle_retention
> +4 - Sleep
> +5 - Off

> +ARM platforms implement the power states specified in the SBSA through power
> +management schemes that allow an OS PM implementation to put the processor in
> +different idle states (which include states 1 to 4 above; "off" state is not
> +an idle state since it does not have wake-up capabilities, hence it is not
> +considered in this document).

This is explicitly talking about SBSA - is there any restriction with
regard to non-SBSA systems?  I can't think of any right now and this
seems purely informational but it might be worth mentioning that
non-SBSA systems might potentially have other states if the intention is
to allow that.

> +- state node
> +
> +	Description: must be child of either the cpu-idle-states node or
> +		     a state node.
> +
> +	The state node name shall be "stateN", where N = {0, 1, ...} is
> +	the node number; state nodes which are siblings within a single common
> +	parent node must be given a unique and sequential N value, starting
> +	from 0.

This came up with the CPU bindings as well but I'm really not convinced
that making the naming of the nodes important is great - it's not normal
for DT and it makes the usual enumeration code not work.  Can we not
just have a property for state number in the node instead and allow the
name to be anything?  It seems we even have the index property
already...

> +	- compatible
> +		Usage: Required
> +		Value type: <stringlist>
> +		Definition: Must be "arm,cpu-idle-state".

Do we really need this given that the location in the tree is fixed -
what would we extend it with in future?

> +	- index
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: It represents an idle state index, starting from 2.
> +			    Index 0 represents the processor state "running"
> +			    and index 1 represents processor mode
> +			    "idle_standby", entered by executing a wfi
> +			    instruction (SBSA,[3]); indexes 0 and 1 are
> +			    standard ARM states that need not be described.

...but other numbers are valid.

> +	- entry-method
> +		Usage: Required
> +		Value type: <stringlist>
> +		Definition: Describes the method by which a CPU enters the
> +			    idle state. This property is required and must be
> +			    one of:
> +
> +			    - "arm,psci-cpu-suspend"
> +			      ARM PSCI firmware interface, CPU suspend
> +			      method[2].
> +
> +			    - "[vendor],[method]"
> +			      An implementation dependent string with
> +			      format "vendor,method", where vendor is a string
> +			      denoting the name of the manufacturer and
> +			      method is a string specifying the mechanism
> +			      used to enter the idle state.

Might be worth reversing these - arm,psci-cpu-suspend is just an example
of a (hopefully very widely used) vendor method.  Given that everyone is
supposed to be using PSCI might it even be worth making it the default
and the property optional?

> +	- power-state
> +		Usage: See definition.
> +		Value type: <u32>
> +		Definition: Depends on the entry-method property value.
> +			    If entry-method is "arm,psci-cpu-suspend":
> +				# Property is required and represents
> +				  psci-power-state parameter. Please refer to
> +				  [2] for PSCI bindings definition.

Should we just have the entry method nodes define their own properties
for this stuff?  I guess this goes back to the comment I made on some
other binding that it might be cleaner to have an explicit PSCI binding
rather than put PSCI explicitly in indiidual bindings.

> +	- entry-latency
> +		Usage: Required
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing worst case latency
> +			    in microseconds required to enter the idle state.

Why is this defined as an array?

> +	- cache-state-retained
> +		Usage: See definition
> +		Value type: <none>
> +		Definition: if present cache memory is retained on power down,
> +			    otherwise it is lost.

Might be better to define which caches?

> +		STATE1: state1 {
> +			compatible = "arm,cpu-idle-state";

Even if we stick with the node name being meaningful it'd be nice to
replace the STATEN here with a meaningful state name to improve
legibility.  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140216/4f3cc2da/attachment.sig>
