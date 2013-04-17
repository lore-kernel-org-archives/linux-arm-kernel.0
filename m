From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Apr 2013 10:14:58 +0100
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <516C544A.4090107@wwwdotorg.org>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <516C544A.4090107@wwwdotorg.org>
Message-ID: <20130417091457.GB5012@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> > +	- enable-method
> > +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
> > +		       systems
> > +		Value type: <string>
> > +		Definition: On ARM 64-bit systems must be "spin-table" [1].
> 
> Can that be an integer instead? with dtc+cpp support, that shouldn't
> hurt the eyes too much any more.

The "enable-method" property is described as a stringlist by ePAPR, and is
currently in use on arm64 as such. It *must* remain a string(list) for arm64.

Having it as an integer for arm is only going to cause us additional work,
makes it impossible to share a common dt between 64bit and 32bit, and goes
against the standard. I think it should be a stringlist for arm.

> 
> > +	- cpu-release-addr
> > +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
> > +		       systems
> > +		Value type: <prop-encoded-array>
> > +		Definition: On ARM 64-bit systems must be a two cell
> > +			    property identifying a 64-bit zero-initialised
> > +			    memory location [1].
> 
> Presumably that property is required, or not, based on the value of
> enable-method, not based on the ARM architecture or bit-size?

This should be required if the enable-method depends on it. In ePAPR, it's
specified it should be there if the enable-method is "spin-table". We have
(undocumented) PSCI support on arm64 which doesn't require a cpu-release-addr.

> 
> > +[1] ARM Linux kernel documentation
> > +    Documentation/devicetree/bindings/arm64/booting.txt
> 
> Is referencing Linux-specific documentation from a supposedly
> OS-agnostic DT binding definition a good idea?

Once we have the enable-method(s) and their required properties here, we can
invert the dependency and refer to the binding from the Linux documentation.

Mark.
