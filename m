From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Aug 2014 15:37:16 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <E1XLu15-0002DP-6o@jdl.com>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <20140514141914.446F7C4153D@trevor.secretlab.ca>
 <20140821140211.GD19293@ulmo.nvidia.com>
 <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
 <E1XLu15-0002DP-6o@jdl.com>
Message-ID: <20140825133714.GH4163@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 08:08:59AM -0500, Jon Loeliger wrote:
> > 
> 
> > Anyway, instead of going back and forth between "deferred probe is good"
> > and "deferred probe is bad", how about we do something useful now and
> > concentrate on how to make use of the information we have in DT with the
> > goal to reduce the number of cases where deferred probing is required?
> 
> Good idea.
> 
> The proposal on the table is to allow the probe code
> to make a topological sort of the devices based on
> dependency information either implied, explicitly stated
> or both.  That is likely a fundamentally correct approach.
> 
> I believe some of the issues that need to be resolved are:
> 
>     1) What constitutes a dependency?
>     2) How is that dependency expressed?
>     3) How do we add missing dependencies?
>     4) Backward compatability problems.
> 
> There are other questions, of course.  Is it a topsort
> per bus?  Are there required "early devices"?  Should
> the inter-node dependencies be expressed at each node,
> or in a separate hierarchy within the DTS?  Others.

I think Grant already objected to the idea of explicitly adding
dependency information into the device tree sources. Rather, if I
understand correctly, we should be using the information readily
available (phandle references) as much as possible before resorting to
additional properties.

So far we've been operating under the assumption that a dependency is
modeled as a phandle reference and that the dependent would contain the
phandle reference to the dependency. That's for example how clocks and
regulators (to name only a few) work. A simplified example would look
like this:

	clock: clock at ... {
		...
		#clock-cells = <1>;
		...
	};

	pmic: pmic at ... {
		regulators {
			vdd_foo: ldo0 {
				...
			};

			vdd_bar: ldo1 {
				...
			};
	};

	device at ... {
		vdd-supply = <&vdd_foo>;
		clocks = <&clock 0>;
	};

	device at ... {
		vdd-supply = <&vdd_bar>;
		clocks = <&clock 1>;
	};

There are somewhat standardized bindings for the above and especially
for bindings of the type that clocks implement this is trivial. We can
simply iterate over each (phandle, specifier) tuple and check that the
corresponding clock provider can be resolved (which typically means that
it's been registered with the common clock framework).

For regulators (and regulator-like bindings) the problem is somewhat
more difficult because they property names are not standardized. One way
to solve this would be to look for property names with a -supply suffix,
but that could obviously lead to false positives. One alternative that I
think could eliminate this would be to explicitly list dependencies in
drivers. This would allow core code to step through such a list and
resolve the (phandle, specifier) tuples.

Clocks are usually not a problem with deferred probing since they often
are registered early anyway. Regulators on the other hand seem to be a
fairly common trigger, though, so they seem like a good candidate to
focus on.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/cbe1a06e/attachment.sig>
