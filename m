From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Jun 2014 16:49:31 +0100
Subject: [PATCH 3/5] regulator: axp20x: Update the bindings to use a
 local parent regulator
In-Reply-To: <20140605142729.GG5765@lukather>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401297069-7423-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140528185051.GB22488@sirena.org.uk>
 <20140603131204.GJ27722@lukather>
 <20140603144319.GD31751@sirena.org.uk>
 <20140605142729.GG5765@lukather>
Message-ID: <20140605154931.GY2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 04:27:29PM +0200, Maxime Ripard wrote:

> You already list the regulators available and their supply in the
> regulator driver, why do you need to set the regulator parents in the
> mfd driver as well?

Unless they're being used by the MFD directly there should be no need
for the MFD to know anything about the supplies.

> My guess is that it's to work around the fact that
> regulator_dev_lookup only looks for the regulator's device of_node (so
> not the PMIC one, but one of its child), which doesn't have the supply
> properties, and then just falls back on the regulator alias
> list. Would it make some sense to add a lookup in the parent device
> of_node (which would be the "main" PMIC node in our case)?

This sounds like you are passing the MFD child device into the regulator
API when you should be passing the parent device in.

> Also, there's also the fact that all the supply properties seems to
> also be mandatory in the DT, even though the regulator itself might
> not be used at all on the board, and the input voltage not wired to
> anything.

For electrical engineering reasons it's unlikely that the supplies are
actually floating but yes, they are mandatory.  This is an issue with
registering one device for the entire regulator subsystem on the PMIC,
it interacts somewhat poorly with deferred probe.  However for systems
with full constraints like DT and ACPI ones it should be mostly
sidestepped since the if there is no supply mapped a dummy supply will
be substituted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140605/84478cc3/attachment.sig>
