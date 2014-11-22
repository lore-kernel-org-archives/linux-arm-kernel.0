From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 21 Nov 2014 16:16:55 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141121235436.GQ3815@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141121235436.GQ3815@sirena.org.uk>
Message-ID: <20141122001654.GA15068@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 21 Nov 15:54 PST 2014, Mark Brown wrote:

> On Fri, Nov 21, 2014 at 03:43:54PM -0800, Stephen Boyd wrote:
> 
> > This sleep set/active set stuff has to do with more than just
> > regulators. It applies to any resource that the RPM provides, but
> > regulators are a primary use case so you're on Cc and it would be great
> > if you fully understood the regulator aspect here.
> 
> Step back: what is the RPM?  Some kind of power management coprocessor
> from the sounds of it?

Correct, it's a coprocessor that does the actual poking of the PMIC.

To each processor in the SoC it exposes a set of resources, e.g. regulators.
Each resource is represented by two set of properties, the active and the sleep
state sets. The selection between the two state sets are basically controlled
by the CPU being in WFI (wait-for-interrupt) or not.

The qcom_rpm-regulator.c (and rfc for qcom_smd-regulator.c) that we have in the
tree only pokes the active state and we end up leaving certain regulators as
always-on; due to the fact that we're clocked off PLLs powered by them.

To further complicate matters these regulators are also used to power
peripherals, so enable is not 1:1 with WFI, but rather depends on other
consumers.

My proposal was to flag these regulators so that we write the active/sleep
states in a way that they will be turned off on WFI, iff the regulator isn't
enabled. But as Stephen pointed out, this might not be enough.

Regards,
Bjorn
