From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 18:18:57 +0100
Subject: [RFC 3/5] regulator: core: Only apply constraints if available
 on list voltage
In-Reply-To: <1406651339-28901-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140729171857.GV17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 06:28:57PM +0200, Javier Martinez Canillas wrote:
> If a selector can't be used on a platform due to voltage constraints,
> regulator_list_voltage() returns 0. Doing this unconditionally made
> sense since constraints were set in machine_constraints_voltage() at
> regulator registration time.
> 
> But for load switches that don't define a voltage output, the parent
> supply voltage is used so the constraints should only be applied if
> they were defined for the child regulators.

No, think about what you're doing here and why we're filtering out
unsettable voltages - this causes problems for consumers on regulators
that don't have any ability to vary voltages since they will now be able
to list voltages that they can't select.  

I would also expect any regulator where the supplied devices are able to
vary the voltage to explicitly provide a constraint even if the
implementation is done in a parent regulator.  There may be constraints
on the child supply which aren't directly present on the parent supply
and can be ignored if the child supply is turned off.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/015c4ddf/attachment.sig>
